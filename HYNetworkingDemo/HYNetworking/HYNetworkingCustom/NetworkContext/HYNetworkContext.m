//
//  HYNetworkContext.m
//  HYNetworking
//
//  Created by work on 16/9/5.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import "HYNetworkContext.h"
#import "AFNetworkReachabilityManager.h"

@implementation HYNetworkContext

#pragma mark - life cycle
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static HYNetworkContext *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HYNetworkContext alloc] init];
    });
    return sharedInstance;
}

#pragma mark - setter and getter
/*********************************运行环境相关*********************************************/
- (BOOL)isReachable {
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    }else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

- (BOOL)isOnline {
    BOOL isOnline = NO;
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"HYNetworkConfiguration" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:filepath];
        isOnline = [settings[@"isOnline"] boolValue];
    }
    return isOnline;
}

- (NSString *)offlineApiBaseUrl {
    NSString *offlineApiBaseUrl;
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"HYNetworkConfiguration" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:filepath];
        offlineApiBaseUrl = [settings objectForKey:@"offlineApiBaseUrl"];
    }else {
        offlineApiBaseUrl = @"";
    }
    return offlineApiBaseUrl;
}

- (NSString *)onlineApiBaseUrl {
    NSString *onlineApiBaseUrl;
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"HYNetworkConfiguration" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:filepath];
        onlineApiBaseUrl = [settings objectForKey:@"onlineApiBaseUrl"];
    }else {
        onlineApiBaseUrl = @"";
    }
    return onlineApiBaseUrl;
}

- (NSString *)offlineApiVersion {
    NSString *offlineApiVersion;
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"HYNetworkConfiguration" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:filepath];
        offlineApiVersion = [settings objectForKey:@"offlineApiVersion"];
    }else {
        offlineApiVersion = @"";
    }
    return offlineApiVersion;
}

- (NSString *)onlineApiVersion {
    NSString *onlineApiVersion;
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"HYNetworkConfiguration" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:filepath];
        onlineApiVersion = [settings objectForKey:@"onlineApiVersion"];
    }else {
        onlineApiVersion = @"";
    }
    return onlineApiVersion;
}

- (NSString *)timeoutInterval {
    NSString *timeoutInterval;
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"HYNetworkConfiguration" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:filepath];
        timeoutInterval = [settings objectForKey:@"timeoutInterval"];
    }else {
        timeoutInterval = @"";
    }
    return timeoutInterval;
}
/*********************************************公共入参*********************************************/
- (NSDictionary *)GETCommonParams {
    return @{
             };
}

- (NSDictionary *)POSTCommonParams {
    return @{
             };
}

- (NSDictionary *)PUTCommonParams {
    return @{
             };
}

- (NSDictionary *)DELETECommonParams {
    return @{
             };
}

/*********************************************设备信息*********************************************/
- (NSString *)deviceName {
    return [[UIDevice currentDevice] name];
}

- (NSString *)deviceSystemName {
    return [[UIDevice currentDevice] systemName];
}

- (NSString *)deviceSystemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)deviceModel {
    return [[UIDevice currentDevice] model];
}

