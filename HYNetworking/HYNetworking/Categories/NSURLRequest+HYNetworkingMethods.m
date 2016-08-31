//
//  NSURLRequest+HYNetworkingMethods.m
//  HYNetworking
//
//  Created by work on 15/8/30.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import "NSURLRequest+HYNetworkingMethods.h"
#import <objc/runtime.h>

@implementation NSURLRequest (HYNetworkingMethods)

- (void)setHy_requestParams:(NSDictionary *)hy_requestParams {
    objc_setAssociatedObject(self, @selector(hy_requestParams), hy_requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)hy_requestParams {
    return objc_getAssociatedObject(self, @selector(hy_requestParams));
}

@end
