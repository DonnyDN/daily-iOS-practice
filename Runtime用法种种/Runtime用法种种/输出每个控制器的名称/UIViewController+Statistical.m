//
//  UIViewController+Statistical.m
//  Runtime用法种种
//
//  Created by Donny on 16/10/10.
//  Copyright © 2016年 Donny. All rights reserved.
//

#import "UIViewController+Statistical.h"
#import <objc/runtime.h>

@implementation UIViewController (Statistical)

+ (void)load {
    Method methodDid = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method methodStatistical = class_getInstanceMethod([self class], @selector(statisticalViewDidLoad));
    method_exchangeImplementations(methodDid, methodStatistical);
}

- (void)statisticalViewDidLoad {
    
    NSString *string = [NSString stringWithFormat:@"%@",self.class];
    //这里加一个判断, 将系统的UIViewController的对象剔除掉
    if (![string containsString:@"UI"]) {
        NSLog(@"统计打点 : %@",self.class);
    }
    
    //因为方法已经交换, 实际上这个方法调用的是[self viewDidLoad];
    [self statisticalViewDidLoad];
}


@end
