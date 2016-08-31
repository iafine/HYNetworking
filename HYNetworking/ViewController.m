//
//  ViewController.m
//  HYNetworking
//
//  Created by work on 16/8/25.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import "ViewController.h"
#import "HYAPIProxy.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[HYAPIProxy sharedInstance] getWithPamrams:nil methodName:@"news/latest" success:^(HYResponseManager *response) {
    } fail:^(HYResponseManager *response) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
