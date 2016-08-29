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

- (HYBaseRequestManager<HYBaseRequestManagerService> *)generatorRequestService;

@end
