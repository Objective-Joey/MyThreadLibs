//
//  WPInfoWebViewController.m
//  MyLibs
//
//  Created by Joey on 2021/7/30.
//
#import <WebKit/WKWebView.h>
#import "WPInfoWebViewController.h"

@interface WPInfoWebViewController ()
@property (strong,nonatomic)WKWebView *wkWebView;
@end

@implementation WPInfoWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0 , 0, 44, 44);
    [button setTitle:@"nextPage" forState:UIControlStateNormal];
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:self.wkWebView];
}

-(void)nextPage{

    if (self.nextUrl) {
        WPInfoWebViewController * nextPage = [WPInfoWebViewController new];
        nextPage.url = self.nextUrl;
        [self.navigationController pushViewController:nextPage  animated:YES];
    }
}

@end
