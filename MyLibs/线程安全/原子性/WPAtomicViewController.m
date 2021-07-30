//
//  WPAtomicViewController.m
//  MyLibs
//
//  Created by Joey on 2021/7/30.
//

#import "WPAtomicViewController.h"
#import <WebKit/WKWebView.h>


@interface WPAtomicViewController ()
@property (strong,nonatomic)WKWebView *wkWebView;
@end

@implementation WPAtomicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://blog.csdn.net/weixin_39950838/article/details/107832407"]]];
    [self.view addSubview:self.wkWebView];
}

//atomic所说的线程安全只是保证了getter和setter存取方法的线程安全，并不能保证整个对象是线程安全的。
//https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/EncapsulatingData/EncapsulatingData.html
//Note: Property atomicity is not synonymous with an object’s thread safety.
#warning 关键点
//保证的是 保证了getter和setter存取方法的线程安全 并不保证操作的队象 XYZPerson 是线程安全的 因为他的名字在多线程的情况下出错了，为了保证线程安全 还是需要lock  XYZPerson 对象 整体线程安全
//
//Consider an XYZPerson object in which both a person’s first and last names are changed using atomic accessors from one thread. If another thread accesses both names at the same time, the atomic getter methods will return complete strings (without crashing), but there’s no guarantee that those values will be the right names relative to each other. If the first name is accessed before the change, but the last name is accessed after the change, you’ll end up with an inconsistent, mismatched pair of names.
//
//This example is quite simple, but the problem of thread safety becomes much more complex when considered across a network of related objects. Thread safety is covered in more detail in Concurrency Programming Guide.

// 这篇文章有讲
//https://blog.csdn.net/u012903898/article/details/82984959

//

#warning 关键点 自旋锁 atomic

//property 的 atomic 是采用 spinlock_t 也就是俗称的自旋锁实现的.
//
//自旋锁会忙等: 所谓忙等，即在访问被锁资源时，调用者线程不会休眠，而是不停循环在那里，直到被锁资源释放锁。
//互斥锁会休眠: 所谓休眠，即在访问被锁资源时，调用者线程会休眠，此时cpu可以调度其他线程工作。直到被锁资源释放锁。此时会唤醒休眠线程。

//讲解

//https://blog.csdn.net/weixin_39950838/article/details/107832407
@end
