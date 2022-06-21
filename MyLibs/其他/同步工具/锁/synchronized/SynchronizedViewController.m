//
//  SynchronizedViewController.m
//  MyLibs
//
//  Created by Joey on 2021/7/27.
//

#import "SynchronizedViewController.h"
#import <WebKit/WKWebView.h>
@interface SynchronizedViewController ()
@property (strong,nonatomic)WKWebView *wkWebView;

@end

@implementation SynchronizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jianshu.com/p/b617b8883ae0"]]];
    [self.view addSubview:self.wkWebView];
    // Do any additional setup after loading the view.
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
