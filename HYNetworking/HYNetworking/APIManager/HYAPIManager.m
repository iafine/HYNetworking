//
//  HYAPIManager.m
//  HYNetworking
//
//  Created by work on 16/9/2.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import "HYAPIManager.h"
#import "HYNetworkContext.h"
#import "HYAPIProxy.h"
#import "HYResponseManager.h"

@interface HYAPIManager()

@property (assign, nonatomic, readwrite) HYAPIManagerErrorType errorType;
@property (copy, nonatomic, readwrite) NSString *errorMessage;

// 定义是为了requestType有个默认值，防止用户不重写requestType方法造成的crash。
@property (assign, nonatomic) HYAPIManagerRequestType requestType;

@property (strong, nonatomic) NSMutableArray *requestIDArr;

@end
@implementation HYAPIManager

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(HYAPIManagerRequestSource)]) {
            self.requestSource = (id<HYAPIManagerRequestSource>)self;
        }else {
            NSException *exception = [[NSException alloc] init];
            @throw exception;
        }
        if ([self conformsToProtocol:@protocol(HYAPIManagerValidator)]) {
            self.validator = (id<HYAPIManagerValidator>)self;
        }else {
            NSException *exception = [[NSException alloc] init];
            @throw exception;
        }
    }
    return self;
}

- (void)dealloc {
    [self cancelAllRequests];
    self.requestIDArr = nil;
}

#pragma mark - public methods
- (NSInteger)loadData {
    NSDictionary *params = [self.paramsSource paramsWithManager:self];
    NSInteger requestID = [self loadDataWithParams:params];
    return requestID;
}

- (void)cancelRequestWithRequestID:(NSInteger)requestID {
    [self removeRequestIDWithRequestID:requestID];
    [[HYAPIProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
}

- (void)cancelAllRequests {
    [[HYAPIProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIDArr];
    [self.requestIDArr removeAllObjects];
}

#pragma mark - private methods
- (NSInteger)loadDataWithParams:(NSDictionary *)params {
    NSInteger requestID = 0;
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
    return requestID;
}

/**
 *  网络请求操作，返回requestID
 */
- (NSInteger)startRequestWithParams:(NSDictionary *)params {
    NSInteger requestID = 0;
    
    switch (self.requestSource.requestType) {
        case HYAPIManagerRequestTypeGet:{
            __weak typeof(self) weakSelf = self;
            requestID = [[HYAPIProxy sharedInstance] GETWithPamrams:params methodName:self.requestSource.methodName success:^(HYResponseManager *response) {
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
            requestID = [[HYAPIProxy sharedInstance] POSTWithPamrams:params methodName:self.requestSource.methodName success:^(HYResponseManager *response) {
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
            requestID = [[HYAPIProxy sharedInstance] PUTWithPamrams:params methodName:self.requestSource.methodName success:^(HYResponseManager *response) {
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
            requestID = [[HYAPIProxy sharedInstance] DELETEWithPamrams:params methodName:self.requestSource.methodName success:^(HYResponseManager *response) {
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
    self.errorType = errorType;
    [self removeRequestIDWithRequestID:response.requestID];
    
    // 超时处理
    if (response.status == HYNetworkResponseStatusErrorTimeOut) {
        self.errorType = HYAPIManagerErrorTypeTimeOut;
    }
    
    // 打印出错信息
    [self printDebugLogWithErrorType:self.errorType];
    
    // 请求失败，回调
    if ([self.delegate respondsToSelector:@selector(callBackAPIDidFailed:)]) {
        [self.delegate callBackAPIDidFailed:self];
    }
}

/**
 *  移除某个RequestID
 */
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

/**
 *  根据错误类型打印出错信息 (开发所用)
 */
- (void)printDebugLogWithErrorType:(HYAPIManagerErrorType)errorType {

#ifdef DEBUG
    switch (self.errorType) {
        case HYAPIManagerErrorTypeParamsError:{
            NSString *errorInfo = @"原因：参数校验失败，请在重写的[manager:isCorrectWithParamsData:]检查参数验证是否正确。";
            NSLog(@"%@", errorInfo);
            break;
        }
            
        case HYAPIManagerErrorTypeNoNetWork:{
            NSString *errorInfo = @"原因：设备网络状况异常，请检查设备是否连接网络。";
            NSLog(@"%@", errorInfo);
            break;
        }
            
        case HYAPIManagerErrorTypeNoContent:{
            NSString *errorInfo = @"原因：返回数据校验失败，请在重写的[manager:isCorrectWithResponseContentData:]检查返回数据是否符合要求。";
            NSLog(@"%@", errorInfo);
            break;
        }
            
        case HYAPIManagerErrorTypeTimeOut:{
            NSString *errorInfo = @"原因：请求超时。";
            NSLog(@"%@", errorInfo);
            break;
        }
            
        default:
            break;
    }
#endif
}

#pragma mark - setter and getter
- (BOOL)isReachable {
    BOOL isReachability = [[HYNetworkContext sharedInstance] isReachable];
    if (!isReachability) {
        self.errorType = HYAPIManagerErrorTypeNoNetWork;
    }
    return isReachability;
}

@end
