//
//  Tom.m
//  Runtime用法种种
//
//  Created by Donny on 2020/5/31.
//  Copyright © 2020 Donny. All rights reserved.
//

#import "Tom.h"
#import <objc/runtime.h>

@implementation Tom

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self classMethodSwizzle];
        
    });
}

/**
 类方法替换
 */
+ (void)classMethodSwizzle {
    /*
     object_getClass：取其isa指向
     [xxx class]：当xxx是实例对象，返回其类对象，否则返回自身。
     类方法class，返回的是self，所以当查找meta class时，需要对类对象调用object_getClass方法
     */
    
    //类方法中的self，是类对象，所以这里取的是类对象的isa，即元类（元类中存储了类方法）
    Class metaClass = object_getClass(self);
    
    SEL originalSelector = @selector(eat);
    SEL swizzledSelector = @selector(eatApple);
    swizzleMethodSelector2(metaClass, originalSelector, swizzledSelector);
}

/**
 实例方法替换
*/
+ (void)instanceMethodSwizzle {
    Class class = [self class];
    
    SEL originalSelector = @selector(eat);
    SEL swizzledSelector = @selector(eatApple);
    swizzleMethodSelector2(class, originalSelector, swizzledSelector);
}

#pragma mark - Private

+ (void)eatApple {
    NSLog(@"Tom eat Apple");
}

+ (void)eat {
    NSLog(@"Tom eat");
}

- (void)eatApple {
    NSLog(@"Tom eat Apple");
}

- (void)eat {
    NSLog(@"Tom eat");
}

#pragma mark - 方法替换两种写法

//方法替换，简单写法（确定2个方法都存在，例如系统方法）
static inline void swizzleMethodSelector1(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

/*方法替换（在不确定 originalMethod 是否存在，确定 swizzleMethod 存在情况下）
 class_addMethod 要添加的方法存在时，会添加失败；当父类存在同名方法，本类也会添加成功，相当于重写父类方法
 */
static inline BOOL swizzleMethodSelector2(Class aClass, SEL originalSelector, SEL swizzleSelector) {
    Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
    Method swizzleMethod = class_getInstanceMethod(aClass, swizzleSelector);
    BOOL didAddMethod =
    class_addMethod(aClass,
                    originalSelector,
                    method_getImplementation(swizzleMethod),
                    method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
        //原方法不存在，刚添加成功
        class_replaceMethod(aClass,
                            swizzleSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        //原方法已存在，直接交换
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
    return YES;
}

#pragma mark - 直接修改方法的实现

/*方式1：method_setImplementation
 修改eat方法实现，为eatApple
（前提是2个方法都存在，否则 method_setImplementation 返回nil，表示失败，但不会crash）
*/
- (void)resetMethodImplementation1 {
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, @selector(eat));
    Method swizzledMethod = class_getInstanceMethod(class, @selector(eatApple));
    IMP swizzledImplementation = method_getImplementation(swizzledMethod);
    IMP newImplementation = method_setImplementation(originalMethod, swizzledImplementation);
    if (newImplementation != nil) {
        //修改成功
    }
}

/* 方式2：class_replaceMethod
 修改eat方法实现，为eatApple
（前提是2个方法都存在，否则 class_replaceMethod 返回nil，表示失败，但不会crash）
*/
- (void)resetMethodImplementation2 {
    Class class = [self class];
    Method swizzledMethod = class_getInstanceMethod(class, @selector(eatApple));
    IMP newImplementation = class_replaceMethod(class,
                                                @selector(eat),
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod));
    if (newImplementation != nil) {
        //修改成功
    }
}

@end
