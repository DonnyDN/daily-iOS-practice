//
//  UILabel+RemoveNull.m
//  取出字符串中的null
//
//  Created by Donny on 16/10/18.
//  Copyright © 2016年 Donny. All rights reserved.
//

#import "UILabel+RemoveNull.h"
#import <objc/runtime.h>

@implementation UILabel (RemoveNull)

+ (void)initialize {
    Method method = class_getInstanceMethod([self class], @selector(setText:));
    Method removeMethod = class_getInstanceMethod([self class], @selector(removeNullSetText:));
    method_exchangeImplementations(method, removeMethod);
}

- (void)removeNullSetText:(NSString *)string {
    if (string == nil || [string isEqualToString:@"(null)"]) {
        string = @"";
    } else if ([string rangeOfString:@"(null)"].location != NSNotFound) {
        string = [string stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    }
    [self removeNullSetText:string];
}

@end
