//
//  NSObject+HYNetworkingMethods.h
//  HYNetworking
//
//  Created by work on 15/8/31.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HYNetworkingMethods)

/**
 *  对NSObject类型元素设置默认值
 */
- (id)hy_defaultValue:(id)defaultValue;

/**
 *  判空操作
 */
- (BOOL)hy_isEmptyObject;

@end
