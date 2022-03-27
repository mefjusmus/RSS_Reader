//
//  ViewController.h
//  RSSReader
//
//  Created by Vladislav Suslov on 3.03.22.
//

#import <UIKit/UIKit.h>
#import "RssXMLParser.h"

@protocol RssParserProtocol;

typedef void (^ParserCompletion)(NSArray<NewsModel*>*, NSError *);

@interface MainViewController : UIViewController <SendErrorDelegate>

- (instancetype)initWithParser: (id<RssParserProtocol>) parser;

@end

