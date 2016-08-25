//
//  HYAPIProxy.m
//  HYNetworking
//
//  Created by work on 16/8/25.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import "HYAPIProxy.h"
#import <AFNetworking/AFNetworking.h>

@interface HYAPIProxy()

// 保存请求(requestId -> dataTask)
@property (strong, nonatomic) NSMutableDictionary *requestList;

// AFNetworking
@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end
@implementation HYAPIProxy

#pragma mark - life cycle
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static HYAPIProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HYAPIProxy alloc] init];
    });
    return sharedInstance;
}

- (NSInteger)getWithPamrams:(NSDictionary *)params methodName:(NSString *)methodName success:(HYCallBack)success fail:(HYCallBack)fail {
    
    // request这块代码要拿出去，进行封装，实现自定义request
    NSString *baseUrl = @"http://www.test.com";
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", baseUrl, methodName];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    requestSerializer.timeoutInterval = 20.0;
    requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:@"GET" URLString:urlString parameters:params error:nil];
    
    NSNumber *requestID = [self startRequestWithRequest:request success:success fail:fail];
    return [requestID integerValue];
}

/**
 *  @author hyyy, 16-08-25 15:08:13
 *
 *  @brief 将使用到AFNetworking的东西进行归总，如果以后需要更改底层网络框架，那么直接在此方法里修改即可。
 *
 *  @param request request
 *  @param success success callback
 *  @param fail    fail callback
 *
 *  @return requestID
 */
- (NSNumber *)startRequestWithRequest:(NSURLRequest *)request success:(HYCallBack)success fail:(HYCallBack)fail {
    NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.requestList removeObjectForKey:requestID];
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSData *responseData = responseObject;
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        if (error) {
            // 请求失败, 打印log，这块要进行封装，使得log更加易读
            NSLog(@"error");
            NSURLResponse *HYResponse = response;
            // 回调
            fail ? fail(HYResponse) : nil;
        }else {
            //打印log，回调 要封装
            NSLog(@"success");
            NSURLResponse *HYResponse = response;
            
            success ? success(HYResponse) : nil;
        }
    }];
    NSNumber *requestID = @([dataTask taskIdentifier]);
    
    [self.requestList setObject:dataTask forKey:requestID];
    [dataTask resume];
    
    return requestID;
}

#pragma mark - setter and getter
- (NSMutableDictionary *)requestList {
    if (!_requestList) {
        _requestList = [NSMutableDictionary new];
    }
    return _requestList;
}

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc] init];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy.validatesDomainName = NO;
    }
    return _sessionManager;
}

@end