//
//  HYResponseManager.h
//  HYNetworking
//
//  Created by work on 15/8/30.
//  Copyright © 2015年 hyyy. All rights reserved.
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
 *  初始化请求响应
 */
- (instancetype)initWithResponse:(NSURLResponse *)response
                    responseData:(NSData *)responseData
                       requestID:(NSNumber *)requestID
                         request:(NSURLRequest *)request
                           error:(NSError *)error;

@end
