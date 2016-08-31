//
//  HYRequestService.m
//  HYNetworking
//
//  Created by work on 16/8/31.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import "HYRequestService.h"

@interface HYRequestService()

@property (weak, nonatomic) id<HYRequestServiceProtocol> service;

@end

@implementation HYRequestService

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(HYRequestServiceProtocol)]) {
            self.service = (id<HYRequestServiceProtocol>)self;
        }
    }
    return self;
}

#pragma mark - setter and getter
- (NSString *)apiBaseUrl {
    return self.service.isOnline ? self.service.onlineApiBaseUrl : self.service.offlineApiBaseUrl;
}

- (NSString *)apiVersion {
    return self.service.isOnline ? self.service.onlineApiVersion : self.service.offlineApiVersion;
}

@end
