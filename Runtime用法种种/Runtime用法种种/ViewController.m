//
//  ViewController.m
//  Runtime用法种种
//
//  Created by Donny on 16/10/10.
//  Copyright © 2016年 Donny. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "FirstViewController.h"
#import "UIButton+PreVentMultipleClick.h"
#import "Tom.h"
#import "Dog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

/**
 获取类的属性/成员变量/方法
 */
- (void)getClassPropertys {
    //所有变量
    [Dog allVariableWithClass:Dog.class];
    
    Dog *dog = [Dog new];
    //所有属性
    [Dog allPropertys:dog];
    
    //打印Dog里实例方法
    [Dog allMethods:object_getClass(dog)];
    //打印Dog里类方法
    [Dog allMethods:object_getClass(object_getClass(dog))];
}

/**
 防止按钮多次点击（可设置间隔）
 */
- (void)buttonAvoidMultiClick {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 100, self.view.frame.size.width, 40);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"下一页" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
    button.clickDurationTime = 123;
    //    NSLog(@"button.clickDurationTime = %.2f",button.clickDurationTime);
    [self.view addSubview:button];
}

/**
 数组越界防止崩溃
 */
- (void)arrayAvoidCrashTest {
    NSArray *array = @[@"1",@"2",@"3"];
    NSLog(@"数组越界：%@",array[100]);
}

/**
 方法替换
 */
- (void)methodSwizzleTest {
    Tom *tom = [Tom new];
//    [tom performSelector:@selector(eat)];
    [Tom performSelector:@selector(eat)];
}

/**
 class 与 object_getClass 区别
 */
- (void)classTest {
    Tom *tom = [Tom new];
    
    Class a1 = objc_getClass("Tom");
    Class a2 = objc_getMetaClass("Tom");
    Class a3 = [Tom class];
    Class a4 = object_getClass(tom);
    
    NSLog(@"a1 %p",a1);
    NSLog(@"a2 %p",a2);
    NSLog(@"a3 %p",a3);
    NSLog(@"a4 %p",a4);
}

/**
 标签指针（提高性能）
 */
- (void)taggedPointer {
    NSMutableString *muStr2 = [NSMutableString stringWithString:@"1"];
    for(int i=0; i<14; i+=1){
        NSString *strFor = [[muStr2 mutableCopy] copy];
        
        NSLog(@"%@, %p, %@", [strFor class], strFor, strFor);
        [muStr2 appendString:@"1"];
    }
}

- (void)eatApple {
    NSLog(@"Tom 吃 Apple");
}

#pragma mark ----跳转至下一页.
- (void)buttonEvent
{
//    [self presentViewController:[FirstViewController new] animated:YES completion:nil];
    NSLog(@"1111");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
