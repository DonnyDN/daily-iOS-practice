//
//  ViewController+NSOperation.m
//  iOS多线程
//
//  Created by Donny on 2020/6/25.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import "ViewController+NSOperation.h"

@implementation ViewController (NSOperation)

- (void)test_operation {
    
}

/**
 NSOperation是个抽象类，并不具备封装操作的能力，必须使用它的子类

 使用NSOperation子类的方式有3种：
 1.NSInvocationOperation
 2.NSBlockOperation
 3.自定义NSOperation
 */

- (void)createMethod1{
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(method1) object:nil];
    [operation1 setCompletionBlock:^{
        NSLog(@"任务执行完后回调");
    }];
    //NSOperation 可以调用 start 方法来执行任务，但默认是【同步执行】
    [operation1 start];
    
//    [operation1 cancel]; //取消单个操作
    
    /**
     添加操作依赖:
     operation1依赖operation2，即operation1必须等operation2执行完毕之后才会执行
     注意不能循环依赖，如果循环依赖会造成两个任务都不会执行
     也可以跨队列依赖，依赖另一个队列的operation
     */
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(method2) object:nil];
    [operation1 addDependency:operation2];
}

- (void)createMethod2 {
    //NSBlockOperation 不论封装操作还是追加操作都是【异步并发执行】
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){ //封装
        NSLog(@"执行第1次操作，线程：%@", [NSThread currentThread]);
    }];
    [operation addExecutionBlock:^() { //追加
        NSLog(@"又执行了1个新的操作，线程：%@", [NSThread currentThread]);
    }];
    [operation addExecutionBlock:^() {
        NSLog(@"又执行了1个新的操作，线程：%@", [NSThread currentThread]);
    }];
    [operation start]; //开始执行(并发)
}

/**
 NSOperationQueue的使用
 */
- (void)operationQueue_test {
    
    /**
     NSOperation中的两种队列
     1.主队列：通过mainQueue获得，凡是放到主队列中的任务都将在主线程执行
     2.非主队列：直接alloc init出来的队列。非主队列同时具备了并发和串行的功能，通过设置最大并发数属性来控制任务是并发执行还是串行执行

     作用：
     将 NSOperation 添加到 NSOperationQueue（操作队列）中，系统会自动异步执行 NSOperation 中的操作
     
     注意：
     addOperation 添加到 NSOperationQueue 中后，就会自动启动，不需要再自己启动了，addOperation 内部调用 start 方法
     start 方法 内部调用 main 方法
     
     */
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(method1) object:nil];
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(method2) object:nil];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation3--1----%@",[NSThread currentThread]);
    }];
    [operation3 addExecutionBlock:^{
        NSLog(@"NSBlockOperation3--2----%@",[NSThread currentThread]);
    }];
    
    //创建NSOperationQueue
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    /*
     默认是并发队列,如果最大并发数>1,并发
     如果最大并发数==1,串行队列
     系统的默认是最大并发数-1 ,表示不限制
     设置成0则不会执行任何操作
     */
    queue.maxConcurrentOperationCount = 1;
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperationWithBlock:^{
        NSLog(@"queue block - %@",[NSThread currentThread]);
    }];
    
    //当值为YES的时候暂停,为NO的时候是恢复
//    queue.suspended = YES;
    
    /**
     取消所有的任务，不再执行，不可逆
     注意：暂停和取消只能暂停或取消处于等待状态的任务，不能暂停或取消正在执行中的任务，必须等正在执行的任务执行完毕之后才会暂停，如果想要暂停或者取消正在执行的任务，可以在每个任务之间即每当执行完一段耗时操作之后，判断是否任务是否被取消或者暂停。如果想要精确的控制，则需要将判断代码放在任务之中，但是不建议这么做，频繁的判断会消耗太多时间
     */
    //[queue cancelAllOperations];
}

/**
 线程通信
 */
- (void)threadCommunication {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
       // 回到主线程刷新UI
    }];
}

#pragma mark - Private

- (void)method1 {
    NSLog(@"method1 - %@",[NSThread  currentThread]);
}

- (void)method2 {
    NSLog(@"method2 - %@",[NSThread  currentThread]);
}

#pragma mark - 多图下载案例

- (void)demo  {
    // 创建非住队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    // 下载第一张图片
    NSBlockOperation *download1 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"http://img2.3lian.com/2014/c7/12/d/77.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.image1 = [UIImage imageWithData:data];
    }];
    // 下载第二张图片
    NSBlockOperation *download2 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"http://img2.3lian.com/2014/c7/12/d/77.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.image2 = [UIImage imageWithData:data];
    }];
    // 合成操作
    NSBlockOperation *combie = [NSBlockOperation blockOperationWithBlock:^{
        // 开启图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(375, 667));
        // 绘制图片1
        [self.image1 drawInRect:CGRectMake(0, 0, 375, 333)];
        // 绘制图片2
        [self.image2 drawInRect:CGRectMake(0, 334, 375, 333)];
        // 获取合成图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭图形上下文
        UIGraphicsEndImageContext();
        // 回到主线程刷新UI
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];
    // 添加依赖，合成图片需要等图片1，图片2都下载完毕之后合成
    [combie addDependency:download1];
    [combie addDependency:download2];
    // 添加操作到队列
    [queue addOperation:download1];
    [queue addOperation:download2];
    [queue addOperation:combie];
}

@end
