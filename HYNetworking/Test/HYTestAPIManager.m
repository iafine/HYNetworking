//
//  HYTestAPIManager.m
//  HYNetworking
//
//  Created by work on 16/9/1.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import "HYTestAPIManager.h"

@implementation HYTestAPIManager

#pragma mark - HYAPIManager
- (NSString *)methodName {
    return @"news/latest";
}

- (HYAPIManagerRequestType)requestType {
    return HYAPIManagerRequestTypeGet;
}

@end
