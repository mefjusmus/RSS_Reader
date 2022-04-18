//
//  WebViewController.h
//  RSSReader
//
//  Created by Vladislav Suslov on 4.04.22.
//

#import <UIKit/UIKit.h>
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (retain, nonatomic) WKWebView *webView;
@property (retain, nonatomic) NSURL *link;
@property (retain, nonatomic) UIProgressView *progressView;

-(instancetype) initWithLink: (NSURL *) link;

@end

NS_ASSUME_NONNULL_END
