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
    return HYAPIManagerRequestTypeGet;  // 知乎日报接口为GET请求
}

#pragma mark - HYAPIManagerValidator
- (BOOL)manager:(HYAPIManager *)manager isCorrectWithResponseContentData:(id)content {
    if (content) {
        return YES;
    }
    return NO;
}

- (BOOL)manager:(HYAPIManager *)manager isCorrectWithParamsData:(NSDictionary *)params {
    NSString *userId = [params objectForKey:@"userid"];
    if ([userId integerValue] == 12) {
        return YES;
    }
    return NO;
}

@end
