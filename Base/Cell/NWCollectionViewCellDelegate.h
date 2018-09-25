//
//  NWCollectionViewCellDelegate.h
//  NongWanCloud
//
//  Created by YueWen on 2018/1/9.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class NWCollectionViewCell;

@protocol NWCollectionViewCellDelegate <NSObject>

@optional


/**
 点击Cell的某一项，比如一个Cell包含6个商品的情况
 
 @param cell 执行回调的cell
 @param index 点击的Item位于Cell的索引
 @param indexPath UITableViewCell的IndexPath
 @param infoDict 附属信息（可能为空）
 */
- (void)collectionViewCell:(NWCollectionViewCell *)cell
      didSelectItemAtIndex:(NSInteger)index
                 indexPath:(NSIndexPath * _Nullable)indexPath
                  infoDict:(NSDictionary * _Nullable)infoDict;

/**
 点击整个Cell
 
 @param cell 执行回调的cell
 @param indexPath UITableViewCell的IndexPath
 @param cellInfo 当前整个cell信息
 @param linkInfo 跳转Link信息
 */
- (void)collectionViewCell:(NWCollectionViewCell *)cell
  didSelectCellAtIndexPath:(NSIndexPath *)indexPath
                  cellInfo:(NSDictionary * _Nullable)cellInfo
                  linkInfo:(NSDictionary * _Nullable)linkInfo;

@end


NS_ASSUME_NONNULL_END
