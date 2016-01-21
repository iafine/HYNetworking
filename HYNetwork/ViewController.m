//
//  ViewController.m
//  HYNetwork
//
//  Created by hyyy on 16/1/21.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import "ViewController.h"
#import "HYProgressAlertView.h"
#import "HYNetwork.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 120, 50)];
    downloadBtn.backgroundColor = [UIColor blueColor];
    [downloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [downloadBtn setTitle:@"下载文件" forState:UIControlStateNormal];
    [downloadBtn addTarget:self action:@selector(downloadTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downloadBtn];
    //    [self dataManager];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)downloadTest{
    HYProgressAlertView *alertView = [[HYProgressAlertView alloc] initWithMessage:@"正在下载中"];
    [alertView show];
    [HYNetwork downloadWithUrl:@"g5/M00/09/01/ChMkJ1Y8Ez2IM9qxAAgUC_kTmg0AAEjtwGnABQACBQj478.jpg" saveToPath:@"download" progress:^(NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite){
        float progress = ((int)totalBytesWritten*1.000 / (int)totalBytesExpectedToWrite);
        dispatch_async(dispatch_get_main_queue(), ^{
            //Update the progress view
            if (![alertView isShow]) {
                [downloadTask cancel];
            }
            [alertView setProgress:progress animated:YES];
        });
    } success:^(id responseObj){
        [alertView dismiss];
    } failure:^(NSError *error){
        [alertView dismiss];
    }];
}

//这部分本该写到DataManager模块中，只是为了演示
- (void)getTest{
//    NSDictionary *parameters = @{@"key":@"ece65c27ede91b57c652f30b59ed5dcd",
//                                 @"menu":@"鸡蛋"};
//    NSString *url = @"cook/query";
//    [HYNetwork GETWithUrl:url params:parameters success:^(id responseObj){
//        if ([responseObj isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *responseDic = (NSDictionary *)responseObj;
//            NSDictionary *resultDic = responseDic[@"result"];
//            NSArray *dataArr = resultDic[@"data"];
//            _dataSources = [[NSMutableArray alloc] initWithArray:dataArr];
//            [self initView];
//        }
//    } fail:^(NSError *error){
//        NSLog(@"访问失败");
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
