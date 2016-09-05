HYNetworking 
==========
<!--
![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)
![Pod version](http://img.shields.io/cocoapods/v/YTKNetwork.svg?style=flat)
![Platform info](http://img.shields.io/cocoapods/p/YTKNetwork.svg?style=flat)
[![Build Status](https://api.travis-ci.org/yuantiku/YTKNetwork.svg?branch=master)](https://travis-ci.org/yuantiku/YTKNetwork)
-->
## 介绍
HYNetworking是一个基于[AFNetworking][AFNetworking]的轻量级网络库。高度封装网络请求，使得业务实现更加清楚。

## 特性

* 增加统一URL设置和线上线下切换功能，使用plist进行管理；
* delegate调用，未来可能支持Block方式；
* 参数校验功能。在请求前对参数进行校验，避免出错；
* 响应结果校验。完成相应对结果进行校验，避免结果异常；
* 增加公共参数，根据请求方式切换不同的公共参数；
* 完善的log日志，使得开发更方便;
* API版本号支持。

## 使用场景

HYNetworking作为一款轻量级的网络请求库，功能完善，适用于绝大多数业务开发场景，支持iOS7或者以后的版本。  

HYNetworking支持GET、POST、PUT和DELETE方式进行网络请求，具体使用方法详见使用介绍。

## 使用介绍
我们以知乎日报最新信息的接口为例：

```
http://news-at.zhihu.com/api/4/news/latest
```
其中BaseUrl是`http://news-at.zhihu.com/api`，版本号是`4`，方法名是`news/latest`。
### 设置统一URL、版本号和线上线下切换
统一URL和版本号分为线上线下两个版本，分别设置即可，如下图所示：

![plist文件](/images/plist.png)

>注意：统一URL后缀无需添加“ / ”。

### 建立请求

新建HYTestAPIManager文件，继承自HYBaseAPIManager，用于测试。   

重写下面两个方法：

```
#pragma mark - HYAPIManager
- (NSString *)methodName {
    return @"news/latest";
}

- (HYAPIManagerRequestType)requestType {
    return HYAPIManagerRequestTypeGet;  // 知乎日报接口为GET请求
}
```

然后回到所在的ViewController里，实现刚刚新建的HYTestAPIManager。

```
// ViewController.h
@property (strong, nonatomic) HYTestAPIManager *testManager;

// ViewController.m
#pragma mark - setter and getter
- (HYTestAPIManager *)testManager {
    if (!_testManager) {
        _testManager = [[HYTestAPIManager alloc] init];
        _testManager.delegate = self;
        _testManager.paramsSource = self;
    }
    return _testManager;
}
```
继续，在ViewController添加请求方法。

```
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.testManager loadData];
}
```
至此，知乎日报最新信息的请求就完成了。

### 请求回调监听
回调监听需要实现HYAPIManagerCallBackDelegate协议。然后监听回调：

```
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
```
### 参数传递
由于知乎日报最新信息接口并不需要接口传递，所以上面并有实现这块，参数传递需要实现HYAPIManagerParamSource协议。如下所示：

```
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
```

### 请求参数和响应结果校验
HYNetworking可以在请求之前对参数进行校验，可用于表单校验，邮箱、用户名等正则判断，也可以在响应成功后对结果进行校验，比如响应状态Status判断等。

具体代码实现如下：

```
#pragma mark - HYAPIManagerValidator
- (BOOL)manager:(HYAPIManager *)manager isCorrectWithResponseContentData:(id)content {
    if (content) {
        return YES;
    }
    return NO;
}

- (BOOL)manager:(HYAPIManager *)manager isCorrectWithParamsData:(NSDictionary *)params {
    NSString *userId = [params objectForKey:@"userid"];
    if ([userId integerValue] == 12) {
        return YES;
    }
    return NO;
}
```
### 超时时间设置
打开HYNetworkConfiguration.plist文件，根据所需，设置timeoutInterval值即可。

### 日志显示
#### 请求日志显示

![request_log](/images/request_log.png)

#### 响应日志部分显示

![response_log](/images/response_log.png)

## 反馈

如果您在使用HYNetworking过程中出现一些问题，可以在issue里提问，或者发邮件给我。

## 未来

HYNetworking目前还有不完善的地方，未来希望增加一下功能：

* 添加Block请求方式；
* 请求缓存处理；
* 深度定制HTTP Header。
* 等等。。。

<!--## 协议

YTKNetwork 被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。


<!-- external links -->

[BasicGuide-CN]: BasicGuide.md
[ProGuide-CN]: ProGuide.md
[BasicGuide-EN]: BasicGuide_en.md
[YuanTiKu]:http://www.yuantiku.com
[YuanSoTi]:http://www.yuansouti.com/
[YuanFuDao]:http://www.yuanfudao.com
[FenBiZhiBoKe]:http://ke.fenbi.com/
[tangqiaoboyGithub]:https://github.com/tangqiaoboy
[lancyGithub]:https://github.com/lancy
[maojjGithub]:https://github.com/maojj
[veecciGithub]:https://github.com/veecci
[AFNetworking]:https://github.com/AFNetworking/AFNetworking
[AFDownloadRequestOperation]:https://github.com/steipete/AFDownloadRequestOperation-->
