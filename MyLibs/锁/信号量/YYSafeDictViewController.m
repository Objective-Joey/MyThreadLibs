//
//  YYSafeDictViewController.m
//  MyLibs
//
//  Created by Joey on 2021/7/27.
//

#import "YYSafeDictViewController.h"
#import <YYKit/YYThreadSafeDictionary.h>
@interface YYSafeDictViewController ()

@property (strong, nonatomic) UITextView *textView;
@end

@implementation YYSafeDictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.textView];
    self.textView.text = @"使用步骤：1、创建起始信号数的信号量:(dispatch_semaphore_t _lock = dispatch_semaphore_create(1))；\n2、消耗信号数阻塞线程:dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER)；\n3、完成任务释放信号数:dispatch_semaphore_signal(_lock)。\n\n 相关操作还有:\n 1、获取可用信号数；\n2、查询是否有线程正在等待获取\n3、指定信号超时时间.\ndispatch_semaphore_signal的返回值为long类型，当返回值为0时表示当前并没有线程等待其处理的信号量，其处理的信号量的值加1即可。当返回值不为0时，表示其当前有（一个或多个）线程等待其处理的信号量，并且该函数唤醒了一个等待的线程（当线程有优先级时，唤醒优先级最高的线程；否则随机唤醒）。dispatch_semaphore_wait的返回值也为long型。当其返回0时表示在timeout之前，该函数所处的线程被成功唤醒。当其返回不为0时，表示timeout发生。\n详见：https://www.cnblogs.com/snailHL/p/3906112.html";
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.edges.equalTo(self.view);
    }];
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = [UITextView new];
        _textView.font = [UIFont systemFontOfSize:14];
    }
    return _textView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
