//
//  HYProgressAlertView.h
//  HYCustomAlert
//
//  Created by hyyy on 16/1/19.
//  Copyright © 2016年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYProgressAlertView : UIView

///初始化
- (instancetype)initWithMessage:(NSString *)message;

//alert显示
- (void)show;

//alert消失
- (void)dismiss;

- (BOOL)isShow;

- (void)setProgress:(float)progress animated:(BOOL)animated;
@end
