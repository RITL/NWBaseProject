//
//  NSDictionary+NetWorking.h
//  NongWanCloud
//
//  Created by YueWen on 2018/2/10.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (NetWorking)

/// 网络请求附加的数据
@property (nonatomic, copy, readonly, class)NSDictionary *networkExtension;

/// 追加数据
+ (NSDictionary *)appendExtensionAtData:(nullable NSDictionary *)data;

@end


NS_ASSUME_NONNULL_END
