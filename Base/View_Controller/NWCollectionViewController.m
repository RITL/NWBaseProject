//
//  ETCollectionViewController.m
//  EattaClient
//
//  Created by YueWen on 2017/11/13.
//  Copyright © 2017年 YueWen. All rights reserved.
//

#import "NWCollectionViewController.h"
#import <Masonry/Masonry.h>

@interface NWCollectionViewController ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong, readwrite)UICollectionViewLayout *flowLayout;
@property (nonatomic, assign)BOOL headerRefresh_Enable;
@property (nonatomic, assign)BOOL footerRefresh_Enable;

@end


@implementation NWCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.offset(0);
        
    }];
    
    [self tk_addRefreshComponent];
}

- (void)loadPropertysAtInitialization
{
    [super loadPropertysAtInitialization];
    
    self.currentPage = 1;
    self.totalPage = 1;
    
    self.collectionView = ({
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];

        collectionView.backgroundColor = UIColor.whiteColor;
        collectionView.showsVerticalScrollIndicator = false;
        collectionView.showsHorizontalScrollIndicator = false;
        
        collectionView;
    });
}


- (BOOL)didBottom
{
    return self.totalPage < self.currentPage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewLayout *)flowLayout
{
    if (!_flowLayout) {
        
        _flowLayout = [UICollectionViewFlowLayout new];
    }
    
    return _flowLayout;
}


#pragma mark - UICollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [UICollectionViewCell new];
}


#pragma mark - 上拉下拉刷新
#pragma mark - 刷新

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
    if (!self.collectionView.mj_header && self.headerRefreshEnable) {
        
        self.collectionView.mj_header = self.refreshHeader;
        
    }
}


-(void)installFooterRefresh
{
    if (!self.collectionView.mj_footer && self.footerRefreshEnable) {
        
        self.collectionView.mj_footer = self.refreshFooter;
    }
}


-(void)installAllRefresh
{
    [self installHeaderRefresh];
    [self installFooterRefresh];
}


-(void)unstallHeaderRefresh
{
    if (self.collectionView.mj_header) {
        
        self.collectionView.mj_header = nil;
        [self.collectionView.mj_header removeFromSuperview];
    }
}



-(void)unstallFooterRefresh
{
    if (self.collectionView.mj_footer) {
        
        self.collectionView.mj_footer = nil;
        [self.collectionView.mj_footer removeFromSuperview];
    }
}


-(void)unstallAllRefresh
{
    [self unstallHeaderRefresh];
    [self unstallFooterRefresh];
}



- (Class)classForRefreshHeader
{
    return [MJRefreshNormalHeader class];
}


- (Class)classForRefreshFooter
{
    return [MJRefreshBackStateFooter class];
}


- (void)headerRefreshBeginHandler
{
    
}


- (void)footerRefreshBeginHandler
{
    
}



- (void)endHeaderRefreshing
{
    if (self.collectionView.mj_header && self.collectionView.mj_header.isRefreshing) {
        
        [self.refreshHeader endRefreshing];
    }
}



- (void)endFooterRefreshing
{
    if (self.collectionView.mj_footer && self.collectionView.mj_footer.isRefreshing) {
        
        [self.refreshFooter endRefreshing];
    }
}



-(MJRefreshStateHeader *)refreshHeader
{
    if (!_refreshHeader) {
        
        __weak typeof(self) weakSelf = self;
        
        //初始化
        _refreshHeader = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            
            [weakSelf headerRefreshBeginHandler];
            
        }];
        
        _refreshHeader.lastUpdatedTimeLabel.hidden = true;
        _refreshHeader.stateLabel.hidden = true;
        
    }
    return _refreshHeader;
}




-(MJRefreshBackStateFooter *)refreshFooter
{
    if (!_refreshFooter) {
        
        __weak typeof(self) weakSelf = self;
        
        _refreshFooter = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
            
            [weakSelf footerRefreshBeginHandler];
            
        }];
        
        _refreshFooter.stateLabel.font = [UIFont systemFontOfSize:12];
        [_refreshFooter setTitle:self.titleForFooterRefreshWithNoMoreData forState:MJRefreshStateNoMoreData];
    }
    
    return _refreshFooter;
}




-(NSString *)titleForFooterRefreshWithNoMoreData
{
    if (!_titleForFooterRefreshWithNoMoreData) {
        return @"-----更多内容，敬请期待-----";
    }
    return _titleForFooterRefreshWithNoMoreData;
}


@end
