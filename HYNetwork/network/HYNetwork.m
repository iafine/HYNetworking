//
//  HYNetworkUtils.m
//  OpenSourceTest
//
//  Created by hyyy on 15/12/21.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import <AFNetworking.h>
#import "HYNetwork.h"

//开发服务器地址(前缀以项目名开始)
static NSString *wdm_devServerAddr = @"http://desk.fd.zol-img.com.cn";
//上线服务器地址(前缀以项目名开始)
static NSString *wdm_onlineServerAddr = @"Your online server address";

@implementation HYNetwork

+ (NSString *)baseServerAddr{
    //正式发布需要改成上线服务器地址
    return wdm_devServerAddr;
}

+ (HYHTTPSessionManager *)GETWithUrl:(NSString *)url params:(NSDictionary *)params success:(HYResponseSuccess)success fail:(HYResponseFail)fail{
    AFHTTPSessionManager *manager = [self manager];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@", [self baseServerAddr], url];
    [manager GET:requestUrl parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
        [self successResponse:responseObject callback:success];
        // 打印请求成功日志
        [self logWithSuccess:responseObject url:requestUrl params:params];
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        [self failurRequest:error callback:fail];
        //打印请求失败日志
        [self logWithFailure:error url:requestUrl params:params];
    }];
    return manager;
}

+ (HYHTTPSessionManager *)POSTWithUrl:(NSString *)url params:(NSDictionary *)params success:(HYResponseSuccess)success fail:(HYResponseFail)fail{
    AFHTTPSessionManager *manager = [self manager];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@", [self baseServerAddr], url];
    [manager POST:requestUrl parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
        [self successResponse:responseObject callback:success];
        // 打印请求成功日志
        [self logWithSuccess:responseObject url:requestUrl params:params];
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        [self failurRequest:error callback:fail];
        // 打印请求失败日志
        [self logWithFailure:error url:requestUrl params:params];
    }];
    return manager;
}

+ (void)downloadWithUrl:(NSString *)url saveToPath:(NSString *)saveToPath progress:(HYDownloadProgress)progressBlock success:(HYResponseSuccess)success failure:(HYResponseFail)failure{
    AFHTTPSessionManager *manager = [self manager];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@", [self baseServerAddr], url];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
    
    NSProgress *progress;
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        //        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDownloadsDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        //        NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        //        return url;
        
        NSString *strDirectory = @"";
        NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *strDocumentPath = arr[0];
        strDirectory = [strDocumentPath stringByAppendingPathComponent:saveToPath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL bExist = [fileManager fileExistsAtPath:strDirectory];
        if(!bExist)
        {
            [fileManager createDirectoryAtPath:strDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *fileURL = [NSString stringWithFormat:@"file://%@", strDirectory];
        NSURL *downloadURL = [NSURL URLWithString:fileURL];
        NSURL *url = [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
        return url;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            failure(error);
        }else{
            NSLog(@"File downloaded to: %@", filePath);
            success(filePath);
        }
    }];
    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        progressBlock(downloadTask, bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    }];
    [downloadTask resume];
}

#pragma mark - private method
+ (AFHTTPSessionManager *)manager{
    //开启转圈
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    [manager.requestSerializer setValue:[self getUserAgentInfo] forHTTPHeaderField:@"User-Agent"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    //设置最大并发数量(这个数值不要过大)
    manager.operationQueue.maxConcurrentOperationCount = 3;
    return manager;
}

// session过期操作
+ (void)handleSessionExpire:(id)responseObj{
    //根据返回值判断session是否过期
    if ([responseObj containsObject:@"<html>"] || [responseObj containsObject:@"</script>"]) {
        //session过期，跳转到登录页面
        NSLog(@"session过期");
//        UIViewController *vc = [HYCustomMethod getCurrentVC];
//        [vc.navigationController presentViewController:loginVC animated:YES completion:nil];
    }
}

// 自定义用户代理信息(后台统计请求所用)
+ (NSString *)getUserAgentInfo{
    // 获取手机操作系统版本
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    // 获取设备名称
    NSString *deviceName = [[UIDevice currentDevice] systemName];
    // 获取应用名称
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    // 获取应用版本号
    NSString *appVersioin = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

    NSString *userAgentString = [NSString stringWithFormat:@"%@; iOS %@; %@(%@)", deviceName, phoneVersion, appName, appVersioin];
    return userAgentString;
}

// 请求成功响应
+ (void)successResponse:(id)responseObject callback:(HYResponseSuccess)success{
    if (success) {
        success([self tryToParseResponseData:responseObject]);
    }
}

// 请求失败响应
+ (void)failurRequest:(NSError *)error callback:(HYResponseFail)fail{
    if (fail) {
        fail(error);
    }
}
/**
 *  加工获取后的数据，以得到最终想要的结果
 *
 *  @param responseObj 请求返回的原始数据
 *
 *  @return 返回加工后的数据
 */
+ (id)tryToParseResponseData:(id)responseObj{
    // 先判断session是否过期
    [self handleSessionExpire:responseObj];
    if ([responseObj isKindOfClass:[NSData class]]) {
        if (responseObj) {
            NSError *error = nil;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableContainers error:&error];
            if (!error) {
                return responseDic;
            }else{
                return responseObj;
            }
        }else{
            return responseObj;
        }
    }else{
        return responseObj;
    }
}

// 打印请求成功后的log日志
+ (void)logWithSuccess:(id)responseObj url:(NSString *)url params:(NSDictionary *)params{
#ifdef DEBUG
    NSString *logStr = [NSString stringWithFormat:@"\nRequest URL:%@\n Params:%@\n Response:%@\n\n", url, params, [self tryToParseResponseData:responseObj]];
    NSLog(@"%@", logStr);
#else
#endif
}

// 打印请求失败后的log日志
+ (void)logWithFailure:(NSError *)error url:(NSString *)url params:(NSDictionary *)params{
#ifdef DEBUG
    NSString *logStr = [NSString stringWithFormat:@"\nRequest URL:%@\n Params:%@\n Response:%@\n\n", url, params, error];
    NSLog(@"%@", logStr);
#else
#endif
}

@end
