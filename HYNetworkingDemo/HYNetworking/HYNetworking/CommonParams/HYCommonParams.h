//
//  HYCommonParams.h
//  HYNetworking 
//
//  Created by work on 15/8/29.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYCommonParams : NSObject

/**
 *  生成GET请求公共入参
 */
+ (NSDictionary *)generatorGETRequestCommonParams;

/**
 *  生成POST请求公共入参
 */
+ (NSDictionary *)generatorPOSTRequestCommonParams;

/**
 *  生成PUT请求公共入参
 */
+ (NSDictionary *)generatorPUTRequestCommonParams;

/**
 *  生成DELETE请求公共入参
 */
+ (NSDictionary *)generatorDELETERequestCommonParams;

@end
