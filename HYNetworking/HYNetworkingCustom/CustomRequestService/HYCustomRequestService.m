//
//  HYCustomRequestService.m
//  HYNetworking
//
//  Created by work on 15/8/31.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import "HYCustomRequestService.h"
#import "HYAppContext.h"

@implementation HYCustomRequestService

- (BOOL)isOnline {
    return [[HYAppContext sharedInstance] isOnline];
}

- (NSString *)offlineApiBaseUrl {
    return [[HYAppContext sharedInstance] offlineApiBaseUrl];
}

- (NSString *)onlineApiBaseUrl {
    return [[HYAppContext sharedInstance] onlineApiBaseUrl];
}

- (NSString *)offlineApiVersion {
    return [[HYAppContext sharedInstance] offlineApiVersion];
}

- (NSString *)onlineApiVersion {
    return [[HYAppContext sharedInstance] onlineApiVersion];
}

@end
