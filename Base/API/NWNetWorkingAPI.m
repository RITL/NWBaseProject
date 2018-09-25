//
//  ETNetWorkingAPI.m
//  EattaClient
//
//  Created by YueWen on 2017/11/20.
//  Copyright © 2017年 YueWen. All rights reserved.
//

#import "NWNetWorkingAPI.h"
#import <objc/runtime.h>

NWNetWorkingAPIKey *NWNetWorkingAPIKeyDefault = @"NWNetWorkingAPIKeyDefault";
NWNetWorkingAPIKey *NWNetWorkingAPIKeyReset = @"NWNetWorkingAPIKeyReset";

@interface NWNetWorkingAPI()

@property (nonatomic, strong, readwrite)NSURLSessionDataTask *sessionTask;

@end


@implementation NWNetWorkingAPI


- (void)resumeNetworking
{
    //进行回调
    if (self.hasDelegate && NetWorkingAPIHasSel(self,@selector(networkingAPIWillRequest:))) {
        [self.delegate networkingAPIWillRequest:self];
    }
    
    [NWNetWorkingManager requestWithUrlString:self.url Method:self.method Parameters:self.parameters success:^(NSURLSessionDataTask *dataTask, NSDictionary *data) {
        
        self.sessionTask = dataTask;
        
        //结束
        if (self.hasDelegate && NetWorkingAPIHasSel(self,@selector(networkingAPIEndRequest:))) {
            [self.delegate networkingAPIEndRequest:self];
        }
        
        if (self.hasDelegate && NetWorkingAPIHasSel(self,@selector(networkingAPI:completeWithData:))) {
                [self.delegate networkingAPI:self completeWithData:data];
        }

    } failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
        
        self.sessionTask = dataTask;
        
        //结束
        if (self.hasDelegate && NetWorkingAPIHasSel(self,@selector(networkingAPIEndRequest:))) {
            [self.delegate networkingAPIEndRequest:self];
        }
        
        if (self.hasDelegate && NetWorkingAPIHasSel(self,@selector(networkingAPI:fail:))) {
            [self.delegate networkingAPI:self fail:error];
        }
    }];
}

- (void)suspendNetworking
{
    if (self.sessionTask) {
        
        [self.sessionTask suspend];
    }
}

- (void)cancleNetworking
{
    if (self.sessionTask) {
        
        [self.sessionTask cancel];
    }
}

@end


@implementation NWNetWorkingAPI (ETNetWorkingAPIAction)

- (BOOL)hasDelegate
{
    return self.delegate ? true : false;
}

@end

BOOL NetWorkingAPIHasSel(NWNetWorkingAPI *API,SEL sel)
{
    return [API.delegate respondsToSelector:sel];
}
