//
//  HYAPIProxy.h
//  HYNetworking
//
//  Created by work on 15/8/25.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYResponseManager.h"

typedef void(^HYCallBack)(HYResponseManager *response);

@interface HYAPIProxy : NSObject

+ (instancetype)sharedInstance;

/**
 *  GET请求方法
 */
- (NSInteger)GETWithPamrams:(NSDictionary *)params
                 methodName:(NSString *)methodName
                    success:(HYCallBack)success
                       fail:(HYCallBack)fail;

/**
 *  POST请求方法
 */
- (NSInteger)POSTWithPamrams:(NSDictionary *)params
                 methodName:(NSString *)methodName
                    success:(HYCallBack)success
                       fail:(HYCallBack)fail;

/**
 *  PUT请求方法
 */
- (NSInteger)PUTWithPamrams:(NSDictionary *)params
                 methodName:(NSString *)methodName
                    success:(HYCallBack)success
                       fail:(HYCallBack)fail;

/**
 *  DELETE请求方法
 */
- (NSInteger)DELETEWithPamrams:(NSDictionary *)params
                 methodName:(NSString *)methodName
                    success:(HYCallBack)success
                       fail:(HYCallBack)fail;

@end
