//
//  HYCustomRequest.m
//  HYNetworking
//
//  Created by work on 16/8/29.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import "HYCustomRequest.h"
#import "HYAppContext.h"

@implementation HYCustomRequest

#pragma mark - HYBaseRequestManagerService
- (BOOL)isOnline {
    return [[HYAppContext sharedInstance] isOnline];
}

- (NSString *)offlineApiBaseUrl {
    return @"http://develop.domain.com";
}

- (NSString *)onlineApiBaseUrl {
    return @"http://product.domain.com";
}

- (NSString *)offlineApiVersion {
    return @"v3";
}

- (NSString *)onlineApiVersion {
    return @"v3";
}

@end
