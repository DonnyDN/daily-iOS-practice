//
//  BlueView.m
//  事件传递&响应
//
//  Created by Donny on 2020/10/12.
//

#import "BlueView.h"

@implementation BlueView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"BlueView touchBegan");
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//    NSLog(@"BlueView hitTest - %@",view);
//    return view;
//}

// 超出父view范围外，也可以响应，如下修改：
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"BlueView hitTest - %@",view);
    if (view == nil) {
        for (UIView *subView in self.subviews) {
            CGPoint myPoint = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, myPoint)) {
                return subView;
            }
        }
    }
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL inSide = [super pointInside:point withEvent:event];
    NSLog(@"BlueView pointInside: %@",inSide ? @"YES" : @"NO");
    return inSide;
    //想扩大点击范围，可添加 UIEdgeInsets 属性，在此处判断 CGRectContainsPoint 返回YES即可
}

@end
