//
//  AutoChangeTableViewCell.h
//  RunloopDemo
//
//  Created by Donny on 2020/6/23.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoPlayObserver.h"

NS_ASSUME_NONNULL_BEGIN

@interface AutoChangeTableViewCell : UITableViewCell <WLKanKanAutoPlayObserver>

//@property (nonatomic, assign) BOOL didUserTriggerScroll;
//@property (nonatomic,   weak) __kindof UIScrollView *superScrollView;
//@property (nonatomic, assign) CGRect superScrollFrame;
//@property (nonatomic, copy) dispatch_block_t inDefaultModeCallback;
//@property (nonatomic, copy) dispatch_block_t inTrackingModeCallback;

@end

NS_ASSUME_NONNULL_END
