//
//  RssParser.m
//  RSSReader
//
//  Created by Vladislav Suslov on 5.03.22.
//

#import "RssParser.h"


@implementation RssParser

@synthesize marrXMLData;
@synthesize mstrXMLString;
@synthesize mdictXMLPart;
@synthesize completion;

- (void)startParsing {
    NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://feeds.bbci.co.uk/news/video_and_audio/world/rss.xml"]];
    [xmlparser setDelegate: self];
    [xmlparser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"rss"]) {
        marrXMLData = [[[NSMutableArray alloc] init] autorelease];
    }
    if ([elementName isEqualToString:@"item"]) {
        mdictXMLPart = [[[NSMutableDictionary alloc] init] autorelease];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (completion) {
        NSMutableArray *newsArray = [NSMutableArray arrayWithCapacity:[marrXMLData count]];
        [marrXMLData enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            NewsModel *mapObj = [[NewsModel alloc] initWithDictionary:obj];
            [newsArray addObject:mapObj];
        }];
        completion(newsArray);
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!mstrXMLString) {
        mstrXMLString = [[NSMutableString alloc] initWithString: string];
        NSLog(@"mstrXMLString retain count = %ld", [mstrXMLString retainCount]);
        //            [mstrXMLString release];
    }
    else {
        [mstrXMLString appendString: string];
        NSLog(@"mstrXMLString retain count = %ld", [mstrXMLString retainCount]);
    }
    NSLog(@"mstrXMLString retain count = %ld", [mstrXMLString retainCount]);
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString: @"title"]
        || [elementName isEqualToString: @"pubDate"]
        || [elementName isEqualToString: @"link"]) {
        [mdictXMLPart setObject: mstrXMLString forKey: elementName];
    }
    if ([elementName isEqualToString:@"item"]) {
        [marrXMLData addObject: mdictXMLPart];
    }
    mstrXMLString = nil;
    //    [mstrXMLString release];
    //    [mdictXMLPart release];
    //    [marrXMLData release];
}

- (void)dealloc {
    [mstrXMLString release];
    [marrXMLData release];
    [mdictXMLPart release];
    [completion release];
    
    [super dealloc];
}

@end
