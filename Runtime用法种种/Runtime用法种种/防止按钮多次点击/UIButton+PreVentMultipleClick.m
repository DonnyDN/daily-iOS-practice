//
//  UIButton+PreVentMultipleClick.m
//  Runtime用法种种
//
//  Created by Donny on 16/10/11.
//  Copyright © 2016年 Donny. All rights reserved.
//

#import "UIButton+PreVentMultipleClick.h"
#import <objc/runtime.h>

static const CGFloat kDefaultDuration = 0.1f; //默认按钮点击间隔
static BOOL _clicking = NO; //正在被点击
static void resetState() {
    _clicking = NO;
}

@implementation UIButton (PreVentMultipleClick)

+ (void)initialize {
    Method buttonMethod = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
    Method replaceMethod = class_getInstanceMethod([self class], @selector(mySendAction:to:forEvent:));
    method_exchangeImplementations(buttonMethod, replaceMethod);
}

#pragma mark - Override

- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([self isKindOfClass:[UIButton class]]) {
        //点击间隔事件
        self.clickDurationTime = self.clickDurationTime > 0 ? self.clickDurationTime : kDefaultDuration;

        if (_clicking) {
            return;
        } else if (self.clickDurationTime > 0) {
            _clicking = YES;
            [self mySendAction:action to:target forEvent:event];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.clickDurationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                resetState();
            });
        }
    }
}


#pragma mark ----关联对象
- (void)setClickDurationTime:(CGFloat)clickDurationTime {
    id x = @(clickDurationTime);
    objc_setAssociatedObject(self, @selector(clickDurationTime), x, OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)clickDurationTime {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

@end
