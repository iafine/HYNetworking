//
//  NSObject+HYNetworkingMethods.m
//  HYNetworking
//
//  Created by work on 15/8/31.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import "NSObject+HYNetworkingMethods.h"

@implementation NSObject (HYNetworkingMethods)

- (id)hy_defaultValue:(id)defaultValue {
    if (![defaultValue isKindOfClass:[self class]]) {
        return defaultValue;
    }
    if ([self hy_isEmptyObject]) {
        return defaultValue;
    }
    return self;
}

- (BOOL)hy_isEmptyObject {
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([(NSDictionary *)self count] == 0) {
            return YES;
        }
    }
    
    return NO;
}
@end
