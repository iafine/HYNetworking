//
//  HYResponseManager.h
//  HYNetworking
//
//  Created by work on 16/8/30.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HYNetworkResponseStatus) {
    HYNetworkResponseStatusSuccess,
    HYNetworkResponseStatusErrorTimeOut,
    HYNetworkResponseStatusErrorNotWork,
};

@interface HYResponseManager : NSObject

@property (copy, nonatomic, readonly) NSURLRequest *request;
@property (assign, nonatomic, readonly) NSInteger requestID;
@property (copy, nonatomic, readonly) NSDictionary *requestParams;
@property (assign, nonatomic, readonly) HYNetworkResponseStatus status;
@property (copy, nonatomic, readonly) id content;
@property (copy, nonatomic, readonly) NSString *contentStr;
@property (copy, nonatomic, readonly) NSData *responseData;
@property (copy, nonatomic, readonly) NSError *responseError;

/**
 *  @author hyyy, 16-08-31 15:08:05
 *
 *  @brief 初始化请求响应
 *
 *  @param response
 *  @param responseData
 *  @param requestID
 *  @param request
 *  @param error
 *
 *  @return
 */
- (instancetype)initWithResponse:(NSURLResponse *)response
                    responseData:(NSData *)responseData
                       requestID:(NSNumber *)requestID
                         request:(NSURLRequest *)request
                           error:(NSError *)error;

@end
