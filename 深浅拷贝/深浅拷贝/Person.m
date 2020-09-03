//
//  Person.m
//  深浅拷贝
//
//  Created by Donny on 16/1/4.
//  Copyright © 2016年 Donny. All rights reserved.
//

#import "Person.h"

@implementation Person
//重写初始化方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = [[NSMutableString alloc]initWithString:@"原name"];
        self.address = @"原address";
        self.age = 0;
    }
    return self;
}
//实现- (id)copyWithZone:(NSZone *)zone
-(id)copyWithZone:(NSZone *)zone{
    Person *p = [[self class]allocWithZone:zone];
    p.name    = [self.name copy];
    p.address = [self.address copy];
    
//    p.name = self.name ;
//    p.address = self.address ;
    
    p.age     = self.age;
    
    return p;
}
//实现- (id)mutableCopyWithZone:(NSZone *)zone
-(id)mutableCopyWithZone:(NSZone *)zone{
    Person *p = [[self class] allocWithZone:zone];
    p.name    = [self.name mutableCopy];
    p.address = [self.address mutableCopy];
    p.age     = self.age;
    
    return p;
}

@end
