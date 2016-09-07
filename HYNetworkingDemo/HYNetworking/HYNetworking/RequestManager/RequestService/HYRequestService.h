//
//  HYRequestService.h
//  HYNetworking
//
//  Created by work on 15/8/31.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

/*************************************************************************************************/
/*                                       HYRequestServiceProtocol                                */
/*************************************************************************************************/
/**
 *  请求相关的服务协议，子类需要重写该协议
 */
@protocol HYRequestServiceProtocol <NSObject>

@property (assign, nonatomic, readonly) BOOL isOnline;

@property (strong, nonatomic, readonly) NSString *offlineApiBaseUrl;
@property (strong, nonatomic, readonly) NSString *onlineApiBaseUrl;

@property (strong, nonatomic, readonly) NSString *offlineApiVersion;
@property (strong, nonatomic, readonly) NSString *onlineApiVersion;

@end

@interface HYRequestService : NSObject

@property (strong, nonatomic, readonly) NSString *apiBaseUrl;
@property (strong, nonatomic, readonly) NSString *apiVersion;

@end
