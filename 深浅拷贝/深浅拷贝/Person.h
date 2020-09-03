//
//  Person.h
//  深浅拷贝
//
//  Created by Donny on 16/1/4.
//  Copyright © 2016年 Donny. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 自定义对象
 
 在定义对象要实现拷贝，需要遵守NSCoping与NSMutableCoping协议，并实现以下方法
 
 - (id)copyWithZone:(NSZone *)zone，可变拷贝
 - (id)mutableCopyWithZone:(NSZone *)zone，不可变拷贝
 */
@interface Person : NSObject<NSCopying,NSMutableCopying>

/**姓名*/
@property (nonatomic, strong) NSMutableString *name;//注意！！这里的修饰符不能用copy，否则深拷贝也会返回不可变
/**地址*/
@property (nonatomic, copy) NSString *address;
/**年龄*/
@property (nonatomic, assign) NSInteger age;

@end
