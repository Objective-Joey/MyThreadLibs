//
//  AppleThreadGuideViewController.m
//  MyLibs
//
//  Created by Joey on 2021/7/27.
//

#import "AppleThreadGuideViewController.h"
#import <WebKit/WKWebView.h>

@interface AppleThreadGuideViewController ()
@property (strong,nonatomic)WKWebView *wkWebView;
@end

@implementation AppleThreadGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(concurrencyProgrammingGuide) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0 , 0, 44, 44);
    [button setTitle:@"并行编程" forState:UIControlStateNormal];
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Multithreading/AboutThreads/AboutThreads.html"]]];
    [self.view addSubview:self.wkWebView];
    // Do any additional setup after loading the view.
}


- (void)concurrencyProgrammingGuide{
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008091"]]];
    
}

@end
