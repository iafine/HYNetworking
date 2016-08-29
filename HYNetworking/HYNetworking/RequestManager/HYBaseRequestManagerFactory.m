//
//  HYBaseRequestManagerFactory.m
//  HYNetworking
//
//  Created by work on 16/8/29.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import "HYBaseRequestManagerFactory.h"
#import "HYCustomRequest.h"

@implementation HYBaseRequestManagerFactory

#pragma mark - life cycle
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static HYBaseRequestManagerFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HYBaseRequestManagerFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (HYBaseRequestManager<HYBaseRequestManagerService> *)generatorRequestService {
    return [[HYCustomRequest alloc] init];
}

@end
