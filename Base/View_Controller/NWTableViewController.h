//
//  TKTableViewController.h
//  TaoKeClient
//
//  Created by YueWen on 2017/10/21.
//  Copyright © 2017年 YueWen. All rights reserved.
//

#import "NWViewController.h"
#import "NWRefresh.h"
#import "NWTableView.h"
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

/// 基础列表控制器
@interface NWTableViewController : NWViewController <UITableViewDelegate,UITableViewDataSource,NWRefresh>

/// 列表视图
@property (nonatomic, strong) NWTableView *tableView;
/// tableView的背景色，默认为white
@property (nonatomic, strong ,readonly)UIColor *tableViewBackgroundColor;
/// tableView的style, 默认为 UITableViewStyleGrouped
@property (nonatomic, assign, readonly)UITableViewStyle tableViewStyle;
/// 默认为 UIEdgeInsetsZero
@property (nonatomic, assign)UIEdgeInsets tableViewConstraintInsets;

#pragma mark - constraintKey

@property(nonatomic, weak, readonly)NSLayoutConstraint *tb_topConstraint;
@property(nonatomic, weak, readonly)NSLayoutConstraint *tb_bottomConstraint;

#pragma mark - 上拉下拉刷新

/// 当前页码，默认为1
@property (nonatomic, assign) NSInteger currentPage;
/// 总页码，默认为1
@property (nonatomic, assign) NSInteger totalPage;
/// 是否到达底部，是否达到了最大页码,即将废弃，建议all
@property (nonatomic, assign, readonly, getter=didBottom)BOOL bottom __deprecated_msg("please use all instead.");
/// 是否达到了最大页码
@property (nonatomic, assign, readonly, getter=isAll)BOOL all;
/// 下拉组件
@property (nonatomic, strong) MJRefreshNormalHeader *refreshHeader;
/// 上拉组件
@property (nonatomic, strong) MJRefreshBackStateFooter *refreshFooter;
/// 没有更多信息显示字符串
@property (nonatomic, copy) NSString *titleForFooterRefreshWithNoMoreData;


//#pragma mark - Network
///// 是否自动加载默认网络请求
//@property (nonatomic, assign, readonly)BOOL autoResume;

@end


NS_ASSUME_NONNULL_END
