//
//  HYAPIManager.h
//  HYNetworking
//
//  Created by work on 16/9/2.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYResponseManager.h"
#import "HYAPIManager.h"

@class HYAPIManager;

/**
 *  请求类型 (GET, POST, PUT, DELETE)
 */
typedef NS_ENUM(NSUInteger, HYAPIManagerRequestType) {
    /**
     *  GET
     */
    HYAPIManagerRequestTypeGet,
    /**
     *  POST
     */
    HYAPIManagerRequestTypePost,
    /**
     *  PUT
     */
    HYAPIManagerRequestTypePut,
    /**
     *  DELETE
     */
    HYAPIManagerRequestTypeDelete
};

/**
 *  请求错误类型
 */
typedef NS_ENUM(NSUInteger, HYAPIManagerErrorType) {
    /**
     *  默认状态 (正常情况下请求失败)
     */
    HYAPIManagerErrorTypeDefault,
    /**
     *  无网络状态 (处于断网状态或者网络不通畅)
     */
    HYAPIManagerErrorTypeNoNetWork,
    /**
     *  请求参数错误状态 (请求参数有误)
     */
    HYAPIManagerErrorTypeParamsError,
    /**
     *  超时状态 (请求超时)
     */
    HYAPIManagerErrorTypeTimeOut,
    /**
     *  响应数据校验失败状态 (请求成功，响应返回的数据进行校验[isCorrectWithResponseContentData]时失败)
     */
    HYAPIManagerErrorTypeNoContent,
    /**
     *  响应成功状态
     */
    HYAPIManagerErrorTypeSuccess,
};

/*************************************************************************************************/
/*                                   HYAPIManagerRequestSource                                   */
/*************************************************************************************************/
@protocol HYAPIManagerRequestSource <NSObject>

/**
 *  请求方法名 (注意不需要带“/”, 必须重写)
 */
- (NSString *)methodName;
/**
 *  请求类型 (默认为GET， 建议必须重写此方法)
 */
- (HYAPIManagerRequestType)requestType;

@end

/*************************************************************************************************/
/*                               HYAPIManagerParamSource                                         */
/*************************************************************************************************/
@protocol HYAPIManagerParamSource <NSObject>

@required
/**
 *  返回请求的参数 (带参数的请求需要重写该协议)
 */
- (NSDictionary *)paramsWithManager:(HYAPIManager *)manager;

@end

/*************************************************************************************************/
/*                               HYAPIManagerCallBackDelegate                                    */
/*************************************************************************************************/
@protocol HYAPIManagerCallBackDelegate <NSObject>

@required

/**
 *  请求成功之后的回调
 */
- (void)callBackAPIDidSuccess:(HYAPIManager *)manager;
/**
 *  请求失败后的回调
 */
- (void)callBackAPIDidFailed:(HYAPIManager *)manager;

@end

/*************************************************************************************************/
/*                               HYAPIManagerValidator                                           */
/*************************************************************************************************/
@protocol HYAPIManagerValidator <NSObject>

@required
/**
 *  验证请求参数是否合法 (比如邮箱、密码、用户名规则等验证，默认是YES)
 */
- (BOOL)manager:(HYAPIManager *)manager isCorrectWithParamsData:(NSDictionary *)params;
/**
 *  验证响应数据是否合法 (比如返回数据字段检查等，默认是YES)
 */
- (BOOL)manager:(HYAPIManager *)manager isCorrectWithResponseContentData:(id)content;

@end

@interface HYAPIManager : NSObject

@property (weak, nonatomic) id<HYAPIManagerRequestSource> requestSource;
@property (weak, nonatomic) id<HYAPIManagerParamSource> paramsSource;
@property (weak, nonatomic) id<HYAPIManagerCallBackDelegate> delegate;
@property (weak, nonatomic) id<HYAPIManagerValidator> validator;

@property (copy, nonatomic, readonly) NSString *errorMessage;
@property (assign, nonatomic, readonly) HYAPIManagerErrorType errorType;

@property (assign, nonatomic, readonly) BOOL isReachable;

@property (strong, nonatomic) HYResponseManager *response;

/**
 *  请求方法，返回requestID
 */
- (NSInteger)loadData;

/**
 *  根据requestID取消请求
 */
- (void)cancelRequestWithRequestID:(NSInteger)requestID;

/**
 *  取消全部请求
 */
- (void)cancelAllRequests;

@end

