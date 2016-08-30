//
//  HYBaseRequestManagerFactory.h
//  HYNetworking
//
//  Created by work on 16/8/29.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYBaseRequestManager.h"

@interface HYBaseRequestManagerFactory : NSObject

+ (instancetype)sharedInstance;

/**
 *  @author hyyy, 16-08-30 17:08:15
 *
 *  @brief 工厂模式代理
 *
 *  @return <#return value description#>
 */
- (HYBaseRequestManager<HYBaseRequestManagerService> *)generatorRequestService;

@end
