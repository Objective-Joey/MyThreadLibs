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
        _headNameArray = @[@"Lock"];
    }
    return _headNameArray;
}

- (NSArray *)demoArray{
    
    if (_demoArray == nil) {
        _demoArray = @[
                       //常见的锁的使用
                       @[@"dispatch_semaphore",@"dispatch_barrier",@"pthread_rwlock_t"],
                       ];
    }
    return _demoArray;
}


- (NSDictionary *)describeDict {
    
    if (_describeDict == nil) {
        
        _describeDict = @{
                          //信号的基本使用
                          @"dispatch_semaphore":@"通过信号量可以控制同时访问资源的线程个数,例如 YYSafeDictionary",
                          @"dispatch_barrier":@"通过栅栏函数阻塞自创建并发队列，实现同步任务,例如 AFHTTPRequestSerializer",
                          @"pthread_rwlock_t":@"pthread 读写锁",
                          };
    }
    return _describeDict;
    
}


@end