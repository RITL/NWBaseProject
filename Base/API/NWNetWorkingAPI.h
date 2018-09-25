//
//  ETNetWorkingAPI.h
//  EattaClient
//
//  Created by YueWen on 2017/11/20.
//  Copyright © 2017年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "NWNetWorkingManager.h"

NS_ASSUME_NONNULL_BEGIN

@class NWNetWorkingAPI;

@protocol NWNetWorkingAPIAction <NSObject>

@optional

- (void)networkingAPIWillRequest:(NWNetWorkingAPI *)networkingAPI;
- (void)networkingAPIEndRequest:(NWNetWorkingAPI *)networkingAPI;

- (void)networkingAPI:(NWNetWorkingAPI *)networkingAPI completeWithData:(NSDictionary *)info;
- (void)networkingAPI:(NWNetWorkingAPI *)networkingAPI fail:(NSError *)error;

@end


typedef NSString NWNetWorkingAPIKey;

/// 使用代理的请求API
@interface NWNetWorkingAPI : NSObject

/// 代理
@property (nonatomic, weak, nullable)id<NWNetWorkingAPIAction> delegate;
/// 参数
@property (nonatomic, copy, nullable)NSDictionary *parameters;
/// 默认为get
@property (nonatomic, assign)HTTPMethod method;
/// 请求的url
@property (nonatomic, copy) NSString *url;
/// 请求任务
@property (nonatomic, strong, readonly)NSURLSessionDataTask *sessionTask;
/// 附带标志位
@property (nonatomic, copy, nullable)NWNetWorkingAPIKey *requestKey;

/// 开始请求
- (void)resumeNetworking;
/// 中断
- (void)suspendNetworking;
/// 取消
- (void)cancleNetworking;

@end

@interface NWNetWorkingAPI(ETNetWorkingAPIAction)
/// 是否存在代理
@property (nonatomic, assign, readonly)BOOL hasDelegate;

@end

/// 是否存在方法
extern BOOL NetWorkingAPIHasSel(NWNetWorkingAPI *API,SEL sel);
extern NWNetWorkingAPIKey *NWNetWorkingAPIKeyDefault;//默认
extern NWNetWorkingAPIKey *NWNetWorkingAPIKeyReset;//重置

@interface NSObject (NetWorkingAPIAction)<NWNetWorkingAPIAction>

@end



NS_ASSUME_NONNULL_END
