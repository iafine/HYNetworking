//
//  HYRequestManager.h
//  HYNetworking
//  (基础请求封装类，通过继承实现具体功能)
//  Created by work on 16/8/29.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author hyyy, 16-08-29 14:08:32
 *
 *  @brief 请求相关的服务协议，子类需要重写该协议
 */
@protocol HYBaseRequestManagerService <NSObject>

@property (assign, nonatomic, readonly) BOOL isOnline;

@property (strong, nonatomic, readonly) NSString *offlineApiBaseUrl;
@property (strong, nonatomic, readonly) NSString *onlineApiBaseUrl;

@property (strong, nonatomic, readonly) NSString *offlineApiVersion;
@property (strong, nonatomic, readonly) NSString *onlineApiVersion;

@end

@interface HYBaseRequestManager : NSObject

@property (strong, nonatomic, readonly) NSString *apiBaseUrl;
@property (strong, nonatomic, readonly) NSString *apiVersion;

@property (weak, nonatomic) id<HYBaseRequestManagerService> service;

+ (instancetype)sharedInstance;

- (NSURLRequest *)GETRequestWithRequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;

@end
