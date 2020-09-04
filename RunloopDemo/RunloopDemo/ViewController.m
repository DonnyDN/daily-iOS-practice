//
//  ViewController.m
//  RunloopDemo
//
//  Created by Donny on 2020/6/22.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import "ViewController.h"
#import "AutoChangeTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

- (void)runloopStatusChange {
    // 创建观察者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(
                                                                       CFAllocatorGetDefault(),
                                                                       kCFRunLoopAllActivities,
                                                                       YES,
                                                                       0,
                                                                       ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"Runloop 状态改变了：%zd", activity);
    });
    // 将 observer 添加到当前 Runloop 中
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
    // CF 对象，需手动管理内存
    CFRelease(observer);
    
    //Runloop 的状态最终变为 32，也就是kCFRunLoopBeforeWaiting 了。这说明 Runloop 在没有事件需要处理的时候回自动 进入休眠状态。
}


- (void)method {
    NSLog(@"--- method ---");
}



#pragma mark - UITableView Delegate | Datasource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 680;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [[NSRunLoop mainRunLoop] performSelector:@selector(method)
//                                      target:self
//                                    argument:nil
//                                       order:0
////                                       modes:@[NSDefaultRunLoopMode]];
////                                       modes:@[NSRunLoopCommonModes]];
//                                       modes:@[UITrackingRunLoopMode]];
    
    
    [self performSelector:@selector(method_tracking) withObject:nil afterDelay:0 inModes:@[UITrackingRunLoopMode]];
    [self performSelector:@selector(method_default) withObject:nil afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
}

- (void)method_tracking {
    NSLog(@"tracking");
}

- (void)method_default {
    NSLog(@"default");
}

@end
