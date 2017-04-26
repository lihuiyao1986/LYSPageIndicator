//
//  LYSPageIndicator.h
//  LYSPageIndicator
//
//  Created by jk on 2017/4/26.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGActivityIndicatorView.h"


@interface LYSPageIndicator : UIView

@property (nonatomic,strong) UIColor *indicatorColor;

@property (nonatomic,assign) DGActivityIndicatorAnimationType type;

@property (nonatomic,assign) CGFloat indicatorSize;

@property (nonatomic,assign) CGFloat bgAlpha;

@property (nonatomic,assign) BOOL dismissTouchOutside;

#pragma mark - 初始化方法
+(instancetype)initWithType:(DGActivityIndicatorAnimationType)type tintColor:(UIColor*)tintColor;

#pragma mark - 展示
-(void)show;

#pragma mark - 隐藏
-(void)dimiss;

#pragma mark - 显示
-(void)showInView:(UIView*)view;

@end
