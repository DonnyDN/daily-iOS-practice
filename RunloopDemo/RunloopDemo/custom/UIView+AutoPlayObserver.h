//
//  UIView+AutoPlayObserver.h
//  WeiLiKanKan
//
//  Created by Fernando on 2019/7/22.
//  Copyright © 2019 etouch. All rights reserved.
//
// 模拟自动播放逻辑

#import <UIKit/UIKit.h>

/**<
 只要遵循了这个协议
 *下面的所有属性都要实现
 *下面的所有属性都要实现
 *下面的所有属性都要实现
*/
@protocol WLKanKanAutoPlayObserver <NSObject>

@property (nonatomic, assign) BOOL didUserTriggerScroll;
@property (nonatomic,   weak) __kindof UIScrollView *superScrollView;
@property (nonatomic, assign) CGRect superScrollFrame;
@property (nonatomic, copy) dispatch_block_t inDefaultModeCallback;
@property (nonatomic, copy) dispatch_block_t inTrackingModeCallback;

@end

@interface UIView (AutoPlayObserver)

- (void)registerObserver;
- (CGRect)wlkk_displayRect;

@end

