//
//  WebViewController.m
//  RSSReader
//
//  Created by Vladislav Suslov on 4.04.22.
//

#import "WebViewController.h"
#import <SafariServices/SafariServices.h>

typedef NS_ENUM(NSInteger, WebViewButtonType) {
    WebViewBack,
    WebViewForward,
    WebViewRefresh,
    WebViewStopDownload,
    WebViewGoToSafari
};

@interface WebViewController () <WKNavigationDelegate>

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
    //    _webView.UIDelegate = self;
    [self createToolBar];
    _progressView = [[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar] autorelease];
    [self.navigationController.navigationBar addSubview:_progressView];
    
    [_progressView.leadingAnchor constraintEqualToAnchor:self.navigationController.navigationBar.leadingAnchor].active = YES;
    [_progressView.trailingAnchor constraintEqualToAnchor:self.navigationController.navigationBar.trailingAnchor].active = YES;
    [_progressView.topAnchor constraintEqualToAnchor:self.navigationController.navigationBar.bottomAnchor].active = YES;
    [_progressView setTranslatesAutoresizingMaskIntoConstraints:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    _webView = [[[WKWebView alloc] initWithFrame: self.view.frame] autorelease];
    _webView.navigationDelegate = self;
    [_webView allowsBackForwardNavigationGestures];
    NSURLRequest *request = [NSURLRequest requestWithURL: _link];
    [_webView loadRequest: request];
    [self.view addSubview: _webView];
}

#pragma mark WKNavigationDelegate

- (void) webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [_progressView setHidden: false];
    [_progressView setProgress: 0.2 animated: true];
}

- (void) webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [_progressView setProgress: 1.f animated: true];
}

-(void) webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_progressView setHidden: true];
    [_progressView setProgress: 0.f];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [_progressView setHidden: true];
}


- (void)createToolBar {
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace menu: nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage systemImageNamed:@"chevron.backward"]
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(didTapToolbarButton:)];
    [backButton setTag: WebViewBack];
    
    UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc]
                                      initWithImage:[UIImage systemImageNamed:@"chevron.forward"]
                                      style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(didTapToolbarButton:)];
    [forwardButton setTag: WebViewForward];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                      target:self
                                      action:@selector(didTapToolbarButton:)];
    [refreshButton setTag: WebViewRefresh];
    
    UIBarButtonItem *stopButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                   target:self
                                   action:@selector(didTapToolbarButton:)];
    [stopButton setTag: WebViewGoToSafari];
    
    UIBarButtonItem *safariButton = [[UIBarButtonItem alloc]
                                     initWithImage: [UIImage systemImageNamed:@"safari"]
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(didTapToolbarButton:)];
    [safariButton setTag: 1005];
    
    NSArray *buttons = [NSArray arrayWithObjects:backButton, spacer, forwardButton, spacer, refreshButton, spacer, stopButton, spacer, safariButton, nil];
    
    self.navigationController.toolbar.backgroundColor = [UIColor whiteColor];
    [self setToolbarItems: buttons];
    [self.navigationController.toolbar.layer setBackgroundColor: [UIColor whiteColor].CGColor];
    [self.navigationController setHidesBarsOnSwipe:true];
    [self.navigationController setToolbarHidden: false];
}

- (void) didTapToolbarButton: (UIBarButtonItem *) sender {
    switch (sender.tag) {
        case WebViewBack:
            [_webView goBack];
            break;
        case WebViewForward:
            [_webView goForward];
            break;
        case WebViewRefresh:
            [_webView reload];
            break;
        case WebViewStopDownload:
            [_webView stopLoading];
            break;
        case WebViewGoToSafari:
            [self loadInSafariBrowser];
            break;
        default:
            break;
    }
}

- (void)loadInSafariBrowser {
    SFSafariViewController *controller = [[SFSafariViewController alloc] initWithURL:_link];
    controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)dealloc {
    [_link release];
    [_progressView release];
    [_webView release];
    [super dealloc];
}
@end
