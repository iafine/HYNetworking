//
//  ViewController.m
//  HYNetworking
//
//  Created by work on 16/8/25.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import "ViewController.h"
#import "HYAPIProxy.h"
#import "HYTestAPIManager.h"

@interface ViewController ()<HYAPIManagerParamSource, HYAPIManagerCallBackDelegate, HYAPIManagerValidator>

@property (strong, nonatomic) HYTestAPIManager *testManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.testManager loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HYAPIManagerParamSource
- (NSDictionary *)paramsWithManager:(HYBaseAPIManager *)manager {
    if (manager == self.testManager) {
        return @{@"userid":@"12"
                 };
    }
    return @{
             };
}

#pragma mark - HYAPIManagerCallBackDelegate
- (void)callBackAPIDidSuccess:(HYBaseAPIManager *)manager {
    if (manager == self.testManager) {
        NSDictionary *dic = (NSDictionary *)manager.response.content;
        NSLog(@"%@", dic);
    }
}

- (void)callBackAPIDidFailed:(HYBaseAPIManager *)manager {
    NSLog(@"请求失败");
}

#pragma mark - setter and getter
- (HYTestAPIManager *)testManager {
    if (!_testManager) {
        _testManager = [[HYTestAPIManager alloc] init];
        _testManager.delegate = self;
        _testManager.paramsSource = self;
    }
    return _testManager;
}

@end
