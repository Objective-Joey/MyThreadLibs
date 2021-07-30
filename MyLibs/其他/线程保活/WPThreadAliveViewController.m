//
//  WPThreadAliveViewController.m
//  MyLibs
//
//  Created by Joey on 2021/7/30.
//

#import "WPThreadAliveViewController.h"

@interface WPThreadAliveViewController ()

@end

@implementation WPThreadAliveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

-(void)info{
    
    // AF 3.0以前
    
    [[NSThread currentThread] setName:@"AFNetworking"];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //启动前必须设置一个 mode ，而 mode 要存在则至少需要一个 source / timer
    [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    //启动
    [runLoop run];
    //子线程默认是完成任务后结束。当要经常使用子线程，每次开启子线程比较耗性能。此时可以开启子线程的 RunLoop，保持 RunLoop 运行，则使子线程保持不死
    //线程默认是不开启runloop的 ,如果开启了runloop但是没有事件源，runloop会马上退出。
    //为了重复使用线程 就要让runloop开启，并休眠，在合适的时机激活。
    //AFNetWorking 线程保活
//    因为 RunLoop 启动前必须设置一个 mode，而 mode 要存在则至少需要一个 source / timer。所以上面的做法是为 RunLoop 的 DefaultMode 添加一个 NSMachPort 对象，虽然消息是可以通过 NSMachPort 对象发送到 loop 内，但这里添加的 port 只是为了 RunLoop 一直不退出，而没有发送什么消息。当然我们也可以添加一个超长启动时间的 timer 来既保持 RunLoop 不退出也不占用资源。
    
}
@end
