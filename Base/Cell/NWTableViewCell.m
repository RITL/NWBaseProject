//
//  NWTableViewCell.m
//  
//
//  Created by RYDEN on 2017/4/26.
//  Copyright © 2017年 ryden. All rights reserved.
//

#import "NWTableViewCell.h"
#import <objc/runtime.h>
#import <RITLKit/RITLKit.h>
#import <RITLViewFrame/UIView+RITLFrameChanged.h>


@implementation NWTableViewCell

- (instancetype)init
{
    if (self = [super init]) {
        
        self.cellHeight = 0.01;
        self.topLineHeight = 0.0;
        self.topLineInset = UIEdgeInsetsZero;
        self.bottomLineHeight = 0.0;
        self.bottomLineInset = UIEdgeInsetsZero;
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self baseBuildViews];
    }
    
    return self;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self && !self.topLineView) {
        
        [self baseBuildViews];
    }
    
    return self;
}

- (void)setDelegate:(id<NWTableViewCellDelegate>)delegate
{
    _delegate = delegate;
    
    if ([delegate isKindOfClass:UIViewController.class]) {
        
        self.superViewController = (UIViewController *)delegate;
    }
}


- (void)baseBuildViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // 公共View
    
    self.topLineView = ({
        
        UIView *view = [UIView new];
        view.hidden = true;
        view.frame = CGRectMake(0, 0, RITL_SCREEN_WIDTH, 2);
        view;
    });
    
    self.bottomLineView = ({
        
        UIView *view = [UIView new];
        view.hidden = true;
        view.frame = CGRectMake(0, 0, RITL_SCREEN_WIDTH, 2);
        view;
    });
    
    
    self.contentView.ritl_view.add(self.bottomLineView).add(self.topLineView);
    
    [self buildView];
    [self addSubviews];
    [self buildLayouts];
    [self customSetter];
}


- (void)prepareForReuse
{
    [super prepareForReuse];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.bottomLineView.hidden && self.bottomLineHeight > 0 && [self.bottomLineView isDescendantOfView:self.contentView]) {
        
        self.bottomLineView.ritl_height = self.bottomLineHeight;
        self.bottomLineView.ritl_originX = self.bottomLineInset.left;
        self.bottomLineView.ritl_maxY = self.contentView.ritl_maxY;
        self.bottomLineView.ritl_width = self.contentView.ritl_width - self.bottomLineInset.left - self.bottomLineInset.right;
        
        [self.contentView bringSubviewToFront:self.bottomLineView];
    }else {
        
        self.bottomLineView.hidden = true;
    }
    
    if (!self.topLineView.hidden && self.topLineHeight > 0 && [self.topLineView isDescendantOfView:self.contentView]) {
        
        self.topLineView.ritl_height = self.topLineHeight;
        self.topLineView.ritl_originX = self.topLineInset.left;
        self.topLineView.ritl_originY = 0;
        self.topLineView.ritl_width = self.contentView.ritl_width - self.topLineInset.left - self.topLineInset.right;
        
        [self.contentView bringSubviewToFront:self.bottomLineView];
    }else {
        self.topLineView.hidden = true;
    }
}


- (void)setTopLineHeight:(CGFloat)topLineHeight
{
    _topLineHeight = topLineHeight;
    self.topLineView.hidden = (topLineHeight == 0.0);
    [self setNeedsLayout];
}

- (void)setTopLineInset:(UIEdgeInsets)topLineInset
{
    _topLineInset = topLineInset;
    _topLineView.hidden = false;
    [self setNeedsLayout];
}


- (void)setBottomLineHeight:(CGFloat)bottomLineHeight
{
    _bottomLineHeight = bottomLineHeight;
    _bottomLineView.hidden = (bottomLineHeight == 0.0);
    [self setNeedsLayout];
}

- (void)setBottomLineInset:(UIEdgeInsets)bottomLineInset
{
    _bottomLineInset = bottomLineInset;
    _bottomLineView.hidden = false;
    [self setNeedsLayout];
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

- (void)customSetter
{
    
}


-(void)dealloc
{
    objc_removeAssociatedObjects(self);
}


- (void)elementDidClick:(id)sender
{
    
}


- (void)updateViewWithData:(NSDictionary *)attributes
{
    
}


@end


@implementation NWTableViewCell (BaseTableViewCellDelegate)



- (BOOL)hasDelegate
{
    return (self.delegate != nil);
}

- (BOOL)hasDidSelectCell
{
    return (self.hasDelegate && [self.delegate respondsToSelector:@selector(tableViewCell:didSelectCellAtIndexPath:cellInfo:linkInfo:)]);
}


- (BOOL)hasDidSelectItem
{
    return (self.hasDelegate && [self.delegate respondsToSelector:@selector(tableViewCell:didSelectItemAtIndex:indexPath:infoDict:)]);
}



-(void)actionDidSelectItemAtIndex:(NSInteger)index Info:(NSDictionary *)info
{
    if (self.hasDidSelectItem) {
        
        [self.delegate tableViewCell:self didSelectItemAtIndex:index indexPath:self.indexPath infoDict:info];
    }
}


-(void)actionDidSelectCellAtIndex:(NSInteger)index Info:(NSDictionary *)info
{
    if (self.hasDidSelectCell) {
        
        [self.delegate tableViewCell:self didSelectCellAtIndexPath:self.indexPath cellInfo:@{@"cell":self} linkInfo:info];
    }
}

@end
