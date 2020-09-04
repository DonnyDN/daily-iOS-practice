//
//  UIView+AutoPlayObserver.m
//  WeiLiKanKan
//
//  Created by Fernando on 2019/7/22.
//  Copyright © 2019 etouch. All rights reserved.
//

#import "UIView+AutoPlayObserver.h"

#define __gSystemVersion ([[UIDevice currentDevice].systemVersion integerValue])

@implementation UIView (AutoPlayObserver)

#pragma mark - observe runloopmode changes
#pragma mark 自动播放逻辑

- (void)performActionInTrackingModeStart {
    
    if (__gSystemVersion >= 10.0) {
        __weak typeof (self) weakSelf = self;
        [[NSRunLoop mainRunLoop] performInModes:@[UITrackingRunLoopMode] block:^{
            // 把事件再次注册到defaultmode里
            [weakSelf performActionInDefaultModeStart];
            NSLog(@"UITrackingRunLoopMode start");
        }];
    } else {
        [[NSRunLoop mainRunLoop] performSelector:@selector(performActionInDefaultModeStart)
                                          target:self
                                        argument:nil
                                           order:0
                                           modes:@[UITrackingRunLoopMode]];
    }
    
    // 进入defaultmode
    // 处理停止滑动事件
    UIView<WLKanKanAutoPlayObserver> *observerView = (UIView<WLKanKanAutoPlayObserver> *)self;
    
    if (CGSizeEqualToSize(CGSizeZero, self.frame.size)) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (observerView.inDefaultModeCallback) {
                observerView.inDefaultModeCallback();
            }
        });
    } else {
        if (observerView.inDefaultModeCallback) {
            observerView.inDefaultModeCallback();
        }
    }
}

- (void)performActionInDefaultModeStart {
    
    if (__gSystemVersion > 10.0) {
        __weak typeof(self)weakSelf = self;
        [[NSRunLoop mainRunLoop] performInModes:@[NSDefaultRunLoopMode] block:^{
            // 把事件再次注册到trackingmode里
            [weakSelf performActionInTrackingModeStart];
            NSLog(@"NSDefaultRunLoopMode satrt");
        }];
    } else {
        [[NSRunLoop mainRunLoop] performSelector:@selector(performActionInTrackingModeStart)
                                          target:self
                                        argument:nil
                                           order:0
                                           modes:@[NSDefaultRunLoopMode]];
    }
    
    UIView<WLKanKanAutoPlayObserver> *observerView = (UIView<WLKanKanAutoPlayObserver> *)self;
    observerView.didUserTriggerScroll = YES;
    
    // 进入trackingmode
    // 处理开始滑动事件
    if (observerView.inTrackingModeCallback) {
        observerView.inTrackingModeCallback();
    }
}

- (CGRect)wlkk_displayRect {
    // 这里计算 videoView 在 superScrollView 上的坐标
    UIView<WLKanKanAutoPlayObserver> *observerView = (UIView<WLKanKanAutoPlayObserver> *)self;
    CGRect scrollViewInWindowFrame = [observerView.superScrollView.superview convertRect:observerView.superScrollView.frame
                                                                                 toView:[UIApplication sharedApplication].keyWindow];
    return [observerView.superview convertRect:observerView.frame
                                              toView:[[UIView alloc] initWithFrame:scrollViewInWindowFrame]];
}

- (CGRect)convertRectCalculated {
    CGRect rect = self.frame;
    
    for (UIView *view = self; view; view = view.superview) {
        BOOL nextResponderIsReuseCell = [view isKindOfClass:[UITableViewCell class]] || [view isKindOfClass:[UICollectionViewCell class]];
        if (nextResponderIsReuseCell) {
            rect = view.frame;
            break;
        }
        
        BOOL nextResponderIsReuseView = [view isKindOfClass:[UITableViewHeaderFooterView class]] || [view isKindOfClass:[UICollectionReusableView class]];
        if (nextResponderIsReuseView) {
            rect = view.frame;
            break;
        }
    }
    return rect;
}

- (void)registerObserver {
    if (![self conformsToProtocol:@protocol(WLKanKanAutoPlayObserver)]) {
        return;
    }
    [self needObserveRunLoopChanges];
    [self performActionInTrackingModeStart];
}

- (BOOL)needObserveRunLoopChanges {
    BOOL find = NO;
    for (UIView *view = self; view; view = view.superview) {
        BOOL nextResponderIsScrollView = [self theViewIsScrollView:view];
        if (nextResponderIsScrollView) {
            UIView<WLKanKanAutoPlayObserver> *observerView = (UIView<WLKanKanAutoPlayObserver> *)self;
            observerView.superScrollView = (UIScrollView *)view;
            observerView.superScrollFrame = observerView.superScrollView.frame;
        }
        
        if (nextResponderIsScrollView) {
            find = YES;
            break;
        }
    }
    return find;
}

- (BOOL)theViewIsScrollView:(UIView *)view {
    BOOL isTableView = [view isKindOfClass:[UITableView class]];
    BOOL isCollectionView = [view isKindOfClass:[UICollectionView class]];
    BOOL isScrollView = [view isKindOfClass:[UIScrollView class]];
    
    return (isTableView || isCollectionView || isScrollView);
}

@end
