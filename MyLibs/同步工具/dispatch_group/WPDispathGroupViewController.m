//
//  WPDispathGroupViewController.m
//  MyLibs
//
//  Created by Joey on 2021/7/29.
//

#import "WPDispathGroupViewController.h"

@interface WPDispathGroupViewController ()

@end

@implementation WPDispathGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //1、简单场景 等待任务完成
    [self dispathGroup1];
    //2、任务内嵌套异步提交
    [self dispathGroup2];
    //3、使用 dispatch_group_enter 和 dispatch_group_leave 确保 真正的任务完成
    [self groupSyncNoti];
    //4、使用wait 阻塞实现同步
    [self groupSyncWait];
}
#pragma  mark - 场景1
-(void)dispathGroup1{
    
    dispatch_queue_t queue  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        sleep(5);
        NSLog(@"任务一完成");
    });
    dispatch_group_async(group, queue, ^{
        sleep(8);
        NSLog(@"任务二完成");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"done");
    });
}
//如果dispatch_group_async里执行的是异步代码dispatch_group_notify会直接触发而不会等待异步任务完成，而dispatch_group_enter、和dispatch_group_leave则不会有这个问题，它们只需要在任务开始前enter结束后leave即可达到线程同步的效果。
-(void)dispathGroup2{
    
    dispatch_queue_t dispatchQueue = dispatch_queue_create("ted.queue.next1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t globalQueue  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();

    
    dispatch_group_async(group, dispatchQueue, ^{
        dispatch_async(globalQueue, ^{
            sleep(5);
            NSLog(@"任务一完成");
        });
    });
    dispatch_group_async(group, dispatchQueue, ^{
        sleep(1);
        NSLog(@"任务二完成");
    });
    dispatch_group_async(group, dispatchQueue, ^{
        dispatch_async(globalQueue, ^{
            sleep(2);
            NSLog(@"任务三完成");
        });
    });
    //一定要写在最后面
    //否则会先执行
    dispatch_group_notify(group,  dispatch_get_main_queue(), ^{
        NSLog(@"done");
    });
//    2021-07-29 17:15:14.469592+0800 MyLibs[11033:8237987] 任务二完成
//    2021-07-29 17:15:15.469638+0800 MyLibs[11033:8237992] 任务三完成
//    2021-07-29 17:15:18.470214+0800 MyLibs[11033:8237990] 任务一完成
//    2021-07-29 17:15:18.470474+0800 MyLibs[11033:8237855] done
    
    //可以看到 异步任务不会立即返回。 dispatch_group_notify会等待全部任务完成触发

}
-(void)dispathGroup3{
    
    dispatch_queue_t dispatchQueue = dispatch_queue_create("ted.queue.next1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t globalQueue  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_enter(group);
    dispatch_group_async(group, dispatchQueue, ^{
        dispatch_async(globalQueue, ^{
            sleep(5);
            NSLog(@"任务一完成");
            dispatch_group_leave(group);
        });
    });
    dispatch_group_async(group, dispatchQueue, ^{
        sleep(1);
        NSLog(@"任务二完成");
    });
    dispatch_group_enter(group);
    
    dispatch_group_async(group, dispatchQueue, ^{
        dispatch_async(globalQueue, ^{
            sleep(2);
            NSLog(@"任务三完成");
            dispatch_group_leave(group);
        });
    });
    //一定要写在最后面
    //否则会先执行
    dispatch_group_notify(group,  dispatch_get_main_queue(), ^{
        NSLog(@"done");
    });
//    2021-07-29 17:11:50.348652+0800 MyLibs[10981:8235046] 任务二完成
//    2021-07-29 17:11:50.349293+0800 MyLibs[10981:8235000] done
//    2021-07-29 17:11:51.350743+0800 MyLibs[10981:8235048] 任务三完成
//    2021-07-29 17:11:54.351756+0800 MyLibs[10981:8235045] 任务一完成
    
    //可以看到 异步任务立即返回。 dispatch_group_notify不会等待 触发

}
// 通过通知 来真正确定任务完成
- (void)groupSyncNoti
{
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        sleep(5);
        NSLog(@"任务一完成");
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        sleep(8);
        NSLog(@"任务二完成");
        dispatch_group_leave(group);
    });
    // dispatch_group_enter
    //dispatch_group_leave
    //成对出现
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"任务完成");
    });
}

- (void)groupSyncWait
{
    dispatch_group_t group = dispatch_group_create();
    NSLog(@"group---begin");
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        sleep(5);
        NSLog(@"任务一完成");
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        sleep(8);
        NSLog(@"任务二完成");
        dispatch_group_leave(group);
    });
    NSLog(@"code end");
    
    // dispatch_group_enter
    //dispatch_group_leave
    //成对出现
    //等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"等待上面的1，2任务全部完成后，会继续往下执行，阻塞当前线程");

}
@end
