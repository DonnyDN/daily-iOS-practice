//
//  DNConcurrentOperation.h
//  iOS多线程
//
//  Created by Donny on 2020/6/25.
//  Copyright © 2020 Etouch. All rights reserved.
//
/**
 自定义并发的NSOperation需要以下步骤：
 1.start方法：该方法必须实现，
 2.main:该方法可选，如果你在start方法中定义了你的任务，则这个方法就可以不实现，但通常为了代码逻辑清晰，通常会在该方法中定 义自己的任务
 3.isExecuting isFinished 主要作用是在线程状态改变时，产生适当的KVO通知
 4.isConcurrent :必须覆盖并返回YES;
 */

#import <Foundation/Foundation.h>

@interface DNConcurrentOperation : NSOperation
{
    BOOL executing;
    BOOL finished;
}  
@end
