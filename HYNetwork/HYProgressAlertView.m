//
//  HYProgressAlertView.m
//  HYCustomAlert
//
//  Created by hyyy on 16/1/19.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import "HYProgressAlertView.h"

//定义相关常量
static const CGFloat alertWidth = 270;
static const CGFloat messageHeight = 50;

@interface HYProgressAlertView(){
    UIDynamicAnimator *_animator;
    UIView *_alertView;
    UIView *_backgroundView;
    NSString *_message;
    UIProgressView *_progressView;
    BOOL _bDismiss;
}
@end
@implementation HYProgressAlertView

#pragma mark - private function
- (void)initView{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    //backgroundView
    _backgroundView = [[UIView alloc] initWithFrame:keyWindow.frame];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.4;
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBackgroudEvent)];
    gr.numberOfTapsRequired = 1;
    gr.numberOfTouchesRequired = 1;
    [_backgroundView addGestureRecognizer:gr];
    [self addSubview:_backgroundView];
    
    //alertView
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertWidth, messageHeight+40)];
    _alertView.layer.cornerRadius = 3;
    _alertView.center = CGPointMake(CGRectGetMidX(keyWindow.frame), CGRectGetMidY(keyWindow.frame) - messageHeight);
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.clipsToBounds = YES;
    [self addSubview:_alertView];
    
    //messageView
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertWidth, messageHeight)];
    msgLabel.text = _message;
    msgLabel.font = [UIFont systemFontOfSize:14.0f weight:0.8f];
    msgLabel.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
    msgLabel.textAlignment = NSTextAlignmentCenter;
    [_alertView addSubview:msgLabel];
    
    //progressView
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(35, messageHeight+10, alertWidth-70, 20)];
    _progressView.progressViewStyle = UIProgressViewStyleDefault;
    [_alertView addSubview:_progressView];
}
#pragma mark - touch event
- (void)handleTapBackgroudEvent{
    [self dismiss];
}

#pragma mark - API
- (instancetype)initWithMessage:(NSString *)message{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    self = [super initWithFrame:keyWindow.frame];
    if (self) {
        _message = message;
        
        [self initView];
    }
    return self;
}

- (void)show{
    _bDismiss = YES;
    [UIView animateWithDuration:1.0 delay:0.3 options:UIViewAnimationOptionLayoutSubviews animations:^{} completion:^(BOOL finished){
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        [keyWindow addSubview:self];
    }];
}

- (void)dismiss{
    _bDismiss = NO;
    [UIView animateWithDuration:1.0 delay:0.3 options:UIViewAnimationOptionLayoutSubviews animations:^{} completion:^(BOOL finished){
        [self removeFromSuperview];
        _alertView = nil;
    }];
}

- (BOOL)isShow{
    return _bDismiss;
}

- (void)setProgress:(float)progress animated:(BOOL)animated{
    if (_progressView) {
        [_progressView setProgress:progress animated:YES];
    }
}

@end
