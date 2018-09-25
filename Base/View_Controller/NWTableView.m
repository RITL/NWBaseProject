//
//  NWTableView.m
//  NongWanCloud
//
//  Created by YueWen on 2018/1/4.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import "NWTableView.h"


@implementation NWTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        

    }
    
    return self;
}


/// 同时识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (self.shouldNotRecognizeSimultaneouslyWithGestureRecognizer) {
        return false;
    }
    
    //与collectionView取消冲突
    if ([otherGestureRecognizer.view isKindOfClass:UITableView.class]
        /*|| [NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"_UIQueuingScrollView"]*/) {
        return true;//_UIQueuingScrollView
    }
    return false;
}


-(void)dealloc
{
    NSLog(@"[dealloc] [%@]",NSStringFromClass([self class]));
}


@end
