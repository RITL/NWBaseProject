//
//  NSDictionary+NetWorking.m
//  NongWanCloud
//
//  Created by YueWen on 2018/2/10.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import "NSDictionary+NetWorking.h"
#import "NWNetworkGeneralParamters.h"
#import <UIDeviceIdentifier/UIDeviceHardware.h>
#import <RITLKit/RITLKit.h>

@implementation NSDictionary (NetWorking)

+ (NSDictionary *)networkExtension
{
    NSMutableDictionary *parametersInfo = [NSMutableDictionary dictionaryWithCapacity:5];
    [parametersInfo addEntriesFromDictionary:NWNetworkGeneralParamters.generalParamters];
    [parametersInfo addEntriesFromDictionary:NWNetworkGeneralParamters.extendParamters];
    return parametersInfo;
}



+ (NSDictionary *)appendExtensionAtData:(NSDictionary *)data
{
    if (!data) return self.networkExtension;
    
    NSMutableDictionary *append = [NSMutableDictionary dictionaryWithDictionary:data];
    /// 追加
    [append addEntriesFromDictionary:self.networkExtension];
    
    return append.copy;
}

@end

