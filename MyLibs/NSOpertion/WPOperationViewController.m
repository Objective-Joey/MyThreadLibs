//
//  WPOperationViewController.m
//  MyLibs
//
//  Created by Joey on 2021/7/28.
//

#import "WPOperationViewController.h"

@interface WPOperationViewController ()
@property (strong, nonatomic) WPOperation *testOP;
@property (strong, nonatomic) NSOperationQueue *testQueue;
@end

@implementation WPOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //一：NSInvocationOperation子类+主队列
    //[self addOperationFormInvocation];
    //二：NSInvocationOperation子类+非主队列  (新开线程中执行)
    //[self addAsnysOperationFormInvocation];
    //三：使用子类- NSBlockOperation 主线程执行
//    [self addOperationFormBlock];
    //四：使用子类- NSBlockOperation 子线程执行 加入非主队列
//    [self addAsnysOperationFormBlock];
    //五：maxConcurrentOperationCount设置 并发或串行
    //[self addMaxConcurrentOperation];
    //六：定义继承自NSOperation的子类
    //[self addChildNSOperation1];
    //[self addChildNSOperation2];
//    [self configTestView];
    //七：操作依赖
    //[self addDependency];
    //八: 通信
    [self messageInterThread];
}

//------------------------------------------------------------------------------------------
//理论知识：
//NSOperation是苹果提供给我们的一套多线程解决方案。实际上NSOperation是基于GCD更高一层的封装，但是比GCD更简单易用、代码可读性也更高。
//NSOperation需要配合NSOperationQueue来实现多线程。因为默认情况下，NSOperation单独使用时系统同步执行操作，并没有开辟新线程的能力，只有配合NSOperationQueue才能实现异步执行

//------------------------------------------------------------------------------------------
//步骤3
//创建任务：先将需要执行的操作封装到一个NSOperation对象中。
//创建队列：创建NSOperationQueue对象。
//将任务加入到队列中：然后将NSOperation对象添加到NSOperationQueue中。

//------------------------------------------------------------------------------------------
//创建队列
//NSOperationQueue一共有两种队列：主队列、其他队列
//主队列 NSOperationQueue *queue = [NSOperationQueue mainQueue]; 凡是添加到主队列中的任务（NSOperation），都会放到主线程中执行
//其他队列（非主队列） NSOperationQueue *queue = [[NSOperationQueue alloc] init]; 就会自动放到子线程中执行 同时包含了：串行、并发功能

//------------------------------------------------------------------------------------------
//NSOperation是个抽象类，并不能封装任务。我们只有使用它的子类来封装任务。我们有三种方式来封装任务。
//
//使用子类NSInvocationOperation
//使用子类NSBlockOperation
//定义继承自NSOperation的子类，通过实现内部相应的方法来封装任务
#warning 关于自定义
//可以自定义并发 NSOperation 但没必要,在处理复杂问题必须自定义 NSOperation 时，结合NSOperationQueue来实现并发，重用，线程保活
//------------------------------------------------------------------------------------------
//其它知识点
//- (void)cancel; NSOperation提供的方法，可取消单个操作
//- (void)cancelAllOperations; NSOperationQueue提供的方法，可以取消队列的所有操作
//- (void)setSuspended:(BOOL)b; 可设置任务的暂停和恢复，YES代表暂停队列，NO代表恢复队列;如果这个值设置为 NO，那说明这个队列已经准备好了可以执行了。如果这个值设置为 YES，那么已经添加到队列中的操作还是可以执行了，而后面继续添加进队列中的操作才处于暂停状态，直到你再次将这个值设置为 NO 时，后面加入的操作才会继续执行。这个属性的默认值是 NO。

//- (BOOL)isSuspended; 判断暂停状态
//------------------------------------------------------------------------------------------


#pragma mark - 1
//一：NSInvocationOperation子类+主队列  (主线程中执行)
-(void)addOperationFormInvocation
{
    //NSOperationQueue *queue = [NSOperationQueue mainQueue];  //主队列 主线程  //[queue addOperation:op];进行加入动作  //不用写[op start];便可执行
    
    // 1.创建NSInvocationOperation对象
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runAction) object:nil];
    
    // 2.调用start方法开始执行操作
    [op start];
}

-(void)runAction
{
    NSLog(@"当前NSInvocationOperation执行的线程为：%@", [NSThread currentThread]);
    //输出：当前NSInvocationOperation执行的线程为：<NSThread: 0x600000071940>{number = 1, name = main}
    
    //说明
//  在没有使用NSOperationQueue、单独使用NSInvocationOperation的情况下，NSInvocationOperation在主线程执行操作，并没有开启新线程。
}

