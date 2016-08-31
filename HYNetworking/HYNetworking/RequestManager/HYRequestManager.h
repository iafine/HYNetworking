//
//  HYRequestManager.h
//  HYNetworking
//
//  Created by work on 16/8/31.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYRequestManager : NSObject

+ (instancetype)sharedInstance;

/**
 *  @author hyyy, 16-08-30 17:08:40
 *
 *  @brief 初始化GET请求
 *
 *  @param requestParams
 *  @param methodName    
 *
 *  @return NSURLRequest
 */
- (NSURLRequest *)GETRequestWithRequestParams:(NSDictionary *)requestParams
                                   methodName:(NSString *)methodName;

@end
