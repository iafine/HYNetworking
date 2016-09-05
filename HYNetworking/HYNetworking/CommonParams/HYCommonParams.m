//
//  HYCommonParams.m
//  HYNetworking
//
//  Created by work on 15/8/29.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import "HYCommonParams.h"
#import "HYNetworkContext.h"

@implementation HYCommonParams

+ (NSDictionary *)generatorGETRequestCommonParams {
    return [[HYNetworkContext sharedInstance] GETCommonParams];
}

+ (NSDictionary *)generatorPOSTRequestCommonParams {
    return [[HYNetworkContext sharedInstance] POSTCommonParams];
}

+ (NSDictionary *)generatorPUTRequestCommonParams {
    return [[HYNetworkContext sharedInstance] PUTCommonParams];
}

+ (NSDictionary *)generatorDELETERequestCommonParams {
    return [[HYNetworkContext sharedInstance] DELETECommonParams];
}

@end
