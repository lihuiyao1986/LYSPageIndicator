//
//  ViewController.m
//  LYSPageIndicator
//
//  Created by jk on 2017/4/26.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "ViewController.h"
#import "LYSPageIndicator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 120, self.view.frame.size.width, 44);
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)btnclick{
    LYSPageIndicator * indicator = [LYSPageIndicator initWithType:DGActivityIndicatorAnimationTypeBallPulse tintColor:[UIColor redColor]];
    indicator.bgAlpha = 0.2;
    indicator.dismissTouchOutside = YES;
    [indicator show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
