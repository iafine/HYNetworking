//
//  HYCustomRequestService.m
//  HYNetworking
//
//  Created by work on 15/8/31.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import "HYCustomRequestService.h"
#import "HYNetworkContext.h"

@implementation HYCustomRequestService

- (BOOL)isOnline {
    return [[HYNetworkContext sharedInstance] isOnline];
}

- (NSString *)offlineApiBaseUrl {
    return [[HYNetworkContext sharedInstance] offlineApiBaseUrl];
}

- (NSString *)onlineApiBaseUrl {
    return [[HYNetworkContext sharedInstance] onlineApiBaseUrl];
}

- (NSString *)offlineApiVersion {
    return [[HYNetworkContext sharedInstance] offlineApiVersion];
}

- (NSString *)onlineApiVersion {
    return [[HYNetworkContext sharedInstance] onlineApiVersion];
}

@end
