//
//  ViewController.m
//  HYNetworkingDemo
//
//  Created by work on 16/9/7.
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
        // 测试参数，传不传递对请求结果没有影响
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

