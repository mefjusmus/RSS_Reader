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
    [self createToolBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    _webView = [[WKWebView alloc] initWithFrame: self.view.frame];
    [_webView allowsBackForwardNavigationGestures];
    NSURLRequest *request = [NSURLRequest requestWithURL: _link];
    [_webView loadRequest: request];
    [self.view addSubview: _webView];
}

- (void) createToolBar {
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace menu: nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"lessthan"] menu:nil];
    UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"greaterthan"] menu:nil];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh menu:nil];
    UIBarButtonItem *stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop menu:nil];
    UIBarButtonItem *safariButton = [[UIBarButtonItem alloc] initWithImage: [UIImage systemImageNamed:@"safari"] menu:nil];
    NSArray *buttons = [NSArray arrayWithObjects:backButton, spacer, forwardButton, spacer, refreshButton, spacer, stopButton, spacer, safariButton, nil];
    [self setToolbarItems: buttons];
    [self.navigationController.toolbar.layer setBackgroundColor: [UIColor systemBackgroundColor].CGColor];
    [self.navigationController setToolbarHidden: false];
}


- (void)dealloc {
    [_link release];
    [_webView release];
    [super dealloc];
}
@end
