//
//  NWNetworkGeneralParamters.m
//  NWBaseProject
//
//  Created by YueWen on 2018/9/25.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import "NWNetworkGeneralParamters.h"
#import <UIKit/UIKit.h>
#import <RITLKit/RITLKit.h>
#import <UIDeviceIdentifier/UIDeviceHardware.h>

@interface NWNetworkGeneralParamters ()

/**
 统一追加的参数，每次网络请求都会被调用
 默认为deviceModel、systemname、systemversion、appversion、deviceid
 如果完全不符合，重写该参数即可
 */
@property (nonatomic, copy)NSDictionary *generalParamters;


/**
 拓展参数
 generalParamters参数都可用，另外追加的参数可以赋值该语句。
 */
@property (nonatomic, copy)NSDictionary *extendParamters;

@end

@implementation NWNetworkGeneralParamters

- (instancetype)init
{
    if (self = [super init]){
        
        NSMutableDictionary *parametersInfo = [NSMutableDictionary dictionaryWithCapacity:5];
        
        UIDevice *device = UIDevice.currentDevice;
        
        // 追加手机信息
        [parametersInfo addEntriesFromDictionary:@{@"deviceModel":UIDeviceHardware.platformStringSimple}];//iPhone
        [parametersInfo addEntriesFromDictionary:@{@"systemname":device.systemName}];//iOS
        [parametersInfo addEntriesFromDictionary:@{@"systemversion":device.systemVersion}];//4.0
        
        // 追加app版本号
        [parametersInfo addEntriesFromDictionary:@{@"appversion" : NSDictionary.ritl_version}];//1.0
        
        //追加 机器唯一编码
        [parametersInfo addEntriesFromDictionary:@{@"deviceid" : device.identifierForVendor.UUIDString}];
        
        self.generalParamters = parametersInfo;
        self.extendParamters = @{};
    }
    
    return self;
}



+ (instancetype)sharedInstance
{
    static NWNetworkGeneralParamters *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareInstance = [self new];
    });
    
    return shareInstance;
}


+ (NSDictionary *)generalParamters{
    return NWNetworkGeneralParamters.sharedInstance.generalParamters;
}

+ (void)setGeneralParamters:(NSDictionary *)generalParamters {
    NWNetworkGeneralParamters.sharedInstance.generalParamters = generalParamters;
}


+ (NSDictionary *)extendParamters {
    return NWNetworkGeneralParamters.sharedInstance.extendParamters;
}

+ (void)setExtendParamters:(NSDictionary *)extendParamters {
    NWNetworkGeneralParamters.sharedInstance.extendParamters = extendParamters;
}


@end
