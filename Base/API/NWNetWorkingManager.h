//
//  TKNetWorkingManager.h
//  XiaoNongDingClient
//
//  Created by admin on 2017/4/25.
//  Copyright © 2017年 ryden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "NWNetworkingConfig.h"

typedef void (^NetWorkingSuccessBlock)(NSURLSessionDataTask *dataTask,NSDictionary *data);
typedef void (^NetWorkingFailureBlock)(NSURLSessionDataTask *dataTask,NSError *error);
typedef void (^NetWorkingExtensionSuccessBlock)(NSURLSessionDataTask *dataTask,NSDictionary *info,NSDictionary *data);
typedef void (^NetWorkingExtensionFailureBlock)(NSURLSessionDataTask *dataTask,NSError *error,NSString *msg);

@interface NWNetWorkingManager : NSObject

@property (nonatomic, strong) NetWorkingSuccessBlock networkingSuccessBlock;
@property (nonatomic, strong) NetWorkingFailureBlock networkingFailureBlock;

/**
 Initialization

 @return sharedManager
 */
+ (instancetype)sharedNetWorkingManager;

/**
 requestMethod

 @param urlString url
 @param httpMethod HTTPMethod
 @param parameters 使用字典传入参数
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
+ (NSURLSessionDataTask *)requestWithUrlString:(NSString *)urlString
                                        Method:(HTTPMethod)httpMethod
                                    Parameters:(NSDictionary *)parameters
                                       success:(NetWorkingSuccessBlock)successBlock
                                       failure:(NetWorkingFailureBlock)failureBlock;

@end



