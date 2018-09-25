//
//  TKNetWorkingManager.m
//  XiaoNongDingClient
//
//  Created by admin on 2017/4/25.
//  Copyright © 2017年 ryden. All rights reserved.
//

#import "NWNetWorkingManager.h"
#import "AFHTTPSessionManager+Shared.h"
#import "NSDictionary+NetWorking.h"
#import <RITLKit.h>

@implementation NWNetWorkingManager


+ (instancetype)sharedNetWorkingManager {
    
    static NWNetWorkingManager *manager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[NWNetWorkingManager alloc] init];
    });
    
    return manager;
}



+ (NSURLSessionDataTask *)requestWithUrlString:(NSString *)urlString Method:(HTTPMethod)httpMethod Parameters:(NSDictionary *)parameters success:(NetWorkingSuccessBlock)successBlock failure:(NetWorkingFailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedInstance];
    NSDictionary *parametersInfo = [NSDictionary appendExtensionAtData:parameters];
    
    switch (httpMethod) {
        case HTTP_GET: {
            return [manager GET:urlString parameters:parametersInfo.mutableCopy progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    NSError *error;
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
                    
                    if (error) {
                        failureBlock(task,error); return ;
                    }
                    
                    successBlock(task,dict);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(task,error);
                }
            }];
            break;
        }
        case HTTP_POST: {
            return [manager POST:urlString parameters:parametersInfo.mutableCopy progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    
                    //NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
                    
                    NSError *error;
                    
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
                    
                    if (error) {
                        NSLog(@"error = %@",error.localizedDescription);
                        failureBlock(task,error);
                    }
                    
                    else {
                        successBlock(task,dict);
                    }
                    
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(task,error);
                }
            }];
        }
        default:
            break;
    }
    
    return nil;
}

@end


