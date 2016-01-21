//
//  HYNetworkUtils.h
//  OpenSourceTest
//
//  Created by hyyy on 15/12/21.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AFHTTPSessionManager;

typedef AFHTTPSessionManager HYHTTPSessionManager;
/**
 *  请求成功后的回调
 *
 *  @param response 服务器返回的数据
 */
typedef void(^HYResponseSuccess) (id response);

/**
 * 请求失败后的回调
 *
 *  @param error 请求失败返回的错误log
 */
typedef void(^HYResponseFail) (NSError *error);

/**
 *  下载进度
 *
 *  @param bytesWritten              已经下载的大小
 *  @param totalBytesWritten         文件总大小
 *  @param totalBytesExpectedToWrite 文件下载剩余大小
 */
typedef void(^HYDownloadProgress) (NSURLSessionDownloadTask *downloadTask,
                                   int64_t bytesWritten,
                                   int64_t totalBytesWritten,
                                   int64_t totalBytesExpectedToWrite);
@interface HYNetwork : NSObject

/**
 *  设置全局的服务器地址
 *
 *  @return 服务器地址
 */
+ (NSString *)baseServerAddr;

/**
 *  GET请求方法
 *
 *  @param url     接口URL：(/user/mlogin)
 *  @param params  请求参数
 *  @param success 请求成功后回调
 *  @param fail    请求失败后回调
 *
 *  @return 返回请求对象
 */
+ (HYHTTPSessionManager *)GETWithUrl:(NSString *)url
            params:(NSDictionary *)params
           success:(HYResponseSuccess)success
              fail:(HYResponseFail)fail;

/**
 *  POST请求方法
 *
 *  @param url     接口URL:(/user/mlogin)
 *  @param params  请求参数
 *  @param success 请求成功后回调
 *  @param fail    请求失败后回调
 *
 *  @return 返回请求对象
 */
+ (HYHTTPSessionManager *)POSTWithUrl:(NSString *)url
             params:(NSDictionary *)params
            success:(HYResponseSuccess)success
               fail:(HYResponseFail)fail;

/**
 *  文件下载
 *
 *  @param url           文件下载路径
 *  @param saveToPath    文件存储路径
 *  @param progressBlock 下载进度回调
 *  @param success       下载成功后回调
 *  @param failure       下载失败后回调
 */
+ (void)downloadWithUrl:(NSString *)url
             saveToPath:(NSString *)saveToPath
               progress:(HYDownloadProgress)progressBlock
                success:(HYResponseSuccess)success
                failure:(HYResponseFail)failure;

@end
