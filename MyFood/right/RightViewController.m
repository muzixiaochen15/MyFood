//
//  RightViewController.m
//  MyFood
//
//  Created by qunlee on 16/11/10.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "RightViewController.h"
#import "EQXColor.h"
#import "PureLayout/PureLayout.h"
#import <WebKit/WebKit.h>

@interface RightViewController ()<WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate>{
    WKWebView *_webView;
    CGFloat _currentOffsetY;
}

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [EQXColor colorWithHexString:@"#f6f6f6"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"FZY3K--GB1-0" size:15.0f]}];
    self.title = @"创作";
    
    //初始化
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    configuration.preferences = [[WKPreferences alloc]init];
    configuration.preferences.minimumFontSize = 30;
    configuration.preferences.javaScriptEnabled = YES;
    configuration.processPool = [[WKProcessPool alloc]init];
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    _webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configuration];
    _webView.translatesAutoresizingMaskIntoConstraints = NO;
    _webView.allowsBackForwardNavigationGestures = YES;
    [_webView.scrollView setDecelerationRate:1.0f];
    _webView.opaque = NO;
    _webView.scrollView.delegate = self;

    id scrollDelegate = _webView.scrollView.delegate;
    _webView.scrollView.delegate = nil;
    _webView.scrollView.delegate = scrollDelegate;
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    _webView.backgroundColor = [EQXColor colorWithHexString:@"#f4f4f4"];
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    [_webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.translatesAutoresizingMaskIntoConstraints = NO;
    backBtn.backgroundColor = [UIColor clearColor];
    backBtn.alpha = 0.5f;
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30.0f];
    [backBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [backBtn autoSetDimensionsToSize:CGSizeMake(50.0f, 50.0f)];
    
    UIButton *forwardBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    forwardBtn.translatesAutoresizingMaskIntoConstraints = NO;
    forwardBtn.transform = CGAffineTransformMakeRotation(M_PI);
    forwardBtn.backgroundColor = [UIColor clearColor];
    forwardBtn.alpha = 0.5f;
    [forwardBtn addTarget:self action:@selector(forwardBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [forwardBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.view addSubview:forwardBtn];
    [forwardBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30.0f];
    [forwardBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [forwardBtn autoSetDimensionsToSize:CGSizeMake(50.0f, 50.0f)];
    
    [_webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://hit-alibaba.github.io/interview/"]]];
}
- (void)backBtnClicked:(UIButton *)button{
    if (_webView.canGoBack) {
        [_webView goBack];
    }
}
- (void)forwardBtnClicked:(UIButton *)button{
    if (_webView.canGoForward) {
        [_webView goForward];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.navigationController.navigationBarHidden&&scrollView.contentOffset.y - _currentOffsetY > 10.0f) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self.tabBarController.tabBar setHidden:YES];
    }else if(self.navigationController.navigationBarHidden&&scrollView.contentOffset.y - _currentOffsetY < -10.0f){
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.tabBarController.tabBar setHidden:NO];
    }
    _currentOffsetY = scrollView.contentOffset.y;
}
#pragma mark - WKNavigationDelegate、WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
