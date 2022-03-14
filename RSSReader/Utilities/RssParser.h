//
//  RssParser.h
//  RSSReader
//
//  Created by Vladislav Suslov on 5.03.22.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RssParser : NSObject <NSXMLParserDelegate>

@property (nonatomic, retain) NSMutableArray *marrXMLData;
@property (nonatomic, retain) NSMutableString *mstrXMLString;
@property (nonatomic, retain) NSMutableDictionary *mdictXMLPart;
@property (nonatomic, copy) void (^completion)(NSArray<NewsModel*>*);

- (void)startParsing;

@end

NS_ASSUME_NONNULL_END
