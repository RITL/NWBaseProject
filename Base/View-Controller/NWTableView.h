//
//  NWTableView.h
//  NongWanCloud
//
//  Created by YueWen on 2018/1/4.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

/// 识别多个手势的tableView
@interface NWTableView : UITableView <UIGestureRecognizerDelegate>

/// 不使用共同的手势感应，默认为false
@property (nonatomic, assign)BOOL shouldNotRecognizeSimultaneouslyWithGestureRecognizer;


@end

NS_ASSUME_NONNULL_END
