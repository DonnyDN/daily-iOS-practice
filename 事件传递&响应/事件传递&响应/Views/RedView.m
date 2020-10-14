//
//  RedView.m
//  事件传递&响应
//
//  Created by Donny on 2020/10/12.
//

#import "RedView.h"

@implementation RedView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //如果调用了[super touches…]方法就会将事件顺着响应者链条向上传递，传递给上一个响应者
    //如果不调[super touches…]，其nextResponder（父view）的touchesBegan不会触发
    [super touchesBegan:touches withEvent:event];
    NSLog(@"RedView touchBegan");
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"RedView hitTest - %@",view);
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL inSide = [super pointInside:point withEvent:event];
    NSLog(@"RedView pointInside: %@",inSide ? @"YES" : @"NO");
    return inSide;
}

@end
