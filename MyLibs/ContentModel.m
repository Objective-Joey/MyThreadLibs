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
//        _headNameArray = @[@"Lock",@"GCD",@"NSOperation",@"NSOperationQueue",@"NSThread", @"_pthread",@"Atomic",@"信号"];
        _headNameArray = @[@"About Threaded Programming",@"Lock",@"NSOpertion",@"GCD",@"同步工具"];
    }
    return _headNameArray;
}

- (NSArray *)demoArray{
    
    if (_demoArray == nil) {
        _demoArray = @[
        @[@"Threaded_Programming"],
        //常见的锁的使用
        @[@"dispatch_semaphore",@"dispatch_barrier",@"pthread_rwlock_t",@"serial_queue",@"synchronized"],
        @[@"NSOperation_Demo"],
        @[@"GCD_Demo"],
        @[@"dispatch_group_demo"],
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
                          };
    }
    return _describeDict;
    
}


@end
