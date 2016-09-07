//
//  HYLogger.h
//  HYNetworking
//
//  Created by work on 15/8/30.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYRequestService.h"

@interface HYLogger : NSObject

/**
 *  打印请求网络日志 (Debug)
 */
+ (void)printDebugLogWithRequest:(NSURLRequest *)request
                  requestService:(HYRequestService *)service
                      requestUrl:(NSString *)url
                      methodName:(NSString *)methodName;

/**
 *  打印响应网络日志 (Debug)
 */
+ (void)printDebugLogWithResponse:(NSURLResponse *)response
                          content:(NSString *)content
                          request:(NSURLRequest *)request
                            error:(NSError *)error;

@end
