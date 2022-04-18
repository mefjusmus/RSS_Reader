//
//  RssParser.h
//  RSSReader
//
//  Created by Vladislav Suslov on 5.03.22.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"


NS_ASSUME_NONNULL_BEGIN

//@protocol ShowAlertDelegate;

@protocol RssParserProtocol <NSObject>

- (void)parseWithCompletionHandler: (void (^)(NSArray<NewsModel*>*, NSError *)) completion;

@end

@protocol SendErrorDelegate <NSObject>

- (void) sendErrorWithMessage: (NSString * ) message;

@end

@interface RssXMLParser : NSObject <NSXMLParserDelegate, RssParserProtocol>

@property (weak, nonatomic) id <SendErrorDelegate> alertDelegate;

@end

NS_ASSUME_NONNULL_END