- (NSString *)deviceUUID {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)devicePPI {
    NSString *ppi = @"";
    if ([self.deviceName isEqualToString:@"iPod1,1"] ||
        [self.deviceName isEqualToString:@"iPod2,1"] ||
        [self.deviceName isEqualToString:@"iPod3,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,2"] ||
        [self.deviceName isEqualToString:@"iPhone2,1"]) {
        
        ppi = @"163";
    }
    else if ([self.deviceName isEqualToString:@"iPod4,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,3"] ||
             [self.deviceName isEqualToString:@"iPhone4,1"] ||
             [self.deviceName isEqualToString:@"iPhone5,1"] ||
             [self.deviceName isEqualToString:@"iPhone5,2"] ||
             [self.deviceName isEqualToString:@"iPhone5,3"] ||
             [self.deviceName isEqualToString:@"iPhone5,4"] ||
             [self.deviceName isEqualToString:@"iPhone6,1"] ||
             [self.deviceName isEqualToString:@"iPhone6,2"] ||
             [self.deviceName isEqualToString:@"iPhone7,2"] ||
             [self.deviceName isEqualToString:@"iPhone8,1"] ||
             [self.deviceName isEqualToString:@"iPhone8,4"]) {
        ppi = @"326";
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,1"] ||
             [self.deviceName isEqualToString:@"iPhone8,2"]) {
        ppi = @"401";
    }
    else if ([self.deviceName isEqualToString:@"iPad1,1"] ||
             [self.deviceName isEqualToString:@"iPad2,1"]) {
        ppi = @"132";
    }
    else if ([self.deviceName isEqualToString:@"iPad3,1"] ||
             [self.deviceName isEqualToString:@"iPad3,4"] ||
             [self.deviceName isEqualToString:@"iPad4,1"] ||
             [self.deviceName isEqualToString:@"iPad4,2"]) {
        ppi = @"264";
    }
    else if ([self.deviceName isEqualToString:@"iPad2,5"]) {
        ppi = @"163";
    }
    else if ([self.deviceName isEqualToString:@"iPad4,4"] ||
             [self.deviceName isEqualToString:@"iPad4,5"]) {
        ppi = @"326";
    }
    else {
        ppi = @"264";
    }
    return ppi;
}

- (CGSize)deviceSize {
    CGSize resolution = CGSizeZero;
    if ([self.deviceName isEqualToString:@"iPod1,1"] ||
        [self.deviceName isEqualToString:@"iPod2,1"] ||
        [self.deviceName isEqualToString:@"iPod3,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,2"] ||
        [self.deviceName isEqualToString:@"iPhone2,1"]) {
        
        resolution = CGSizeMake(320, 480);
    }
    else if ([self.deviceName isEqualToString:@"iPod4,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,3"] ||
             [self.deviceName isEqualToString:@"iPhone4,1"]) {
        
        resolution = CGSizeMake(640, 960);
    }
    else if ([self.deviceName isEqualToString:@"iPhone5,1"] ||
             [self.deviceName isEqualToString:@"iPhone5,2"] ||
             [self.deviceName isEqualToString:@"iPhone5,3"] ||
             [self.deviceName isEqualToString:@"iPhone5,4"] ||
             [self.deviceName isEqualToString:@"iPhone6,1"] ||
             [self.deviceName isEqualToString:@"iPhone6,2"] ||
             [self.deviceName isEqualToString:@"iPhone8,4"]) {
        
        resolution = CGSizeMake(640, 1136);
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,1"] ||
             [self.deviceName isEqualToString:@"iPhone8,2"]) {
        resolution = CGSizeMake(1080, 1920);
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,2"] ||
             [self.deviceName isEqualToString:@"iPhone8,1"]) {
        resolution = CGSizeMake(750, 1334);
    }
    else if ([self.deviceName isEqualToString:@"iPad1,1"] ||
             [self.deviceName isEqualToString:@"iPad2,1"]) {
        resolution = CGSizeMake(768, 1024);
    }
    else if ([self.deviceName isEqualToString:@"iPad3,1"] ||
             [self.deviceName isEqualToString:@"iPad3,4"] ||
             [self.deviceName isEqualToString:@"iPad4,1"] ||
             [self.deviceName isEqualToString:@"iPad4,2"]) {
        resolution = CGSizeMake(1536, 2048);
    }
    else if ([self.deviceName isEqualToString:@"iPad2,5"]) {
        resolution = CGSizeMake(768, 1024);
    }
    else if ([self.deviceName isEqualToString:@"iPad4,4"] ||
             [self.deviceName isEqualToString:@"iPad4,5"]) {
        resolution = CGSizeMake(1536, 2048);
    }
    else {
        resolution = CGSizeMake(640, 960);
    }
    return resolution;
}

@end
