//
//  HYNetworkContext.h
//  HYNetworking
//
//  Created by work on 16/9/5.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYNetworkContext : NSObject

// 设备信息
@property (copy, nonatomic, readonly) NSString *deviceName;
@property (copy, nonatomic, readonly) NSString *deviceSystemName;
@property (copy, nonatomic, readonly) NSString *deviceSystemVersion;
@property (copy, nonatomic, readonly) NSString *deviceModel;
@property (copy, nonatomic, readonly) NSString *deviceUUID;
@property (copy, nonatomic, readonly) NSString *devicePPI;  // update iPhone SE
@property (assign, nonatomic, readonly) CGSize deviceSize; // update iPhone SE

// 运行环境相关
@property (assign, nonatomic, readonly) BOOL isReachable;
@property (assign, nonatomic, readonly) BOOL isOnline;
@property (copy, nonatomic, readonly) NSString *offlineApiBaseUrl;
@property (copy, nonatomic, readonly) NSString *onlineApiBaseUrl;
@property (copy, nonatomic, readonly) NSString *offlineApiVersion;
@property (copy, nonatomic, readonly) NSString *onlineApiVersion;
@property (copy, nonatomic, readonly) NSString *timeoutInterval;

// 公共入参配置
@property (copy, nonatomic, readonly) NSDictionary *GETCommonParams;
@property (copy, nonatomic, readonly) NSDictionary *POSTCommonParams;
@property (copy, nonatomic, readonly) NSDictionary *PUTCommonParams;
@property (copy, nonatomic, readonly) NSDictionary *DELETECommonParams;

+ (instancetype)sharedInstance;

@end
