//
//  ViewController.m
//  iOS多线程
//
//  Created by Donny on 2020/6/24.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import "ViewController.h"

#import "ViewController+NSOperation.h"
#import "DNSerialOperation.h"
#import "DNConcurrentOperation.h"

#import "UIViewController+GCD.h"

@interface ViewController ()

@property (nonatomic,strong)NSOperationQueue *myQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myQueue = [[NSOperationQueue alloc] init];
    
//    [self customOperation_serial];
    [self test_gcd];
}

- (void)customOperation_serial {
    DNSerialOperation *operation1 = [[DNSerialOperation alloc] init];
//    [operation1 start];
    
    [self.myQueue addOperation:operation1];
    DNSerialOperation *operation2 = [[DNSerialOperation alloc] init];
    [self.myQueue addOperation:operation2];
    DNSerialOperation *operation3 = [[DNSerialOperation alloc] init];
    [self.myQueue addOperation:operation3];
}

- (void)customOpration_concurrent {
    DNConcurrentOperation *operation1 = [[DNConcurrentOperation alloc] init];
    [self.myQueue addOperation:operation1];
    DNConcurrentOperation *operation2 = [[DNConcurrentOperation alloc] init];
    [self.myQueue addOperation:operation2];
    DNConcurrentOperation *operation3 = [[DNConcurrentOperation alloc] init];
    [self.myQueue addOperation:operation3];

}

@end
