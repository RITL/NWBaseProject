//
//  NWTableViewCell.h
//
//
//  Created by ryden on 2017/4/26.
//  Copyright © 2017年 ryden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWTableViewCellDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NWTableViewCell : UITableViewCell

/// 代理对象   
@property (nonatomic, weak, nullable)id<NWTableViewCellDelegate>delegate;
/// 存储的信息
@property (nonatomic, copy, nullable)NSDictionary *messageInfo;
/// 当前cell的indexPath
@property (nonatomic, strong, nullable)NSIndexPath *indexPath;
/// cell的高度,默认0.0
@property (nonatomic, assign)CGFloat cellHeight;
/// 模拟顶部分割线
@property (nonatomic, strong)UIView *topLineView;
@property (nonatomic, assign)UIEdgeInsets topLineInset;//默认为UIRectEdgeNone
@property (nonatomic, assign)CGFloat topLineHeight;//默认为0
/// 模拟底部分割线
@property (nonatomic, strong)UIView *bottomLineView;
@property (nonatomic, assign)UIEdgeInsets bottomLineInset;//默认为UIRectEdgeNone
@property (nonatomic, assign)CGFloat bottomLineHeight;//默认为0
//所属控制器
@property (nonatomic, weak, nullable)UIViewController *superViewController;
//所属的tableView
@property (nonatomic, weak, nullable)UITableView *superTableView;

/*  视图创建 */
- (void)buildView;
- (void)addSubviews;
- (void)buildLayouts;
- (void)customSetter;/// 用于上述三个方法执行完毕，继承后修改其他的属性

/// 提供点击响应事件
- (void)elementDidClick:(id)sender;

@end









@interface NWTableViewCell (BaseTableViewCellDelegate)

/// 是否实现didSelectItemAtIndex:协议方法
@property(nonatomic, assign, readonly, getter=hasDidSelectItem)BOOL didSelectItem;

/// 是否实现didSelectCellAtIndexPath:协议方法
@property(nonatomic, assign, readonly, getter=hasDidSelectCell)BOOL didSelectCell;


/**
 快速执行didSelectItemAtIndex:的协议方法

 @param index 点击的Item位于Cell的索引
 @param info  附带的信息
 */
- (void)actionDidSelectItemAtIndex:(NSInteger)index Info:(NSDictionary *)info;

/**
 快速执行didSelectCellAtIndexPath:的协议方法

 @param index 点击Item位于Cell的索引
 @param info 附带的信息
 */
- (void)actionDidSelectCellAtIndex:(NSInteger)index Info:(NSDictionary *)info;

@end



NS_ASSUME_NONNULL_END
