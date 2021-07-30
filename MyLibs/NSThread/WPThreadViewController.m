//
//  WPThreadViewController.m
//  MyLibs
//
//  Created by Joey on 2021/7/30.
//

#import "WPThreadViewController.h"

@interface WPThreadViewController ()
@property(strong,nonatomic)NSThread *myThread;
@end

@implementation WPThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}
// 就绪 启动 取消 退出
//创建后 设置好环境参数 就处于就绪状态
//[p start]
//[p cancle]
//[p exit]
// 隐式创建
-(void)threadDemo_1{
    
    [self performSelectorInBackground:@selector(runAction) withObject:nil];
}
//手动启动
-(void)threadDemo_2{
    
    NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(runAction) object:nil];
    thread.name=@"thread-wp";
    [thread start];
}
-(void)threadDemo_3{
    
    //1：创建线程后自动启动线程
    [NSThread detachNewThreadSelector:@selector(runAction) toTarget:self withObject:nil];
}

-(void)runAction{
    [NSThread mainThread];
    if ([NSThread isMainThread]) {
        NSLog(@"当前创建的线程为主线程________%@",[NSThread currentThread]);
    }
    NSLog(@"当前创建的线程________%@",[NSThread currentThread]);
}
@end
