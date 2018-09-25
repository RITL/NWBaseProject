//
//  ETCollectionViewCell.h
//  EattaClient
//
//  Created by YueWen on 2017/11/10.
//  Copyright © 2017年 YueWen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWCollectionViewCellDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NWCollectionViewCell : UICollectionViewCell

/// 代理对象
@property (nonatomic, weak, nullable) id<NWCollectionViewCellDelegate>delegate;
/// 存储的信息
@property (nonatomic, copy, nullable) NSDictionary *messageInfo;
/// 当前cell的indexPath
@property (nonatomic, strong, nullable)NSIndexPath *indexPath;
/// 所在的集合视图
@property (nonatomic, weak, nullable) UICollectionView *containCollectionView;

/*  视图创建 */
- (void)buildView;
- (void)addSubviews;
- (void)buildLayouts;


- (void)updateViewByData:(nullable NSDictionary *)dataDict
               indexPath:(NSIndexPath *)indexPath
            cellDelegate:(id)delegate;


- (CGSize)sizeViewByData:(nullable NSDictionary *)dataDict
               indexPath:(NSIndexPath *)indexPath;


/// 提供点击响应事件
- (void)elementDidClick:(id)sender;


@end


@interface NWCollectionViewCell (NWCollectionViewCellDelegate)

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