#pragma mark - 2

//二：NSInvocationOperation子类+非主队列  (新开线程中执行)
-(void)addAsnysOperationFormInvocation
{
    // 1. 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.创建NSInvocationOperation对象
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runAsnysAction) object:nil];
    
    [queue addOperation:op];
}

-(void)runAsnysAction
{
    NSLog(@"当前addAsnysOperationFormInvocation执行的线程为：%@", [NSThread currentThread]);
    //输出：当前addAsnysOperationFormInvocation执行的线程为：<NSThread: 0x600000279040>{number = 8, name = (null)}
    
    //说明
    //  创建NSOperationQueue队列，并把NSInvocationOperation加入则会新开一个线程来执行。
}

#pragma mark - 3

//三：使用子类- NSBlockOperation 主线程执行
-(void)addOperationFormBlock
{
    //NSOperationQueue *queue = [NSOperationQueue mainQueue];  //主队列 主线程  //[queue addOperation:op];进行加入动作  //不用写[op start];便可执行
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 在主线程
        NSLog(@"NSBlockOperation当前的线程：%@", [NSThread currentThread]);
        //输出：NSBlockOperation当前的线程：<NSThread: 0x60800007ecc0>{number = 1, name = main}
    }];
    
    //添加额外的任务(部分在子线程执行)
    //有可能仍在主线程执行
    [op addExecutionBlock:^{
        NSLog(@"NSBlockOperation当前的线程2------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"NSBlockOperation当前的线程3------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"NSBlockOperation当前的线程4------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"NSBlockOperation当前的线程5------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"NSBlockOperation当前的线程6------%@", [NSThread currentThread]);
    }];
    [op start];
    
    
    //输出
//    2021-07-28 18:46:13.466658+0800 MyLibs[77903:7272663] NSBlockOperation当前的线程5------<NSThread: 0x600001f4c580>{number = 7, name = (null)}
//    2021-07-28 18:46:13.466660+0800 MyLibs[77903:7272660] NSBlockOperation当前的线程2------<NSThread: 0x600001f74600>{number = 4, name = (null)}
//    2021-07-28 18:46:13.466651+0800 MyLibs[77903:7272558] NSBlockOperation当前的线程：<NSThread: 0x600001f2c900>{number = 1, name = main}
//    2021-07-28 18:46:13.466656+0800 MyLibs[77903:7272659] NSBlockOperation当前的线程3------<NSThread: 0x600001f66e40>{number = 3, name = (null)}
//    2021-07-28 18:46:13.466657+0800 MyLibs[77903:7272662] NSBlockOperation当前的线程6------<NSThread: 0x600001f7c040>{number = 5, name = (null)}
//    2021-07-28 18:46:13.466656+0800 MyLibs[77903:7272661] NSBlockOperation当前的线程4------<NSThread: 0x600001f5de80>{number = 6, name = (null)}
}
#pragma mark - 4
//四：使用子类- NSBlockOperation 子线程执行 加入非主队列
-(void)addAsnysOperationFormBlock
{
    // 1. 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 在子线程
        NSLog(@"addAsnysOperationFormBlock当前的线程：%@", [NSThread currentThread]);
    }];
    
    // 添加额外的任务（在新的子线程运行）
    [op addExecutionBlock:^{
        NSLog(@"addAsnysOperationFormBlock当前的线程2------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"addAsnysOperationFormBlock当前的线程3------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"addAsnysOperationFormBlock当前的线程4------%@", [NSThread currentThread]);
    }];
    
    [queue addOperation:op];
    
    
    //输出：
//    addAsnysOperationFormBlock当前的线程：<NSThread: 0x608000668400>{number = 9, name = (null)}
//    addAsnysOperationFormBlock当前的线程2------<NSThread: 0x608000668400>{number = 9, name = (null)}
//    addAsnysOperationFormBlock当前的线程3------<NSThread: 0x608000668400>{number = 9, name = (null)}
//    addAsnysOperationFormBlock当前的线程4------<NSThread: 0x600000463000>{number = 10, name = (null)}
}


