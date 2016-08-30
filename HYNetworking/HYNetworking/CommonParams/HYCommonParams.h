//
//  HYCommonParams.h
//  HYNetworking 
//
//  Created by work on 16/8/29.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYCommonParams : NSObject

/**
 *  @author hyyy, 16-08-29 17:08:17
 *
 *  @brief 生成GET请求公共入参
 *
 *  @return 公共入参
 */
+ (NSDictionary *)generatorGETRequestCommonParams;

/**
 *  @author hyyy, 16-08-29 17:08:35
 *
 *  @brief 生成POST请求公共入参
 *
 *  @return 公共入参
 */
+ (NSDictionary *)generatorPOSTRequestCommonParams;

/**
 *  @author hyyy, 16-08-29 17:08:42
 *
 *  @brief 生成PUT请求公共入参
 *
 *  @return 公共入参
 */
+ (NSDictionary *)generatorPUTRequestCommonParams;

/**
 *  @author hyyy, 16-08-29 17:08:06
 *
 *  @brief 生成DELETE请求公共入参
 *
 *  @return 公共入参
 */
+ (NSDictionary *)generatorDELETERequestCommonParams;

@end
