//
//  AFHTTPSessionManager+Shared.m
//  NongWanCloud
//
//  Created by YueWen on 2018/1/3.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import "AFHTTPSessionManager+Shared.h"

@implementation AFHTTPSessionManager (Shared)

+(instancetype)sharedInstance
{
    static AFHTTPSessionManager *manager = nil;
    
    if (manager) {
        
        manager.requestSerializer.timeoutInterval = 15.0;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 6.66;
        
    });
    
    return manager;
}


-(instancetype)timeOut:(NSTimeInterval)outTime
{
    self.requestSerializer.timeoutInterval = outTime;
    
    return self;
}

@end
