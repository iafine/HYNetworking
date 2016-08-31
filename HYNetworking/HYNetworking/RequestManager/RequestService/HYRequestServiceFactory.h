//
//  HYRequestServiceFactory.h
//  HYNetworking
//
//  Created by work on 16/8/31.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYRequestService.h"

@interface HYRequestServiceFactory : NSObject

+ (instancetype)sharedInstance;

/**
 *  @author hyyy, 16-08-31 09:08:03
 *
 *  @brief 生成请求服务类
 *
 *  @return 请求服务类
 */
- (HYRequestService<HYRequestServiceProtocol> *)generatorRequestService;

@end
