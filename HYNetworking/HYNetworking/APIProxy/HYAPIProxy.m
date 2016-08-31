//
//  HYAPIProxy.m
//  HYNetworking
//
//  Created by work on 15/8/25.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import "HYAPIProxy.h"
#import <AFNetworking/AFNetworking.h>
#import "HYRequestManager.h"

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

- (NSInteger)GETWithPamrams:(NSDictionary *)params methodName:(NSString *)methodName success:(HYCallBack)success fail:(HYCallBack)fail {
    NSURLRequest *request = [[HYRequestManager sharedInstance] GETRequestWithRequestParams:params methodName:methodName];
    NSNumber *requestID = [self startRequestWithRequest:request success:success fail:fail];
    return [requestID integerValue];
}

- (NSInteger)POSTWithPamrams:(NSDictionary *)params methodName:(NSString *)methodName success:(HYCallBack)success fail:(HYCallBack)fail {
    NSURLRequest *request = [[HYRequestManager sharedInstance] POSTRequestWithRequestParams:params methodName:methodName];
    NSNumber *requestID = [self startRequestWithRequest:request success:success fail:fail];
    return [requestID integerValue];
}

- (NSInteger)PUTWithPamrams:(NSDictionary *)params methodName:(NSString *)methodName success:(HYCallBack)success fail:(HYCallBack)fail {
    NSURLRequest *request = [[HYRequestManager sharedInstance] PUTRequestWithRequestParams:params methodName:methodName];
    NSNumber *requestID = [self startRequestWithRequest:request success:success fail:fail];
    return [requestID integerValue];
}

- (NSInteger)DELETEWithPamrams:(NSDictionary *)params methodName:(NSString *)methodName success:(HYCallBack)success fail:(HYCallBack)fail {
    NSURLRequest *request = [[HYRequestManager sharedInstance] DELETERequestWithRequestParams:params methodName:methodName];
    NSNumber *requestID = [self startRequestWithRequest:request success:success fail:fail];
    return [requestID integerValue];
}

/**
 *  将使用到AFNetworking的东西进行归总，如果以后需要更改底层网络框架，那么直接在此方法里修改即可。
 */
- (NSNumber *)startRequestWithRequest:(NSURLRequest *)request success:(HYCallBack)success fail:(HYCallBack)fail {
    NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.requestList removeObjectForKey:requestID];
        
        if (error) {
            NSLog(@"error");
            HYResponseManager *HYResponse = [[HYResponseManager alloc] initWithResponse:response responseData:responseObject requestID:requestID request:request error:error];
            fail ? fail(HYResponse) : nil;
        }else {
            NSLog(@"success");
            HYResponseManager *HYResponse = [[HYResponseManager alloc] initWithResponse:response responseData:responseObject requestID:requestID request:request error:error];
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