//
//  AFBarrierViewController.m
//  MyLibs
//
//  Created by Joey on 2021/7/27.
//

#import "AFBarrierViewController.h"

@interface AFBarrierViewController ()
@property (strong, nonatomic) UITextView *textView;
@end

@implementation AFBarrierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.textView];
    self.textView.text = @"使用步骤：1、创建并发队列:(dispatch_queue_t queue = dispatch_queue_create(\"queue\", DISPATCH_QUEUE_CONCURRENT))；\n2、同步或者异步阻塞并发队列:dispatch_barrier_sync(queue,nil)或者dispatch_barrier_async(queue,nil)。\n\n 注意事项:\n 1、dispatch_barrier_async函数:The queue you specify should be a concurrent queue that you create yourself using the dispatch_queue_create function. If the queue you pass to this function is a serial queue or one of the global concurrent queues, this function behaves like the dispatch_async function；\n2、dispatch_barrier_sync函数:The queue you specify should be a concurrent queue that you create yourself using the dispatch_queue_create function. If the queue you pass to this function is a serial queue or one of the global concurrent queues, this function behaves like the dispatch_sync function;\n3、dispatch_barrier_async函数会copyblock，The barrier block to submit to the target dispatch queue. This block is copied and retained until it finishes executing, at which point it is released. This parameter cannot be NULL,强引用，所以要注意循环引用问题。Unlike with dispatch_barrier_async, no retain is performed on the target queue. Because calls to this function are synchronous, it \"borrows\" the reference of the caller. Moreover, no Block_copy is performed on the block.\nAs an optimization, this function invokes the barrier block on the current thread when possible.";
    // Do any additional setup after loading the view.
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
