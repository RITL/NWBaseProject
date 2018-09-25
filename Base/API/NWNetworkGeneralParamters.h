//
//  NWNetworkGeneralParamters.h
//  NWBaseProject
//
//  Created by YueWen on 2018/9/25.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NWNetworkGeneralParamters : NSObject

/**
 统一追加的参数，每次网络请求都会被调用
 默认为deviceModel、systemname、systemversion、appversion、deviceid
 如果完全不符合，重写该参数即可
 */
@property (nonatomic, copy, class)NSDictionary *generalParamters;


/**
 拓展参数
 generalParamters参数都可用，另外追加的参数可以赋值该语句。
 */
@property (nonatomic, copy, class)NSDictionary *extendParamters;

@end

NS_ASSUME_NONNULL_END
