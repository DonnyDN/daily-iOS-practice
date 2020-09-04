//
//  Person.m
//  KVC底层实现
//
//  Created by Donny on 2020/8/24.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import "Person.h"

@implementation Person
{
    NSString *_name;
}

/**
 1.当找不到setKey、_setKey、setIsKay这几个方法时，会继续调用accessInstanceVariablesDirectly方法，这个方法默认返回YES；
 
 2.如果返回值是YES，会按顺序再依次查找_key、_isKey、key、isKey这四个成员变量，如果找到其中某个成员变量，完成赋值。
 如果四个成员变量都未找到，就会调用setValue:forUndefinedKey:方法，并抛出NSUnknownKeyException异常，赋值失败。
 
 3.如果返回值是NO，那么会直接调用setValue:forUndefinedKey:方法，并抛出NSUnknownKeyException异常，赋值失败。
 */

+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}

//- (void)setName:(NSString *)name {
//    NSLog(@"setName: %@",name);
//}

//- (void)_setName:(NSString *)name {
//    NSLog(@"_setName: %@",name);
//}

//- (void)setIsName:(NSString *)name {
//    NSLog(@"setIsName: %@",name);
//}


@end
