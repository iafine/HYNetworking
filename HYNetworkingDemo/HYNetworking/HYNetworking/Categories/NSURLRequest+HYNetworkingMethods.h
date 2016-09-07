//
//  NSURLRequest+HYNetworkingMethods.h
//  HYNetworking
//
//  Created by work on 15/8/30.
//  Copyright © 2015年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (HYNetworkingMethods)

/**
 *  增加一个requestParams属性
 */
@property (copy, nonatomic) NSDictionary *hy_requestParams;

@end
