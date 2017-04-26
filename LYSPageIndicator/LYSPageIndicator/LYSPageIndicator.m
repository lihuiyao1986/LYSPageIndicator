//
//  LYSPageIndicator.m
//  LYSPageIndicator
//
//  Created by jk on 2017/4/26.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSPageIndicator.h"

@interface LYSPageIndicator ()

@property(nonatomic,strong)DGActivityIndicatorView * indicator;

@property(nonatomic,strong)UIImageView *bgImageView;

@end

@implementation LYSPageIndicator

#pragma mark - 初始化方法
- (instancetype)init{
    
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    if (self) {
        [self setDefaults];
        [self initConfig];
    }
    return self;
}

#pragma mark - 设置大小
-(void)setIndicatorSize:(CGFloat)indicatorSize{
    _indicatorSize = indicatorSize;
    self.indicator.size = self.indicatorSize;
}

#pragma mark - 设置类型
-(void)setType:(DGActivityIndicatorAnimationType)type{
    _type = type;
    self.indicator.type = self.type;
}

#pragma mark - 设置颜色
-(void)setIndicatorColor:(UIColor *)indicatorColor{
    _indicatorColor =  indicatorColor;
    self.indicator.tintColor = self.indicatorColor;
}

#pragma mark - 初始化配置
-(void)initConfig{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:self.bgAlpha];
    [self addSubview:self.bgImageView];
    [self addSubview:self.indicator];
    [self bringSubviewToFront:self.indicator];
}

#pragma mark - 背景图片视图
-(UIImageView*)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LYSPageIndicator.bundle/indicator_bg"]];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bgImageView;
}

#pragma mark - layoutSubviews
-(void)layoutSubviews{
    [super layoutSubviews];
    self.bgImageView.frame = CGRectMake((CGRectGetWidth(self.frame) - self.bgImageView.image.size.width) / 2, (CGRectGetHeight(self.frame) - self.bgImageView.image.size.height)/2, self.bgImageView.image.size.width, self.bgImageView.image.size.height);
    self.indicator.frame = CGRectMake((CGRectGetWidth(self.frame) - 50.f) / 2, (CGRectGetHeight(self.frame) - 50.f)/2, 50.f, 50.f);
}

#pragma mark - 加载视图
-(DGActivityIndicatorView*)indicator{
    if (!_indicator) {
        _indicator.layer.borderWidth = 2;
        _indicator.layer.borderColor = [UIColor redColor].CGColor;
        _indicator = [[DGActivityIndicatorView alloc]initWithType:self.type tintColor:self.indicatorColor];
    }
    return _indicator;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.bgImageView.frame, point)) {
        if(self.dismissTouchOutside){
            [self dimiss];
        }
    }
}

#pragma mark - 设置背景的透明度
-(void)setBgAlpha:(CGFloat)bgAlpha{
    _bgAlpha = bgAlpha;
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:self.bgAlpha];
}

#pragma mark - 初始化方法
+(instancetype)initWithType:(DGActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor{
    LYSPageIndicator * instance = [[LYSPageIndicator alloc] init];
    instance.type = type;
    instance.indicatorColor = tintColor;
    return instance;
}

#pragma mark - 设置默认值
-(void)setDefaults{
    _indicatorColor = [self colorWithHexString:@"ffc833" alpha:1.0];
    _indicatorSize = 40.f;
    _bgAlpha = 0.4;
    _dismissTouchOutside = NO;
    _type = DGActivityIndicatorAnimationTypeBallPulse;
}


#pragma mark - 关闭
-(void)dimiss{
    [self.indicator stopAnimating];
    [self removeFromSuperview];
}

#pragma mark - 显示
-(void)show{
    [self showInView:nil];
}

#pragma mark - 显示
-(void)showInView:(UIView*)view{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    if (self.superview) {
        [self removeFromSuperview];
    }
    [view addSubview:self];
    [self.indicator startAnimating];
}

#pragma mark - 生成16进制颜色
-(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
