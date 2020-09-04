//
//  DNOperation.h
//  iOS多线程
//
//  Created by Donny on 2020/6/25.
//  Copyright © 2020 Etouch. All rights reserved.
//
/*
 自定义非并发的NSOperation步骤：
 1.实现main方法，在main方法中执行自定义的任务
 2.正确的响应取消事件
 
 注意两点：1.创建释放池；2.正确取消事件
*/

#import <Foundation/Foundation.h>

@interface DNSerialOperation : NSOperation

@end

