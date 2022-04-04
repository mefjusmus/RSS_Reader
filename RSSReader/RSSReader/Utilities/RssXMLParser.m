//
//  RssParser.m
//  RSSReader
//
//  Created by Vladislav Suslov on 5.03.22.
//

#import "RssXMLParser.h"
#import "MainViewController.h"

@interface RssXMLParser () 

@property (nonatomic, retain) NSMutableArray *marrXMLData;
@property (nonatomic, retain) NSMutableString *mstrXMLString;
@property (nonatomic, retain) NSMutableDictionary *mdictXMLPart;
@property (nonatomic, copy) void (^completion)(NSArray<NewsModel*>*, NSError *);
@property (nonatomic, retain) NSXMLParser *parser;

@end

@implementation RssXMLParser

- (void)parseWithCompletionHandler:(ParserCompletion) completion 
{
    self.completion = completion;

    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: @"https://www.jpl.nasa.gov/feeds/news"]
                                         options: NSDataReadingUncached
                                         error: &error];
    if (error) {
        [_alertDelegate sendErrorWithMessage: @"Something went wrong! Check your connection"];
    }
    _parser = [[NSXMLParser alloc] initWithData: data];
    _parser.delegate = self;
    
    [_parser parse];
    error = [_parser parserError];
    [_parser release];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"rss"]) {
        self.marrXMLData = [[[NSMutableArray alloc] init] autorelease];
    }
    if ([elementName isEqualToString:@"item"]) {
        self.mdictXMLPart = [[[NSMutableDictionary alloc] init] autorelease];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!self.mstrXMLString) {
        self.mstrXMLString = [[[NSMutableString alloc] initWithString: string] autorelease];
    }
    else {
        [self.mstrXMLString appendString: string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString: @"title"]
        || [elementName isEqualToString: @"pubDate"]
        || [elementName isEqualToString: @"link"]
        || [elementName isEqualToString:@"description"]) {
        [self.mdictXMLPart setObject: self.mstrXMLString forKey: elementName];
    }
    if ([elementName isEqualToString:@"item"]) {
        [self.marrXMLData addObject: self.mdictXMLPart];
    }
    self.mstrXMLString = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (_completion) {
        NSMutableArray *newsArray = [NSMutableArray arrayWithCapacity:[self.marrXMLData count]];
        [self.marrXMLData enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            NewsModel *mapObj = [[[NewsModel alloc] initWithDictionary:obj] autorelease];
            [newsArray addObject:mapObj];
        }];
        self.completion(newsArray, nil);
    }
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
  
    NSString *info = [NSString stringWithFormat:
                      @"Error %ld, Description: %@, Line: %ld, Column: %ld",
                      [parseError code],
                      [parseError localizedDescription],
                      [parser lineNumber],
                      [parser columnNumber]];
    [self.alertDelegate sendErrorWithMessage: info];
}




- (void)dealloc {
    [_mstrXMLString release];
    _mstrXMLString = nil;
    [_marrXMLData release];
    _marrXMLData = nil;
    [_mdictXMLPart release];
    _mdictXMLPart = nil;
    [_completion release];
    _completion = nil;
    
    [super dealloc];
}

@end
