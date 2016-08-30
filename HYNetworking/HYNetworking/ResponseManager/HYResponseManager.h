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

- (instancetype)initWithRequest:(NSURLRequest *)request requestID:(NSNumber *)requestID responseData:(NSData *)responseData error:(NSError *)error;

@end
