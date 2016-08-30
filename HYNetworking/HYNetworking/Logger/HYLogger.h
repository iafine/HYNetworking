//
//  HYLogger.h
//  HYNetworking
//
//  Created by work on 16/8/30.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYBaseRequestManager.h"
#import "HYResponseManager.h"

@interface HYLogger : NSObject

+ (instancetype)sharedInstance;

/**
 *  @author hyyy, 16-08-30 17:08:09
 *
 *  @brief 打印请求日志 (debug)
 *
 *  @param request        request
 *  @param requestUrl     url
 *  @param requestManager request manager
 *  @param methodName     method name
 */
- (void)printDebugLogWithRequest:(NSURLRequest *)request
                      requestUrl:(NSString *)requestUrl
                  requestManager:(HYBaseRequestManager *)requestManager
                      methodName:(NSString *)methodName;

- (void)printDebugLogWithResponse:(NSHTTPURLResponse *)response responseString:(NSString *)responseString request:(NSURLRequest *)request error:(NSError *)error;

@end
