//
//  ETPublicViewController.h
//  Yuexiaowen
//
//  Created by YueWen on 2017/3/24.
//  Copyright © 2017年 YueWen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RITLKit/RITLArchiverManager.h>

NS_ASSUME_NONNULL_BEGIN

/**
 农湾云的控制器
 */
@interface NWViewController : UIViewController

@property (nonatomic, assign)UIStatusBarStyle statusBarStyle;

#pragma mark - 初始化使用的方法
/// 是否使用自定义的导航属性
@property(nonatomic, assign, readonly)BOOL shouldSetCustomNavgationBarProerty;
/// 在init方法中加载自己的属性
- (void)loadPropertysAtInitialization NS_REQUIRES_SUPER;
/// 返回按钮进行响应的方法
- (void)actionBackItemInNavigationBar;
/// 必须主动调用，配置各大API对象
- (void)configRequestAPI;

#pragma mark - ArchiverManager
/// 归档Manager
@property (nonatomic, strong) RITLArchiverManager *archiverManager;
/// 进行归档的路径
@property (nonatomic, copy, nullable)NSString *archiverManagerDocument;
/// 开始归档
- (BOOL)startArchiver:(__kindof NSArray <id<NSCoding>> *)archiverObjects;
/// 读取归档数据
- (nullable NSArray <id<NSCoding>> *)readArchiverObjects;

#pragma mark - 点击事件
/// 提供点击响应事件，可以不使用
- (void)elementDidClick:(id)sender;

#pragma mark - TEST
/// 默认不做任何操作，用于测试
- (void)doNothing;

#pragma mark - NavigationBar
/// 是否拥有自己的导航栏
@property (nonatomic, assign, readonly)BOOL hasParentNavigationController;
/// 导航栏返回的图片
@property (nonatomic, copy, readonly) NSString *backIndicatorImage;
/// 存在导航栏进行的单独配置
- (void)setDefaultNavigationBarWhenHasParentNavigationController;

@end


NS_ASSUME_NONNULL_END
