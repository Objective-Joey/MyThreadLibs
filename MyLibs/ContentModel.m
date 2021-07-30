//
//  ContentModel.m
//  ReactiveCocoa_Use
//
//  Created by koala on 2018/6/13.
//  Copyright © 2018年 koala. All rights reserved.
//

#import "ContentModel.h"

@implementation ContentModel

- (NSArray *)headNameArray {
    
    if (_headNameArray == nil) {
        _headNameArray = @[@"About Threaded Programming",@"Lock",@"NSOpertion",@"GCD",@"同步工具",@"线程安全",@"其他"];
    }
    return _headNameArray;
}

- (NSArray *)demoArray{
    
    if (_demoArray == nil) {
        _demoArray = @[
        @[@"Threaded_Programming"],
        //常见的锁的使用
        @[@"dispatch_semaphore",@"dispatch_barrier",@"pthread_rwlock_t",@"serial_queue",@"synchronized",@"lock_demo"],
        @[@"NSOperation_Demo"],
        @[@"GCD_Demo"],
        @[@"dispatch_group_demo",@"osAtomic_demo"],
        @[@"thread_safe_atomic_demo"],
        @[@"message_inter_thread"]
        ];
    }
    return _demoArray;
}


- (NSDictionary *)describeDict {
    
    if (_describeDict == nil) {
        
        _describeDict = @{
                          //信号的基本使用
            
            
                          @"Threaded_Programming":@"Apple Doc.",
                          @"dispatch_semaphore":@"通过信号量可以控制同时访问资源的线程个数,例如 YYSafeDictionary",
                          @"dispatch_barrier":@"通过栅栏函数阻塞自创建并发队列，实现同步任务,例如 AFHTTPRequestSerializer",
                          @"pthread_rwlock_t":@"pthread 读写锁",
                          @"serial_queue":@"使用串行队列，避免竞态，例如：FMDB",
                          @"synchronized":@"@synchronized结构所做的事情跟锁（lock）类似：它防止不同的线程同时执行同一段代码。但在某些情况下，相比于使用 NSLock 创建锁对象、加锁和解锁来说，@synchronized 用着更方便，可读性更高。",
                          @"NSOperation_Demo":@"NSOperation是苹果提供给我们的一套多线程解决方案。实际上NSOperation是基于GCD更高一层的封装，但是比GCD更简单易用、代码可读性也更高。",
                          @"GCD_Demo":@"C风格基于线程池分配，简单易用",
                          @"dispatch_group_demo":@"GCD 异步队列同步",
                          @"thread_safe_atomic_demo":@"关于原子性",
                          @"message_inter_thread":@"线程通信的方法总结",
                          @"lock_demo":@"编写多线程代码最重要的一点是：对共享数据的访问要加锁。",
                          @"osAtomic_demo":@"原子操作(Atomic Operations)满足只有一个线程可以访问Shared data, 同时不需要加锁。OSAtomic是OS X的原子操作库。例如 ReactiveObjC ",
                          };
    }
    return _describeDict;
    
}


@end
