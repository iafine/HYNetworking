//
//  HYBaseAPIManager.m
//  HYNetworking
//
//  Created by work on 16/9/1.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import "HYBaseAPIManager.h"
#import "HYAppContext.h"
#import "HYAPIProxy.h"
#import "HYResponseManager.h"

@interface HYBaseAPIManager()

@property (assign, nonatomic, readwrite) HYAPIManagerErrorType errorType;

@property (strong, nonatomic) NSMutableArray *requestIDArr;

@end
@implementation HYBaseAPIManager

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(HYAPIManager)]) {
            self.manager = (id<HYAPIManager>)self;
        }else {
            NSException *exception = [[NSException alloc] init];
            @throw exception;
        }
    }
    return self;
}

#pragma mark - public methods
- (NSInteger)loadData {
    NSDictionary *params = [self.paramsSource paramsWithManager:self];
    NSInteger requestID = [self loadDataWithParams:params];
    return requestID;
}

#pragma mark - private methods
- (NSInteger)loadDataWithParams:(NSDictionary *)params {
    NSInteger requestID = 0;
    if ([self.validator respondsToSelector:@selector(manager:isCorrectWithParamsData:)]) {
        if ([self.validator manager:self isCorrectWithParamsData:params]) {
            // 这里本该先检查是否有缓存，完成后去掉注释
            // 检查缓存
            // 网络请求
            if (self.isReachable) {
                requestID = [self startRequestWithParams:params];
            }else {
                [self failedWhenLoadData:nil errorType:HYAPIManagerErrorTypeNoNetWork];
                return requestID;
            }
        }else {
            [self failedWhenLoadData:nil errorType:HYAPIManagerErrorTypeParamsError];
            return requestID;
        }
    }
    return requestID;
}

/**
 *  网络请求操作，返回requestID
 */
- (NSInteger)startRequestWithParams:(NSDictionary *)params {
    NSInteger requestID = 0;
    switch (self.manager.requestType) {
        case HYAPIManagerRequestTypeGet:{
            __weak typeof(self) weakSelf = self;
            requestID = [[HYAPIProxy sharedInstance] GETWithPamrams:params methodName:self.manager.methodName success:^(HYResponseManager *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                // 成功后调用
                [strongSelf successedWhenLoadData:response];
            } fail:^(HYResponseManager *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                // 失败后调用
                [strongSelf failedWhenLoadData:response errorType:HYAPIManagerErrorTypeDefault];
            }];
            [self.requestIDArr addObject:@(requestID)];
            break;
        }
            
        case HYAPIManagerRequestTypePost:{
            __weak typeof(self) weakSelf = self;
            requestID = [[HYAPIProxy sharedInstance] POSTWithPamrams:params methodName:self.manager.methodName success:^(HYResponseManager *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                // 成功后调用
                [strongSelf successedWhenLoadData:response];
            } fail:^(HYResponseManager *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                // 失败后调用
                [strongSelf failedWhenLoadData:response errorType:HYAPIManagerErrorTypeDefault];
            }];
            [self.requestIDArr addObject:@(requestID)];
            break;
        }
            
        case HYAPIManagerRequestTypePut:{
            __weak typeof(self) weakSelf = self;
            requestID = [[HYAPIProxy sharedInstance] PUTWithPamrams:params methodName:self.manager.methodName success:^(HYResponseManager *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                // 成功后调用
                [strongSelf successedWhenLoadData:response];
            } fail:^(HYResponseManager *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                // 失败后调用
                [strongSelf failedWhenLoadData:response errorType:HYAPIManagerErrorTypeDefault];
            }];
            [self.requestIDArr addObject:@(requestID)];
            break;
        }
            
        case HYAPIManagerRequestTypeDelete:{
            __weak typeof(self) weakSelf = self;
            requestID = [[HYAPIProxy sharedInstance] DELETEWithPamrams:params methodName:self.manager.methodName success:^(HYResponseManager *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                // 成功后调用
                [strongSelf successedWhenLoadData:response];
            } fail:^(HYResponseManager *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                // 失败后调用
                [strongSelf failedWhenLoadData:response errorType:HYAPIManagerErrorTypeDefault];
            }];
            [self.requestIDArr addObject:@(requestID)];
            break;
        }
            
        default:
            break;
    }
    return requestID;
}

/**
 *  loadData成功后调用
 */
- (void)successedWhenLoadData:(HYResponseManager *)response {
    [self removeRequestIDWithRequestID:response.requestID];
    if ([self.validator respondsToSelector:@selector(manager:isCorrectWithResponseContentData:)]) {
        if ([self.validator manager:self isCorrectWithResponseContentData:response.content]) {
            // 响应成功， 回调
            self.errorType = HYAPIManagerErrorTypeSuccess;
            if ([self.delegate respondsToSelector:@selector(callBackAPIDidSuccess:)]) {
                [self.delegate callBackAPIDidSuccess:self];
            }
        }else {
            [self failedWhenLoadData:response errorType:HYAPIManagerErrorTypeNoContent];
        }
    }
}

/**
 *  loadData失败后调用
 */
- (void)failedWhenLoadData:(HYResponseManager *)response errorType:(HYAPIManagerErrorType)errorType {
    [self removeRequestIDWithRequestID:response.requestID];
    
    // 请求失败，回调
    if ([self.delegate respondsToSelector:@selector(callBackAPIDidFailed:)]) {
        [self.delegate callBackAPIDidFailed:self];
    }
}

- (void)removeRequestIDWithRequestID:(NSInteger)requestID {
    NSNumber *toRemoveRequestID = nil;
    for (NSNumber *storeRequestID in self.requestIDArr) {
        if ([storeRequestID integerValue] == requestID) {
            toRemoveRequestID = storeRequestID;
        }
    }
    if (toRemoveRequestID) {
        [self.requestIDArr removeObject:toRemoveRequestID];
    }
}

#pragma mark - setter and getter
- (BOOL)isReachable {
    BOOL isReachability = [[HYAppContext sharedInstance] isReachable];
    if (!isReachability) {
        self.errorType = HYAPIManagerErrorTypeNoNetWork;
    }
    return isReachability;
}

@end
