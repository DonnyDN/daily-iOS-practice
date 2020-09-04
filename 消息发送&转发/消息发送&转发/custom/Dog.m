//
//  Dog.m
//  消息发送&转发
//
//  Created by Donny on 2020/6/19.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import "Dog.h"
#import <objc/runtime.h>
#import "Cat.h"

@implementation Dog

- (void)eat {
    NSLog(@"Dog eat");
}

- (NSInteger)eatBone {
    NSLog(@"Dog eat 3 bone");
    return 3;
}

- (void)eatSomeBone:(NSInteger)num {
    NSLog(@"%@", [NSString stringWithFormat:@"Dog eat %zd bone",num]);
}


#pragma mark - 消息转发

/**
 第一次补救
 + (BOOL)resolveInstanceMethod:(SEL)sel {} (实例方法)
 + (BOOL)resolveClassMethod:(SEL)sel {}  (类方法)
 利用 class_addMethod 方法，将未实现的 eatMouse 绑定到 eat 上就能成功转发，最后返回 YES
 */

//对象方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(eatMouse)) {
        class_addMethod([self class],sel, class_getMethodImplementation(self, @selector(eat)),"v@:@");
        return YES;
    }else {
        return [super resolveInstanceMethod:sel];
    }
}
//类方法
+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(eatMouse)) {
        class_addMethod([self class],sel, class_getMethodImplementation(self, @selector(eat)),"v@:@");
        return YES;
    }else {
        return [super resolveInstanceMethod:sel];
    }
}

/**
 第二次补救
 - (id)forwardingTargetForSelector:(SEL)aSelector {}
 把找不到的方法，转发到其他对象中寻找试试
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(eatMouse)) {
        return [Cat new];
    }
    return [super forwardingTargetForSelector:aSelector];
}


/**
 第三次补救
 - (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {}
 - (void)forwardInvocation:(NSInvocation *)anInvocation {}
 第一个要求返回一个方法签名，第二个方法转发具体的实现。二者相互依赖，只有返回了正确的方法签名，才会执行第二个方法。
 
 这次的转发作用和第二次的比较类似，都是将 A 类的某个方法，转发到 B 类的实现中去。
 不同的是，第三次的转发相对于第二次更加灵活，forwardingTargetForSelector: 只能固定的转发到一个对象；forwardInvocation:  可以让我们转发到多个对象中去。
*/
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(eatMouse)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    Dog *dog = [Dog new];
    Cat *cat = [Cat new];
    if ([dog respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:dog];
    }
    if ([cat respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:cat];
    }
}

@end