#pragma mark  五：maxConcurrentOperationCount设置 并发或串行
-(void)addMaxConcurrentOperation
{
    // 1. 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //并发操作的最大值：你可以设定NSOperationQueue可以并发运行的最大操作数。NSOperationQueue会选择去运行任何数量的并发操作，但是不会超过最大值
    queue.maxConcurrentOperationCount=10;
    //修改成它的默认值
    //queue.MaxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 在子线程
        NSLog(@"addMaxConcurrentOperation当前的线程：%@", [NSThread currentThread]);
    }];
    
    // 添加额外的任务（部分在新的子线程运行）
    [op addExecutionBlock:^{
        NSLog(@"addMaxConcurrentOperation当前的线程2------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"addMaxConcurrentOperation当前的线程3------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"addMaxConcurrentOperation当前的线程4------%@", [NSThread currentThread]);
    }];
    
    [queue addOperation:op];
    
    
//    addMaxConcurrentOperation当前的线程：<NSThread: 0x600000460ac0>{number = 8, name = (null)}
//    addMaxConcurrentOperation当前的线程2------<NSThread: 0x600000460ac0>{number = 8, name = (null)}
//    addMaxConcurrentOperation当前的线程3------<NSThread: 0x600000460ac0>{number = 8, name = (null)}
//    addMaxConcurrentOperation当前的线程4------<NSThread: 0x60800026fc80>{number = 5, name = (null)}

    //说明：
//    maxConcurrentOperationCount默认情况下为-1，表示不进行限制，默认为并发执行。
//    当maxConcurrentOperationCount为1时，进行串行执行。
//    当maxConcurrentOperationCount大于1时，进行并发执行，当然这个值不应超过系统限制，即使自己设置一个很大的值，系统也会自动调整
}

#pragma mark 六：定义继承自NSOperation的子类

-(void)configTestView{
    
    UIButton * btn1 = [UIButton buttonWithType:0];
    btn1.backgroundColor = [UIColor redColor];
    btn1.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:btn1];
    [btn1 setTitle:@"测试重用" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * btn2 = [UIButton buttonWithType:0];
    btn2.backgroundColor = [UIColor blueColor];
    [btn2 setTitle:@"测试关闭" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(220, 100, 100, 100);
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(test2) forControlEvents:UIControlEventTouchUpInside];
}

-(void)test1{
    [_testOP setHasNewData:YES];
    NSLog(@"++%@",[_testQueue operations]);
}

-(void)test2{
    [_testOP setForceEnd];
    [_testOP cancel];
    //会被清出队列
    NSLog(@"++%@",[_testQueue operations]);
}
-(void)addChildNSOperation1
{
    // 1. 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    WPOperation * op = [[WPOperation alloc] init];
    
    [queue addOperation:op];
    
//    输出
//    MPOperation当前的线程-----<NSThread: 0x6080002768c0>{number = 11, name = (null)}
//    MPOperation当前的线程-----<NSThread: 0x6080002768c0>{number = 11, name = (null)}
}
-(void)addChildNSOperation2
{
    // 1. 创建队列
    _testQueue = [[NSOperationQueue alloc] init];
    _testOP = [[WPOperation alloc] init];
    [_testQueue addOperation:_testOP];
    //测试线程重用和终止
}
#pragma mark 7操作依赖
-(void)addDependency
{
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"addDependency1当前线程%@", [NSThread  currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"addDependency2当前线程%@", [NSThread  currentThread]);
    }];
    
    [op1 addDependency:op2];    // 让op1 依赖于 op2，则先执行op2，在执行op1
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    //返回执行的operation
    //[queue operations];
    //When the value of this property is NO, the queue actively starts operations that are in the queue and ready to execute. Setting this property to YES prevents the queue from starting any queued operations, but already executing operations continue to execute. You may continue to add operations to a queue that is suspended but those operations are not scheduled for execution until you change this property to NO.
    //[queue setSuspended:NO];
    //输出
//    addDependency2当前线程<NSThread: 0x60000027c200>{number = 12, name = (null)}
//    addDependency1当前线程<NSThread: 0x608000262900>{number = 9, name = (null)}
}

#pragma mark - 线程通信

-(void)messageInterThread{
    // 嵌套即可
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"addDependency1当前线程%@", [NSThread  currentThread]);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"回到主线程 当前线程%@", [NSThread  currentThread]);
        }];
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"addDependency2当前线程%@", [NSThread  currentThread]);
    }];
//    [op2 setQueuePriority:NSOperationQueuePriorityHigh];
    op1.completionBlock = ^{
        NSLog(@"任务完成 当前线程%@", [NSThread  currentThread]);
    };
    
    [queue addOperation:op1];
    [queue addOperation:op2];

}
@end
