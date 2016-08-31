//
//  HYAPIProxy.h
//  HYNetworking
//
//  Created by work on 16/8/25.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYResponseManager.h"

typedef void(^HYCallBack)(HYResponseManager *response);

@interface HYAPIProxy : NSObject

+ (instancetype)sharedInstance;

/**
 *  @author hyyy, 16-08-25 15:08:38
 *
 *  @brief GET请求方法
 *
 *  @param params
 *  @param methodName
 *  @param success
 *  @param fail        
 *
 *  @return requestID
 */
- (NSInteger)getWithPamrams:(NSDictionary *)params
                 methodName:(NSString *)methodName
                    success:(HYCallBack)success
                       fail:(HYCallBack)fail;

@end
