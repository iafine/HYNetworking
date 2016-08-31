//
//  HYLogger.h
//  HYNetworking
//
//  Created by work on 16/8/30.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYRequestService.h"

@interface HYLogger : NSObject

/**
 *  @author hyyy, 16-08-31 14:08:30
 *
 *  @brief  打印请求网络日志 (Debug)
 *
 *  @param request
 *  @param service
 *  @param url
 *  @param methodName
 */
+ (void)printDebugLogWithRequest:(NSURLRequest *)request
                  requestService:(HYRequestService *)service
                      requestUrl:(NSString *)url
                      methodName:(NSString *)methodName;

/**
 *  @author hyyy, 16-08-31 14:08:54
 *
 *  @brief 打印响应网络日志 (Debug)
 *
 *  @param response
 *  @param content
 *  @param request
 *  @param error
 */
+ (void)printDebugLogWithResponse:(NSURLResponse *)response
                          content:(NSString *)content
                          request:(NSURLRequest *)request
                            error:(NSError *)error;

@end
