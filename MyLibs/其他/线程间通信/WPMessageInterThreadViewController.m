//
//  WPMessageInterThreadViewController.m
//  MyLibs
//
//  Created by Joey on 2021/7/30.
//

#import "WPMessageInterThreadViewController.h"

@interface WPMessageInterThreadViewController ()

@property (strong, nonatomic) NSThread *testThread;
@end

@implementation WPMessageInterThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //通信1 线程切换
    //通信2 线程间传递数据
}
//方法 1
//此系列方法可以直接通信
-(void)performSerieMethod{
    
    _testThread = [[NSThread alloc] initWithTarget:self selector:@selector(test) object:nil];
//    [_testThread start];
    
    NSThread *mainP = [NSThread mainThread];
    //下面三个方法都无法取消 而且线程要开启runloop
    //1、
    [NSObject performSelector:@selector(test) onThread:_testThread withObject:nil waitUntilDone:NO];
    //2
    [NSObject performSelectorOnMainThread:@selector(test) withObject:nil waitUntilDone:NO];
    //
    [NSObject performSelector:@selector(test)  onThread:mainP withObject:nil waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
    // 在当前线程 如果没有开启runloop 不会执行 此方法对应有取消方法
    [NSObject performSelector:@selector(test) withObject:nil afterDelay:2];
    //对应取消方法
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    // 指定mode
    [NSObject performSelector:@selector(test) withObject:nil afterDelay:2 inModes:@[NSRunLoopCommonModes]];
}

-(void)test{
    NSLog(@"当前线程______%@",[NSThread currentThread]);
}
//方法 2
-(void)useGCD{
    
}
//方法 3
-(void)useOperation{
    
}
//方法 4 NSMachPort
-(void)usePort{
    //没用过 也不想了解
}
#pragma mark -
//数据共享
//同步锁
@end
