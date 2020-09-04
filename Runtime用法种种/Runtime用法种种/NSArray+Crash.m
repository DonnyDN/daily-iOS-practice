//
//  NSArray+Crash.m
//  Runtime用法种种
//
//  Created by Donny on 16/10/10.
//  Copyright © 2016年 Donny. All rights reserved.
//

#import "NSArray+Crash.h"
#import <objc/runtime.h>

@implementation NSArray (Crash)

+ (void)load {
    //这里不能使用[self class],因为__NSArrayI才是NSArray真正的类. 通过runtime函数获取真正的类objc_getClass("__NSArrayI");
    //一些常用类簇真身
    //NSArray                   __NSArrayI
    //NSMutableAray             __NSArrayM
    //NSDictionary              __NSDictionaryI
    //NSMutableDictionary       __NSDictionaryM
    
    Method objcMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method crashMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(crashObjectAtIndex:));
    method_exchangeImplementations(objcMethod, crashMethod);
}

#pragma mark - 判断数组是否越界,越界则输出

- (id)crashObjectAtIndex:(NSUInteger)index {
    if (index > self.count - 1) {
        @try {
            return [self crashObjectAtIndex:index];
        }
        @catch (NSException *exception) {
//            NSLog(@"----------  %s Crash Because Method %s  ----------\n",class_getName(self.class), __func__);
//            NSLog(@"%@",[exception callStackSymbols]);
            NSLog(@"异常名称: %@   异常原因: %@",exception.name,exception.reason);
            NSLog(@"%@",[exception callStackSymbols]);
        }
        @finally {}
        return nil;
    } else {
        return [self crashObjectAtIndex:index];
    }
}
@end
