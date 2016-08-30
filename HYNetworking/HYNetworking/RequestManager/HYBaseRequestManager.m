//
//  HYRequestManager.m
//  HYNetworking
//
//  Created by work on 16/8/29.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import "HYBaseRequestManager.h"
#import "HYBaseRequestManagerFactory.h"
#import "AFURLRequestSerialization.h"
#import "HYCommonParams.h"
#import "NSURLRequest+HYNetworkingMethods.h"

@interface HYBaseRequestManager()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation HYBaseRequestManager

#pragma mark - life cycle

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static HYBaseRequestManager *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HYBaseRequestManager alloc] init];
        if ([self conformsToProtocol:@protocol(HYBaseRequestManagerService)]) {
            sharedInstance.service = (id<HYBaseRequestManagerService>)self;
        }
    });
    return sharedInstance;
}

#pragma mark - public methods
- (NSURLRequest *)GETRequestWithRequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    
    HYBaseRequestManager *requestService = [[HYBaseRequestManagerFactory sharedInstance] generatorRequestService];
    
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
    
    return request;
}

#pragma mark - setter and getter
- (NSString *)apiBaseUrl {
    return self.service.isOnline ? self.service.onlineApiBaseUrl : self.service.offlineApiBaseUrl;
}

- (NSString *)apiVersion {
    return self.service.isOnline ? self.service.onlineApiVersion : self.service.offlineApiVersion;
}

- (AFHTTPRequestSerializer *)httpRequestSerializer {
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = 60;    // 这个值要改成可配置的
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}
@end
