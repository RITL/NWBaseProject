//
//  NetworkingUploader.h
//  NongWanCloud
//
//  Created by YueWen on 2018/2/9.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

extern CGFloat NWNetWorkingUploaderSizeDefault;//默认文件不限制

@class NWNetWorkingUploader;

@protocol NWNetWorkingUploaderAction <NSObject>

@optional

/// 单项
- (void)netWorkingUploaderWillRequest:(NWNetWorkingUploader *)netWorkingUploader progress:(NSInteger)currentIndex;
- (void)netWorkingUploaderEndRequest:(NWNetWorkingUploader *)netWorkingUploader progress:(NSInteger)currentIndex;

- (void)netWorkingUploader:(NWNetWorkingUploader *)netWorkingUploader progress:(NSInteger)current completeWithData:(NSDictionary *)info;
- (void)netWorkingUploader:(NWNetWorkingUploader *)netWorkingUploader progress:(NSInteger)current total:(NSInteger)total;
- (void)netWorkingUploader:(NWNetWorkingUploader *)netWorkingUploader progress:(NSInteger)current fail:(NSError *)error;

/// 只有文件数为1的时候进行的回调
- (void)netWorkingUploader:(NWNetWorkingUploader *)netWorkingUploader progress:(NSProgress *)progress;

/// 总部

/// 所有的文件上传完毕，按照顺序返回的数据信息,Json解析不正确或者失败的对象为NSNull
- (void)netWorkingUploader:(NWNetWorkingUploader *)netWorkingUploader completeWithData:(NSArray *)info;

@end

typedef NSString NWNetWorkingUploaderKey;

/// 文件上传的对象
@interface NWNetWorkingUploader : NSObject

/// 代理
@property (nonatomic, weak, nullable)id<NWNetWorkingUploaderAction> delegate;
/// 请求的url
@property (nonatomic, copy)NSString *url;
/// 参数
@property (nonatomic, copy, nullable)NSDictionary *parameters;


/// 上传的文件 - 文件与图片不要混合使用
@property (nonatomic, copy)NSArray *files;
/// 上传文件的名称
@property (nonatomic, copy)NSString *fileName;
/// 上传文件的后缀名
@property (nonatomic, copy)NSString *fileSuffix;
/// 上传服务端接收的文件名称
@property (nonatomic, copy)NSString *serviceName;
/// 文件类型
@property (nonatomic, copy)NSString *mimeType;
/// 文件最大的大小 - 对图片有效,默认为20MB（20 * 1024）
@property (nonatomic, assign)CGFloat fileMaxSize;


/// 附带标志位
@property (nonatomic, copy, nullable)NWNetWorkingUploaderKey *key;

/// 开始请求
- (void)resumeUpdate;

@end


NS_ASSUME_NONNULL_END
