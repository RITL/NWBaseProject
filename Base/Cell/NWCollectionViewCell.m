//
//  ETCollectionViewCell.m
//  EattaClient
//
//  Created by YueWen on 2017/11/10.
//  Copyright © 2017年 YueWen. All rights reserved.
//

#import "NWCollectionViewCell.h"
#import <objc/runtime.h>

@implementation NWCollectionViewCell

- (instancetype)init
{
    if (self = [super init]) {}
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self buildView];
        [self addSubviews];
        [self buildLayouts];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (void)buildView
{
    
}

- (void)addSubviews
{
    
}

- (void)buildLayouts
{
    
}

- (void)updateViewByData:(NSDictionary *)dataDict indexPath:(NSIndexPath *)indexPath  cellDelegate:(id)delegate
{
    
}

- (CGSize)sizeViewByData:(nullable NSDictionary *)dataDict indexPath:(NSIndexPath *)indexPath
{
    return CGSizeZero;
}


- (void)elementDidClick:(id)sender
{
    
}

-(void)dealloc
{
    objc_removeAssociatedObjects(self);
}

@end


@implementation NWCollectionViewCell (NWCollectionViewCellDelegate)

- (BOOL)hasDelegate
{
    return (self.delegate != nil);
}

- (BOOL)hasDidSelectCell
{
    return (self.hasDelegate && [self.delegate respondsToSelector:@selector(collectionViewCell:didSelectCellAtIndexPath:cellInfo:linkInfo:)]);
}

- (BOOL)hasDidSelectItem
{
    return (self.hasDelegate && [self.delegate respondsToSelector:@selector(collectionViewCell:didSelectItemAtIndex:indexPath:infoDict:)]);
}

-(void)actionDidSelectItemAtIndex:(NSInteger)index Info:(NSDictionary *)info
{
    
    if (self.hasDidSelectItem) {
        
        [self.delegate collectionViewCell:self didSelectItemAtIndex:index indexPath:self.indexPath infoDict:info];
    }
}

-(void)actionDidSelectCellAtIndex:(NSInteger)index Info:(NSDictionary *)info
{
    if (self.hasDidSelectCell) {
        
        [self.delegate collectionViewCell:self didSelectCellAtIndexPath:self.indexPath cellInfo:@{@"cell":self} linkInfo:info];
    }
}

@end

