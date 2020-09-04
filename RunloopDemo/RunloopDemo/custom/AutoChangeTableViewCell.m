//
//  AutoChangeTableViewCell.m
//  RunloopDemo
//
//  Created by Donny on 2020/6/23.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import "AutoChangeTableViewCell.h"

@interface AutoChangeTableViewCell () 

@end

@implementation AutoChangeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        __weak typeof (self)weakSelf = self;
        [self setInDefaultModeCallback:^{
            [weakSelf handleDisplayRectAndStartVideoIfNeed];
            NSLog(@"default");
        }];
        
        [self setInTrackingModeCallback:^{
            weakSelf.contentView.backgroundColor = [UIColor blueColor];
            NSLog(@"tracking");
        }];
        
    }
    return self;
}


- (void)handleDisplayRectAndStartVideoIfNeed {
    CGRect displayRect = [self wlkk_displayRect];
    
    if (CGRectEqualToRect(CGRectZero, displayRect)) {
        return;
    }
    
    if (displayRect.origin.y <= -1) {
        return;
    }
    
    if (displayRect.origin.y > (superScrollView.frame.size.height - self.frame.size.height)) {
        return;
    }
    
    self.contentView.backgroundColor = [UIColor whiteColor];
}


#pragma mark - Override

-(void)didMoveToWindow {
    [self registerObserver];
}



@synthesize didUserTriggerScroll;

@synthesize inTrackingModeCallback;

@synthesize superScrollFrame;

@synthesize inDefaultModeCallback;

@synthesize superScrollView;

@end
