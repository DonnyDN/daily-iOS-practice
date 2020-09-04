//
//  LabelViewController.m
//  Runtime用法种种
//
//  Created by Donny on 16/10/18.
//  Copyright © 2016年 Donny. All rights reserved.
//

#import "LabelViewController.h"

@implementation LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(50, 50, 50, 50);
    backButton.backgroundColor = [UIColor orangeColor];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    label.frame = CGRectMake(100, 100, 100, 100);
    label.text = @"(null)123456";
//    label.text = @"123456";
    label.backgroundColor = [UIColor redColor];
}

#pragma mark ----返回按钮点击事件

- (void)backButtonEvent {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
