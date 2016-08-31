//
//  HYRequestManager.h
//  HYNetworking
//
//  Created by work on 15/8/31.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYRequestManager : NSObject

+ (instancetype)sharedInstance;

/**
 *  初始化GET请求
 */
- (NSURLRequest *)GETRequestWithRequestParams:(NSDictionary *)requestParams
                                   methodName:(NSString *)methodName;

/**
 *  初始化POST请求
 */
- (NSURLRequest *)POSTRequestWithRequestParams:(NSDictionary *)requestParams
                                   methodName:(NSString *)methodName;

/**
 *  初始化PUT请求
 */
- (NSURLRequest *)PUTRequestWithRequestParams:(NSDictionary *)requestParams
                                   methodName:(NSString *)methodName;

/**
 *  初始化DELETE请求
 */
- (NSURLRequest *)DELETERequestWithRequestParams:(NSDictionary *)requestParams
                                   methodName:(NSString *)methodName;

@end
