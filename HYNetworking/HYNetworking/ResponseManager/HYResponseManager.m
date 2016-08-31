//
//  HYResponseManager.m
//  HYNetworking
//
//  Created by work on 15/8/30.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import "HYResponseManager.h"
#import "NSURLRequest+HYNetworkingMethods.h"
#import "HYLogger.h"

@interface HYResponseManager()

@property (copy, nonatomic, readwrite) NSURLRequest *request;
@property (assign, nonatomic, readwrite) NSInteger requestID;
@property (copy, nonatomic, readwrite) NSDictionary *requestParams;
@property (assign, nonatomic, readwrite) HYNetworkResponseStatus status;
@property (copy, nonatomic, readwrite) id content;
@property (copy, nonatomic, readwrite) NSString *contentStr;
@property (copy, nonatomic, readwrite) NSData *responseData;
@property (copy, nonatomic, readwrite) NSError *responseError;

@end
@implementation HYResponseManager

#pragma mark - life cycle
- (instancetype)initWithResponse:(NSURLResponse *)response responseData:(NSData *)responseData requestID:(NSNumber *)requestID request:(NSURLRequest *)request error:(NSError *)error {
    self = [super init];
    if (self) {
        self.request = request;
        self.requestID = [requestID integerValue];
        self.requestParams = request.hy_requestParams;
        self.status = [self responseStatusWithError:error];
        self.responseData = responseData;
        self.responseError = error;
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
            self.contentStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        }else {
            self.content = nil;
            self.contentStr = nil;
        }
        
        // 打印日志
        [HYLogger printDebugLogWithResponse:response content:self.content request:request error:error];
    }
    return self;
}

#pragma mark - private methods
- (HYNetworkResponseStatus)responseStatusWithError:(NSError *)error {
    
    if (error) {
        HYNetworkResponseStatus status = HYNetworkResponseStatusErrorNotWork;
        
        // 超时错误，特殊处理
        if (error.code == NSURLErrorTimedOut) {
            status = HYNetworkResponseStatusErrorTimeOut;
        }
        return status;
    }else {
        return HYNetworkResponseStatusSuccess;
    }
}

@end
