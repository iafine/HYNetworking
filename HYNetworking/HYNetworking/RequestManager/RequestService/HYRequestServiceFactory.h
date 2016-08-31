//
//  HYRequestServiceFactory.h
//  HYNetworking
//
//  Created by work on 15/8/31.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYRequestService.h"

@interface HYRequestServiceFactory : NSObject

+ (instancetype)sharedInstance;

/**
 *  生成请求服务类
 */
- (HYRequestService<HYRequestServiceProtocol> *)generatorRequestService;

@end
