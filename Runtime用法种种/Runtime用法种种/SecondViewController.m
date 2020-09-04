//
//  SecondViewController.m
//  Runtime用法种种
//
//  Created by Donny on 16/10/10.
//  Copyright © 2016年 Donny. All rights reserved.
//

#import "SecondViewController.h"
#import "LabelViewController.h"

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(50, 50, 50, 50);
    backButton.backgroundColor = [UIColor orangeColor];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    self.view.backgroundColor = [UIColor greenColor];
}

#pragma mark ----返回按钮点击事件
- (void)backButtonEvent {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ----下一页按钮
- (void)buttonEvent {
    [self presentViewController:[LabelViewController new] animated:YES completion:nil];
}

@end
