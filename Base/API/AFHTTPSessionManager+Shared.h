//
//  AFHTTPSessionManager+Shared.h
//  NongWanCloud
//
//  Created by YueWen on 2018/1/3.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

/// 继承自AF框架，避免[AFHTTPSessionManager manager]引发内存泄露
@interface AFHTTPSessionManager (Shared)

/// 单例对象
+ (instancetype)sharedInstance;
/// 设置超时时间的AFHTTPSessionManager
- (instancetype)timeOut:(NSTimeInterval)outTime;


@end

NS_ASSUME_NONNULL_END
