//
//  HYRequestServiceFactory.m
//  HYNetworking
//
//  Created by work on 15/8/31.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import "HYRequestServiceFactory.h"
#import "HYCustomRequestService.h"

@implementation HYRequestServiceFactory

#pragma mark - life cycle
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static HYRequestServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HYRequestServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (HYRequestService<HYRequestServiceProtocol> *)generatorRequestService {
    return [[HYCustomRequestService alloc] init];
}

@end
