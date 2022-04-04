//
//  WebViewController.m
//  RSSReader
//
//  Created by Vladislav Suslov on 4.04.22.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (instancetype) initWithLink:(NSURL *)link {
    self = [super init];
    if (self) {
        [_link retain];
        _link = link;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    _webView = [[WKWebView alloc] initWithFrame: self.view.frame];
    [_webView allowsBackForwardNavigationGestures];
    NSURLRequest *request = [NSURLRequest requestWithURL: _link];
    [_webView loadRequest: request];
    [self.view addSubview: _webView];
}


- (void)dealloc {
    [_link release];
    [_webView release];
    [super dealloc];
}
@end
