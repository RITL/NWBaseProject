//
//  Refresh.h
//  NongWanCloud
//
//  Created by YueWen on 2018/1/9.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NWRefresh <NSObject>

- (Class)classForRefreshHeader;//MJRefreshStateHeader
- (Class)classForRefreshFooter;//MJRefreshBackStateFooter


@property (nonatomic, assign)BOOL headerRefreshEnable;
@property (nonatomic, assign)BOOL footerRefreshEnable;

///// 是否使用下拉组件
//-(BOOL)headerRefreshEnable;
///// 是否使用上拉组件
//-(BOOL)footerRefreshEnable;


/// 下拉组件开始
- (void)headerRefreshBeginHandler;

/// 上拉组件开始
- (void)footerRefreshBeginHandler; 


/// 结束下拉刷新
- (void)endHeaderRefreshing;

/// 结束上拉加载
- (void)endFooterRefreshing;


/// 装载刷新
- (void) installHeaderRefresh;
- (void) installFooterRefresh;
- (void) installAllRefresh;

/// 卸载刷新
- (void) unstallHeaderRefresh;
- (void) unstallFooterRefresh;
- (void) unstallAllRefresh;

@end

NS_ASSUME_NONNULL_END
