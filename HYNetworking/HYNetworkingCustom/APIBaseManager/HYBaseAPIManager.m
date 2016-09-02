//
//  HYBaseAPIManager.m
//  HYNetworking
//
//  Created by work on 16/9/1.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import "HYBaseAPIManager.h"

@interface HYBaseAPIManager()<HYAPIManagerRequestSource, HYAPIManagerValidator>

@end

@implementation HYBaseAPIManager

#pragma mark - HYAPIManagerRequestSource
- (NSString *)methodName {
    return @"";
}

- (HYAPIManagerRequestType)requestType {
    return HYAPIManagerRequestTypeGet;
}

#pragma mark - HYAPIManagerValidator
- (BOOL)manager:(id)manager isCorrectWithParamsData:(NSDictionary *)params {
    return YES;
}

- (BOOL)manager:(id)manager isCorrectWithResponseContentData:(id)content {
    return YES;
}

@end
