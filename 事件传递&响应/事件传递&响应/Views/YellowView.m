//
//  YellowView.m
//  事件传递&响应
//
//  Created by Donny on 2020/10/12.
//

#import "YellowView.h"

@implementation YellowView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"YellowView touchBegan");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"YellowView hitTest - %@",view);
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL inSide = [super pointInside:point withEvent:event];
    NSLog(@"YellowView pointInside: %@",inSide ? @"YES" : @"NO");
    return inSide;
}


@end
