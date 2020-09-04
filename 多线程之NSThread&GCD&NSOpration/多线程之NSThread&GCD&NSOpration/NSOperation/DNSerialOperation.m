//
//  DNOperation.m
//  iOS多线程
//
//  Created by Donny on 2020/6/25.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import "DNSerialOperation.h"

@implementation DNSerialOperation

/*自定义main方法执行你的任务*/
- (void)main {
    //捕获异常
    @try {
        //在这里我们要创建自己的释放池，因为这里我们拿不到主线程的释放池
        @autoreleasepool {
            BOOL isDone = NO;
            //正确的响应取消事件
            while(![self isCancelled] && !isDone)
            {
                //在这里执行自己的任务操作
                NSLog(@"执行自定义非并发NSOperation");
                NSThread *thread = [NSThread currentThread];
                NSLog(@"%@",thread);
                  
                //任务执行完成后将isDone设为YES
                isDone = YES;
            }
        }
    }
    @catch (NSException *exception) {
    }
}

/**
 默认情况下，该operation在当前调用start的线程中执行.其实如果我们创建多个自定义的ZCNoCurrentOperation，并放入NSOperationQueue中，这些任务也是并发执行的，只不过因为我们没有处理并发情况下，线程执行完，KVO等操作，因此不建议在只实现main函数的情况下将其加入NSOperationQueue，只实现main一般只适合自定义非并发的。
 */

@end
