//
//  UIViewController+GCD.m
//  iOS多线程
//
//  Created by Donny on 2020/6/24.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import "UIViewController+GCD.h"

@implementation UIViewController (GCD)

- (void)test_gcd {

    [self dispatch_apply_test];

    [self dispatchGroup];
}

- (void)deadlock1{
    //DISPATCH_QUEUE_CONCURRENT创建自定义并行队列，DISPATCH_QUEUE_SERIAL -->NULL串行队列
    //死锁1：串行队列中任务是顺序相互等待执行的，不能任务中套任务
    dispatch_queue_t queue = dispatch_queue_create("serial.www.hunanwang.net.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"在串行队列中开辟了新线程，任务仍然串行执行");
        dispatch_sync(queue, ^{
            NSLog(@"在新线程中执行任务，但是需要等dispatch_async任务执行完才执行，互相等待死锁");
        });
        NSLog(@"return");
    });
}

//任务组
- (void)dispatchGroup{
    dispatch_queue_t queue1 = dispatch_queue_create("com.queue1", 0);
    dispatch_queue_t queue2 = dispatch_queue_create("com.queue2", 0);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_async(queue1, ^{
        NSLog(@"task1");
    });

    //往任务组添加任务，手动管理group关联的block的运行状态（或计数），进入和退出group次数必须对应
    dispatch_group_enter(group);
    dispatch_async(queue2, ^{
        NSLog(@"task2");
        dispatch_group_leave(group);
    });
    
    dispatch_group_async(group, queue1, ^{
        //队列挂起
//        dispatch_suspend(queue1);
        NSLog(@"task5");
    });
    dispatch_group_async(group, queue2, ^{
        //队列挂起
//        dispatch_suspend(queue2);
        NSLog(@"task6");
    });
    
    //阻止当前的线程继续执行,等待group关联的block执行完毕后再执行以下代码，可以设置超时参数。
    //dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC);//3秒
    //当group队列的任务都执行完（除notify），wait会超时跳出等待，执行notify
    dispatch_group_async(group, queue2, ^{
        //队列挂起
        //        dispatch_suspend(queue2);
        sleep(3);
        NSLog(@"task7");
    });
    
    long a = dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    if (a == 0){
        NSLog(@"属于Dispatch Group的任务全部处理执行完毕");
    }else{
        NSLog(@"属于Dispatch Group的某一个处理还在执行中");
    }
    
    
    dispatch_group_async(group, queue2, ^{
        //队列挂起
        //        dispatch_suspend(queue2);
        sleep(3);
        NSLog(@"task7");
    });
    
    dispatch_async(queue1, ^{
        NSLog(@"task3");
    });
    
    dispatch_async(queue2, ^{
        NSLog(@"task4");
    });

    //dispatch_group_notify 用来监听任务组事件的执行完毕
//    dispatch_group_notify(group, queue1, ^{
//        NSLog(@"最后执行");
//    });
    //队列恢复
//    dispatch_resume(queue1);
//    dispatch_resume(queue2);
}

- (void)groupDemo {
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    dispatch_group_enter(dispatchGroup);
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"https://www.baidu.com"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"got data from internet1");
        
        dispatch_group_leave(dispatchGroup);
    }];
    [task resume];
    
    dispatch_group_enter(dispatchGroup);
    
    NSURLSessionDataTask *task2 = [session dataTaskWithURL:[NSURL URLWithString:@"https://www.baidu.com"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"got data from internet2");
        
        dispatch_group_leave(dispatchGroup);
    }];
    [task2 resume];
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        NSLog(@"end");
    });
}

//信号量
- (void)XINHAOLIANG{
    //        如果dsema信号量大于0，该函数所处线程就继续执行下面语句，并且将信号量的值减1;
    //        如果desema为0，那么这个函数就阻塞当前线程等待timeout（注意timeout的类型为dispatch_time_t，不能直接传入整形或float型数），如果等待的期间desema的值被dispatch_semaphore_signal函数加1了，且该函数所处线程获得了信号量，那么就继续向下执行并将信号量减1。如果等待期间没有获取到信号量或者信号量的值一直为0，那么等到timeout时，其所处线程自动执行其后语句。
    
    /**
     通过信号量控制，将异步的线程变成同步线程
     */
    dispatch_group_t group = dispatch_group_create();
    //设置初始信号量为1时，下面全部是顺序执行开启线程同步执行；初始为5时，前5次是顺序执行开启线程异步执行的，就是将队列的最大并发数控制在5个。（猜测是前5次主线程执行很快，子线程未能给主线程的信号量+1，就执行下一次循环了，每次循环都会给信号量-1，直到信号量为0）；
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(5);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (int i = 0; i < 20; i++)
    {
        //dispatch_semaphore_wait这里是在主线程的，若信号量大于0，就-1，继续执行；当信号量为1时，再-1，信号量变为0，再次执行到dispatch_semaphore_wait时，主线程就会在设置的时间内等待信号量>0,若timeout，放弃后续任务，若未timeout，信号量通过dispatch_semaphore_signal变为1>0了，就继续执行。
        //当信号量在1-0之间变换时，可以控制当前主线程，顺序执行开启线程同步执行doSomething。在这两句代码中间的执行代码，每次只会允许一个线程进入。
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%d线程开启",i);
            [self doSomething:i];
            //给主线程的信号量+1
            dispatch_semaphore_signal(semaphore);
            NSLog(@"%d线程结束了",i);
            
        });
    }
    //等待group关联的block执行完毕，也可以设置超时参数
    //    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}
- (void)doSomething:(int)index{
    //    sleep(0.3);
    NSLog(@"doSomething - %i",index);
}

- (void)dispatch_apply_test {
    //由于dispatch_apply函数也与dispatch_sync函数相同，会等待处理执行结束，因此推荐在dispatch_async函数中异步执行dispatch_apply函数
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5"];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_apply([array count], queue, ^(size_t index) {
            NSLog(@"index:%zu - %@", index, [array objectAtIndex:index]);
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"done");
        });
    });
}


#pragma mark - 创建一个GCD定时器，不受runloop影响
- (void)gcdTimer{
  
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
//    GCD的时间单位是纳秒，故（1 * NSEC_PER_SEC）是1秒，NSEC_PER_SEC = 1000000000；
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        //执行回调任务..
        NSLog(@"当前线程：%@",[NSThread currentThread]);
    });
    dispatch_resume(timer);
}

@end
