//
//  TKTableViewController.m
//  TaoKeClient
//
//  Created by YueWen on 2017/10/21.
//  Copyright © 2017年 YueWen. All rights reserved.
//

#import "NWTableViewController.h"
#import <Masonry/Masonry.h>
#import <RITLKit/RITLKit.h>

typedef NSString TableViewLayoutConstraintKey;

static const TableViewLayoutConstraintKey* TableViewTop = @"TableViewTop";
static const TableViewLayoutConstraintKey* TableViewBottom = @"TableViewBottom";

@interface NWTableViewController ()

@property (nonatomic, assign)BOOL headerRefresh_Enable;
@property (nonatomic, assign)BOOL footerRefresh_Enable;

@end

@implementation NWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
    [self.view addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(self.tableViewConstraintInsets.left);
        make.right.inset(self.tableViewConstraintInsets.right);
        make.bottom.inset(self.tableViewConstraintInsets.bottom).key(TableViewBottom);
        make.top.offset(self.tableViewConstraintInsets.top).key(TableViewTop);
    }];

    [self tk_addRefreshComponent];//追加刷新组件
}


- (void)loadPropertysAtInitialization
{
    [super loadPropertysAtInitialization];
    
    self.tableViewConstraintInsets = UIEdgeInsetsZero;
    self.currentPage = 1;
    self.totalPage = 1;
    self.headerRefreshEnable = true;
    self.footerRefreshEnable = true;
    
    self.tableView = ({
        
        NWTableView *tableView = [[NWTableView alloc]initWithFrame:CGRectZero style:self.tableViewStyle];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableView.showsVerticalScrollIndicator = false;
        tableView.showsHorizontalScrollIndicator = false;
        
        tableView;
    });
    
    self.tableView.backgroundView = ({
        
        UIView *view = [UIView new];
        view.backgroundColor = self.tableViewBackgroundColor;
        
        view;
    });
}


- (UIColor *)tableViewBackgroundColor
{
    return UIColor.whiteColor;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)didBottom
{
    return self.totalPage < self.currentPage;
}

- (BOOL)isAll
{
    return self.totalPage < self.currentPage;
}


- (UITableViewStyle)tableViewStyle
{
    return UITableViewStyleGrouped;
}



- (MASLayoutConstraint *)tb_topConstraint
{
    return [[self.view.constraints ritl_filter:^BOOL(__kindof NSLayoutConstraint * _Nonnull obj) {
        
        return [obj isKindOfClass:[MASLayoutConstraint class]];
    
    }] ritl_filter:^BOOL(MASLayoutConstraint * _Nonnull obj) {
      
        return [obj.mas_key isEqual:TableViewTop];
        
    }].ritl_safeFirstObject;
}


- (MASLayoutConstraint *)tb_bottomConstraint
{
    return [[self.view.constraints ritl_filter:^BOOL(__kindof NSLayoutConstraint * _Nonnull obj) {
        
        return [obj isKindOfClass:[MASLayoutConstraint class]];
        
    }] ritl_filter:^BOOL(MASLayoutConstraint * _Nonnull obj) {
        
        return [obj.mas_key isEqual:TableViewBottom];
        
    }].ritl_safeFirstObject;
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:true];
}



#pragma mark - 上拉下拉刷新

- (BOOL)headerRefreshEnable
{
    return self.headerRefresh_Enable;
}

- (BOOL)footerRefreshEnable
{
    return self.footerRefresh_Enable;
}

- (void)setHeaderRefreshEnable:(BOOL)headerRefreshEnable
{
    self.headerRefresh_Enable = headerRefreshEnable;
}

- (void)setFooterRefreshEnable:(BOOL)footerRefreshEnable
{
    self.footerRefresh_Enable = footerRefreshEnable;
}



/// 添加刷新组件
- (void)tk_addRefreshComponent
{
    [self installAllRefresh];
}

-(void)installHeaderRefresh
{
    if (!self.tableView.mj_header && self.headerRefreshEnable) {
        
        self.tableView.mj_header = self.refreshHeader;
    }
}

-(void)installFooterRefresh
{
    if (!self.tableView.mj_footer && self.footerRefreshEnable) {
        
        self.tableView.mj_footer = self.refreshFooter;
    }
}

-(void)installAllRefresh
{
    [self installHeaderRefresh];
    [self installFooterRefresh];
}

-(void)unstallHeaderRefresh
{
    if (self.tableView.mj_header) {
        
        self.tableView.mj_header = nil;
        [self.tableView.mj_header removeFromSuperview];
    }
}

-(void)unstallFooterRefresh
{
    if (self.tableView.mj_footer) {
        
        self.tableView.mj_footer = nil;
        [self.tableView.mj_footer removeFromSuperview];
    }
}

-(void)unstallAllRefresh
{
    [self unstallHeaderRefresh];
    [self unstallFooterRefresh];
}


- (Class)classForRefreshHeader
{
    return [MJRefreshStateHeader class];
}

- (Class)classForRefreshFooter
{
    return [MJRefreshBackStateFooter class];
}

- (void)headerRefreshBeginHandler
{
    [self endHeaderRefreshing];
}

- (void)footerRefreshBeginHandler
{
    
}

- (void)endHeaderRefreshing
{
    if (self.tableView.mj_header && self.tableView.mj_header.isRefreshing) {
        [self.refreshHeader endRefreshing];
    }
}

- (void)endFooterRefreshing
{
    if (self.tableView.mj_footer && self.tableView.mj_footer.isRefreshing) {
        [self.refreshFooter endRefreshing];
    }
}

-(MJRefreshHeader *)refreshHeader
{
    if (!_refreshHeader) {
        
        __weak typeof(self) weakSelf = self;
        
        //初始化
        _refreshHeader = [self.classForRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefreshBeginHandler];
        }];
    }
    return _refreshHeader;
}

-(MJRefreshFooter *)refreshFooter
{
    if (!_refreshFooter) {
        
        __weak typeof(self) weakSelf = self;
        
        _refreshFooter = [self.classForRefreshFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefreshBeginHandler];
        }];
        
        _refreshFooter.stateLabel.font = [UIFont systemFontOfSize:12];
        _refreshFooter.stateLabel.textColor = RITLSimpleColorFromIntRBG(179);
        [_refreshFooter setTitle:self.titleForFooterRefreshWithNoMoreData forState:MJRefreshStateNoMoreData];
    }
    
    return _refreshFooter;
}

-(NSString *)titleForFooterRefreshWithNoMoreData
{
    if (!_titleForFooterRefreshWithNoMoreData) {
        return @"-----我是有底线的-----";
    }
    
    return _titleForFooterRefreshWithNoMoreData;
}

//- (BOOL)autoResume
//{
//    return true;
//}

@end
