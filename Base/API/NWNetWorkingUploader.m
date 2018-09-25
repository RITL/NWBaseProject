//
//  NetworkingUploader.m
//  NongWanCloud
//
//  Created by YueWen on 2018/2/9.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import "NWNetWorkingUploader.h"
#import "NSDictionary+NetWorking.h"
#import "AFHTTPSessionManager+Shared.h"
#import <RITLKit/RITLKit.h>

CGFloat NWNetWorkingUploaderSizeDefault = 20 * 1024;//默认文件不限制

BOOL NetWorkingUploaderHasSel(NWNetWorkingUploader *API,SEL sel)
{
    return API.delegate && [API.delegate respondsToSelector:sel];
}



@interface NWNetWorkingUploader()

@property (nonatomic, strong)NSMutableArray *results;
@property (nonatomic, strong)NSURLSessionDataTask *sessionTask;
@property (nonatomic, assign)NSUInteger maxConcurrentOperationCount;

@end


@implementation NWNetWorkingUploader


- (instancetype)init
{
    if (self = [super init]) {
        
        self.fileMaxSize = NWNetWorkingUploaderSizeDefault;
        self.results = [NSMutableArray arrayWithCapacity:10];
        self.maxConcurrentOperationCount = 1;
    }
    
    return self;
}


- (void)resumeUpdate
{
    //如果存在,取消当前
    if (self.sessionTask && self.sessionTask.state == NSURLSessionTaskStateRunning) { [self.sessionTask cancel]; }
    
    NSDictionary *parameters = [NSDictionary appendExtensionAtData:self.parameters];//拼接参数
    
    //创建队列
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("uploader", NULL);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(self.maxConcurrentOperationCount);

    //开始循环
    for (int i = 0; i < self.files.count; i++) {
        
        dispatch_group_async(group, queue, ^{
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);// - 1
            dispatch_group_enter(group);
            
            id file = self.files[i];
            NSInteger currentIndex = i;
            
            //将要开始
            if (NetWorkingUploaderHasSel(self, @selector(netWorkingUploaderWillRequest:progress:))) {
                
                [self.delegate netWorkingUploaderWillRequest:self progress:currentIndex];
            }
            
//            NSLog(@"This is %@ file will start!",@(currentIndex + 1));
            
            //开始上传
            self.sessionTask = [[AFHTTPSessionManager sharedInstance] POST:self.url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                NSString *fileName = [NSString stringWithFormat:@"%@"/*_%@"*/,self.fileName/*,NSDate.ritl_uploadTime*/];
                
                if (self.fileSuffix && !self.fileSuffix.isEmpty) {//存在后缀，进行填充
                    
                    fileName = [fileName stringByAppendingFormat:@".%@",self.fileSuffix];
                }
                
                if ([file isKindOfClass:NSData.class]) {
                    
                    [formData appendPartWithFileData:file name:self.serviceName fileName:fileName mimeType:self.mimeType];
                    
                }else if([file isKindOfClass:UIImage.class]){
                    
                    [formData appendPartWithFileData:[((UIImage *)file) ritl_imageDataWithMaxSize:self.fileMaxSize] name:self.serviceName fileName:fileName mimeType:self.mimeType];
                }
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
                if (self.files.count == 1 && NetWorkingUploaderHasSel(self, @selector(netWorkingUploader:progress:))) {
                    
                    [self.delegate netWorkingUploader:self progress:uploadProgress];
                }
                
                //NSLog(@"This is %@ file, progress = %@",@(currentIndex + 1),@(1 / (uploadProgress.totalUnitCount * 1.0 / uploadProgress.completedUnitCount)));
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //进行数据解析
                NSDictionary *reuslt = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                
                if (NetWorkingUploaderHasSel(self, @selector(netWorkingUploader:progress:completeWithData:))) {
                    
                    [self.delegate netWorkingUploader:self progress:currentIndex completeWithData:reuslt];
                }
                
                //NSLog(@"This is %@ file,complete is %@",@(currentIndex + 1),reuslt);
                
                //追加累计数据
                [self.results addObject:reuslt ? reuslt : NSNull.null];//数据解析错误
                
                //结束
                dispatch_semaphore_signal(semaphore);
                dispatch_group_leave(group);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                //结束
                if (NetWorkingUploaderHasSel(self, @selector(netWorkingUploader:progress:fail:))) {
                    
                    [self.delegate netWorkingUploader:self progress:currentIndex fail:error];
                }
                
                //NSLog(@"This is %@ file,fail_error is %@",@(currentIndex + 1),error.localizedDescription);
                
                dispatch_semaphore_signal(semaphore);
                dispatch_group_leave(group);
            }];
        });
    }
    

    //主线程执行回调
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        if (NetWorkingUploaderHasSel(self, @selector(netWorkingUploader:completeWithData:))) {
            
            [self.delegate netWorkingUploader:self completeWithData:self.results.copy];
        }
        
        //NSLog(@"All uploader is complete! count is %@,info = %@",@(self.results.count),self.results);
    });
}


- (void)setFiles:(NSArray *)files
{
    _files = files;
    
    [self.results removeAllObjects];
}


- (NSString *)fileName
{
    if (!_fileName) {
        
        return @"file";
    }
    
    return _fileName;
}

@end
