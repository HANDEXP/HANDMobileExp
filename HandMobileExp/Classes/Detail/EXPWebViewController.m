//
//  EXPWebViewController.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-6.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPWebViewController.h"

@interface EXPWebViewController (){
    UIBarButtonItem *_stopButton;
	UIBarButtonItem *_previousButton;
	UIBarButtonItem *_nextButton;
    UIBarButtonItem *_reloadButton;
}




@end

@implementation EXPWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithUrl:(NSString *)url title:(NSString *)title{
    self =  [self initWithNibName:nil bundle:nil];
    if(self){
        _url = url;
        _text = title;
    }
    
    return self;
}
#pragma  viewlife

- (void)viewDidLoad
{
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
     [self setToolbarItems:self.items animated:NO];
     [self.navigationController setToolbarHidden:NO animated:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];

   
    self.title  = _text;
    [self.view addSubview:_webView];
    
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma Setter Methods
-(void)setResourceBundleName:(NSString *)name{
    _resourceBundleName = name;
}



#pragma mark Getter Methods
-(NSArray *)items
{
    if (!_resourceBundleName) {
        [self setResourceBundleName:@"Settings"];
        
        
    }
    
   UIBarButtonItem *flexibleMargin = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *margin = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    UIImage *stopImg = [self imageNamed:@"stopButton" forBundleNamed:_resourceBundleName];
    UIImage *nextImg = [self imageNamed:@"nextButton" forBundleNamed:_resourceBundleName];
    UIImage *previousdImg = [self imageNamed:@"previousButton" forBundleNamed:_resourceBundleName];
    UIImage *refreshImg = [UIImage imageNamed:@"reloadButton"];
    
    _stopButton = [[UIBarButtonItem alloc] initWithImage:stopImg style:UIBarButtonItemStylePlain target:self action:@selector(stopWebView)];
    _previousButton = [[UIBarButtonItem alloc] initWithImage:previousdImg style:UIBarButtonItemStylePlain target:self action:@selector(backWebView)];
    _nextButton = [[UIBarButtonItem alloc] initWithImage:nextImg style:UIBarButtonItemStylePlain target:self action:@selector(forwardWebView)];
    _reloadButton =[[UIBarButtonItem alloc] initWithImage:refreshImg style:UIBarButtonItemStylePlain target:self action:@selector(reloadWebView)];

    NSMutableArray *items =  [NSMutableArray arrayWithObjects:flexibleMargin,_previousButton,flexibleMargin, _nextButton, flexibleMargin, _reloadButton, flexibleMargin, _stopButton, flexibleMargin,nil];
    
    
    return items;
}

#pragma private

- (UIImage *)imageNamed:(NSString *)imgName forBundleNamed:(NSString *)bundleName
{
    NSString *path = [NSString stringWithFormat:@"%@.bundle/images/%@",bundleName,imgName];
    return [UIImage imageNamed:path];
}

#pragma mark - WebViewController Methods

- (void)stopWebView
{
	[_webView stopLoading];

}

- (void)backWebView
{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}

- (void)forwardWebView
{
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}

- (void)reloadWebView
{
    [_webView reload];
}

#pragma mark - UIWebViewDelegate
-(void)showLoad:(BOOL)flag{
    if(flag){
        
           [MMProgressHUD  showWithStatus:@"loading"];
    }else{
        
        [MMProgressHUD dismiss];
    }
    
}

- (BOOL)webView:(UIWebView *)webview shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:
(UIWebViewNavigationType)navigationType
{
    _stopButton.enabled = YES;
    _reloadButton.enabled =NO;
    [self showLoad:true];
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webview
{

	
}

- (void)webViewDidFinishLoad:(UIWebView *)webview
{
    [self showLoad:false];
      _stopButton.enabled = NO;
    _reloadButton.enabled=YES;
}

- (void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error
{
    [self showLoad:false];
    _stopButton.enabled = NO;
    _reloadButton.enabled=YES;
}
@end
