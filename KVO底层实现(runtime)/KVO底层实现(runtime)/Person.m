//
//  Person.m
//  KVO底层实现(runtime)
//
//  Created by Donny on 2020/6/18.
//  Copyright © 2020 Donny. All rights reserved.
//

#import "Person.h"

@implementation Person

//手动触发KVO：指给 age 赋值不会触发 observeValueForKeyPath 回调了
//重写此方法 - 步骤1
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    if ([key isEqualToString:@"age"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}


//验证didChangeValueForKey:内部会调用observer的observeValueForKeyPath:ofObject:change:context:方法

//- (void)willChangeValueForKey:(NSString *)key
//{
//    NSLog(@"willChangeValueForKey: - begin");
//    [super willChangeValueForKey:key];
//    NSLog(@"willChangeValueForKey: - end");
//}
//- (void)didChangeValueForKey:(NSString *)key
//{
//    NSLog(@"didChangeValueForKey: - begin");
//    [super didChangeValueForKey:key];
//    NSLog(@"didChangeValueForKey: - end");
//}
@end
