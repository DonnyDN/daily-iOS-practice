//
//  ViewController.m
//  消息发送&转发
//
//  Created by Donny on 2020/6/19.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

#import "Tom.h"
#import "Dog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self msgSend_test];
    
}

/**
 消息发送
 
 id objc_msgSend(id self, SEL op, ...);
 self：消息的接收者
 op：消息的方法名
 ... ：参数列表
*/
- (void)msgSend_test {
    Dog *dog = [Dog new];
    [dog eat];
    
    //无参无返回
    ((void (*)(id, SEL))(void *) objc_msgSend)(dog, @selector(eat));
    //有参无返回
    ((void (*)(id, SEL, NSInteger))(void *) objc_msgSend)(dog, @selector(eatSomeBone:), 3);
    //无参有返回
    NSInteger num = ((NSInteger (*)(id, SEL))(void *) objc_msgSend)(dog, @selector(eatBone));
    NSLog(@"取得返回值：%zd",num);
}

/**
 消息转发
 */
- (void)forwardMsg_test {
    Dog *dog = [Dog new];
    //调用一个未实现的方法
    [dog performSelector:@selector(eatMouse)];
}



/**
 self & super
 */
- (void)self_super_test {
    Tom *tom = [Tom new];
    [tom eat];
}


@end
