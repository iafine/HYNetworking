//
//  HYAppContext.h
//  HYNetworking
//
//  Created by work on 16/8/26.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYAppContext : NSObject

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

// 用户信息
@property (copy, nonatomic, readonly) NSString *accessToken;
@property (copy, nonatomic, readonly) NSDictionary *userInfo;
@property (copy, nonatomic, readonly) NSString *userID;
@property (assign, nonatomic, readonly) BOOL idLoggedIn;

// app信息
@property (copy, nonatomic, readonly) NSString *sessionID;  // app每次启动都会生成
@property (copy, nonatomic, readonly) NSString *appVersion;


+ (instancetype)sharedInstance;

@end
