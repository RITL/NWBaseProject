//
//  ETCollectionViewController.h
//  EattaClient
//
//  Created by YueWen on 2017/11/13.
//  Copyright © 2017年 YueWen. All rights reserved.
//

#import "NWViewController.h"
#import "NWRefresh.h"
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface NWCollectionViewController : NWViewController<UICollectionViewDataSource,NWRefresh>

/// 列表视图
@property (nonatomic, strong) UICollectionView *collectionView;
/// 子类可重写布局组件，默认为UICollectionViewFlowLayout
@property (nonatomic, strong, readonly)UICollectionViewLayout *flowLayout;


#pragma mark - 上拉下拉刷新

/// 当前页码，默认为0
@property (nonatomic, assign) NSInteger currentPage;
/// 总页码
@property (nonatomic, assign) NSInteger totalPage;
/// 是否到达底部
@property (nonatomic, assign, readonly, getter=didBottom)BOOL bottom;
/// 下拉组件
@property (nonatomic, strong) MJRefreshStateHeader *refreshHeader;
/// 上拉加载组件
@property (nonatomic, strong) MJRefreshBackStateFooter *refreshFooter;
/// 没有更多信息显示字符串
@property (nonatomic, copy) NSString *titleForFooterRefreshWithNoMoreData;

@end

NS_ASSUME_NONNULL_END
