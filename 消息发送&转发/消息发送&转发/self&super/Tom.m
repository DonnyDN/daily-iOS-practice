//
//  Tom.m
//  消息发送&转发
//
//  Created by Donny on 2020/6/19.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import "Tom.h"

@implementation Tom

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"self className is %@", NSStringFromClass([self class]));
        NSLog(@"super className is %@", NSStringFromClass([super class]));

        [self eat];
        [super eat];
    }
    return self;
}

- (void)eat {
    NSLog(@"Tom eat");
    [super eat];
}

/**
 通过转化c++文件，得知 [super eat] 被转化为以下代码：
 
 ((void (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){
     (id)self, (id)class_getSuperclass(objc_getClass("Tom"))
 }, sel_registerName("eat"));
 

 总结：
 objc_msgSendSuper 中的消息接收者还是 self，即 tom 实例对象;
 
 [self msg]从当前类中开始寻找方法，找不到去父类中寻找。
 [super msg]从父类中开始寻找方法。
 [self msg] 和 [super msg] 中的消息接收者，均为当前类的实例对象
 
 */

@end
