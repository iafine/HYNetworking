//
//  HYRequestManager.m
//  HYNetworking
//
//  Created by work on 15/8/31.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import "HYRequestManager.h"
#import "HYRequestService.h"
#import "HYRequestServiceFactory.h"
#import "HYCommonParams.h"
#import "AFURLRequestSerialization.h"
#import "NSURLRequest+HYNetworkingMethods.h"
#import "HYLogger.h"

@interface HYRequestManager()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation HYRequestManager

#pragma mark - life cycle
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static HYRequestManager *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HYRequestManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (NSURLRequest *)GETRequestWithRequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    
    HYRequestService *requestService = [[HYRequestServiceFactory sharedInstance] generatorRequestService];
    
    NSParameterAssert(requestService.apiBaseUrl);
    
    NSString *requestUrl;
    if (requestService.apiVersion.length != 0) {
        requestUrl = [NSString stringWithFormat:@"%@/%@/%@", requestService.apiBaseUrl, requestService.apiVersion, methodName];
    }else {
        requestUrl = [NSString stringWithFormat:@"%@/%@", requestService.apiBaseUrl, methodName];
    }
    
    // 构建公共入参
    NSMutableDictionary *completeParams = [NSMutableDictionary new];
    [completeParams addEntriesFromDictionary:requestParams];
    [completeParams addEntriesFromDictionary:[HYCommonParams generatorGETRequestCommonParams]];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:requestUrl parameters:completeParams error:nil];
    request.hy_requestParams = completeParams;
    
    // 打印日志
    [HYLogger printDebugLogWithRequest:request requestService:requestService requestUrl:requestUrl methodName:methodName];
    
    return request;
}

- (NSURLRequest *)POSTRequestWithRequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    HYRequestService *requestService = [[HYRequestServiceFactory sharedInstance] generatorRequestService];
    
    NSParameterAssert(requestService.apiBaseUrl);
    
    NSString *requestUrl;
    if (requestService.apiVersion.length != 0) {
        requestUrl = [NSString stringWithFormat:@"%@/%@/%@", requestService.apiBaseUrl, requestService.apiVersion, methodName];
    }else {
        requestUrl = [NSString stringWithFormat:@"%@/%@", requestService.apiBaseUrl, methodName];
    }
    
    // 构建公共入参
    NSMutableDictionary *completeParams = [NSMutableDictionary new];
    [completeParams addEntriesFromDictionary:requestParams];
    [completeParams addEntriesFromDictionary:[HYCommonParams generatorPOSTRequestCommonParams]];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:requestUrl parameters:completeParams error:nil];
    request.hy_requestParams = completeParams;
    
    // 打印日志
    [HYLogger printDebugLogWithRequest:request requestService:requestService requestUrl:requestUrl methodName:methodName];
    
    return request;
}

- (NSURLRequest *)PUTRequestWithRequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    HYRequestService *requestService = [[HYRequestServiceFactory sharedInstance] generatorRequestService];
    
    NSParameterAssert(requestService.apiBaseUrl);
    
    NSString *requestUrl;
    if (requestService.apiVersion.length != 0) {
        requestUrl = [NSString stringWithFormat:@"%@/%@/%@", requestService.apiBaseUrl, requestService.apiVersion, methodName];
    }else {
        requestUrl = [NSString stringWithFormat:@"%@/%@", requestService.apiBaseUrl, methodName];
    }
    
    // 构建公共入参
    NSMutableDictionary *completeParams = [NSMutableDictionary new];
    [completeParams addEntriesFromDictionary:requestParams];
    [completeParams addEntriesFromDictionary:[HYCommonParams generatorPUTRequestCommonParams]];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"PUT" URLString:requestUrl parameters:completeParams error:nil];
    request.hy_requestParams = completeParams;
    
    // 打印日志
    [HYLogger printDebugLogWithRequest:request requestService:requestService requestUrl:requestUrl methodName:methodName];
    
    return request;
}

- (NSURLRequest *)DELETERequestWithRequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    HYRequestService *requestService = [[HYRequestServiceFactory sharedInstance] generatorRequestService];
    
    NSParameterAssert(requestService.apiBaseUrl);
    
    NSString *requestUrl;
    if (requestService.apiVersion.length != 0) {
        requestUrl = [NSString stringWithFormat:@"%@/%@/%@", requestService.apiBaseUrl, requestService.apiVersion, methodName];
    }else {
        requestUrl = [NSString stringWithFormat:@"%@/%@", requestService.apiBaseUrl, methodName];
    }
    
    // 构建公共入参
    NSMutableDictionary *completeParams = [NSMutableDictionary new];
    [completeParams addEntriesFromDictionary:requestParams];
    [completeParams addEntriesFromDictionary:[HYCommonParams generatorDELETERequestCommonParams]];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"DELETE" URLString:requestUrl parameters:completeParams error:nil];
    request.hy_requestParams = completeParams;
    
    // 打印日志
    [HYLogger printDebugLogWithRequest:request requestService:requestService requestUrl:requestUrl methodName:methodName];
    
    return request;
}

#pragma mark - setter and getter
- (AFHTTPRequestSerializer *)httpRequestSerializer {
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = 60;    // 这个值要改成可配置的
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}

@end
