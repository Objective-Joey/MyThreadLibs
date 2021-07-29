//
//  WPOperation.m
//  MyLibs
//
//  Created by Joey on 2021/7/29.
//

#import "WPOperation.h"
@interface WPOperation ()
{
    NSThread        *mainThread; //main主线程
    NSRunLoop       *mainRunloop;//main的Runloop
}

@end

@implementation WPOperation

-(void)main
{
    @autoreleasepool {
        //添加基于 "端口" 的Runloop
        mainRunloop = [NSRunLoop currentRunLoop];
        [mainRunloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        mainThread = [NSThread currentThread];
        
//        NSLog(@"当前线程_______%@",mainThread);
        //[self TestRunloopState];
        
        
        [self setHasNewData:YES];
        
        while(!self.cancelled) {
            NSLog(@"Begin runloop");
            BOOL result = [mainRunloop runMode:NSDefaultRunLoopMode
                                    beforeDate: [NSDate distantFuture]];
            
            NSLog(@"End runloop. %@",[NSNumber numberWithBool:result]);
        }
    }
}

-(void)TestRunloopState
{
    //设置Run loop observer的运行环境
    CFRunLoopObserverContext context = {0,(__bridge void *)(self),NULL,NULL,NULL};
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,kCFRunLoopAllActivities, YES, 0, &myRunLoopObserver, &context);
    
    if(observer)
    {
        //将Cocoa的NSRunLoop类型转换成CoreFoundation的CFRunLoopRef类型
        CFRunLoopRef cfRunLoop = [[NSRunLoop currentRunLoop] getCFRunLoop];
        
        //将新建的observer加入到当前thread的runloop
        CFRunLoopAddObserver(cfRunLoop, observer, kCFRunLoopDefaultMode);
    }

}

void myRunLoopObserver(CFRunLoopObserverRef observer,CFRunLoopActivity activity,void *info)
{
    switch (activity)
    {
        case kCFRunLoopEntry:
            NSLog(@"run loop entry");
            break;
            
        case kCFRunLoopBeforeTimers:
            NSLog(@"run loop before timers");
            break;

        case kCFRunLoopBeforeSources:
            NSLog(@"run loop before sources");
            break;
        
        case kCFRunLoopBeforeWaiting:
            NSLog(@"run loop before waiting");
            break;
            
        case kCFRunLoopAfterWaiting:
            NSLog(@"run loop after waiting");
            break;
        
        case kCFRunLoopExit:
            NSLog(@"run loop exit");
            break;
            
        default:
            break;
    }
    
}

- (void)postCloseRunloopMessage
{
    [self performSelector:@selector(closeMainRunLoop) onThread:mainThread withObject:nil waitUntilDone:NO];
}

- (void)closeMainRunLoop
{
     //CFRunLoopStop([mainRunloop getCFRunLoop]);
}

-(void)setForceEnd
{
//    [self closeMainRunLoop];
    [self postCloseRunloopMessage];
}


- (void)setHasNewData:(BOOL)newData
{
    NSLog(@"当前线程_______%@",mainThread);
    NSLog(@"住线程_______%@",[NSThread mainThread]);
    NSLog(@"有新数据需要处理");
    [self performSelector:@selector(processData) onThread:mainThread withObject:nil waitUntilDone:NO];
    NSLog(@"处理数据完毕");
    
}

-(void)processData{
    
    NSLog(@"正在处理数据");
}
@end
