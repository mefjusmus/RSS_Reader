//
//  NewsModel.m
//  RSSReader
//
//  Created by Vladislav Suslov on 3.03.22.
//

#import "NewsModel.h"
#import "ParserHelper.h"

@interface NewsModel()

@property (copy, nonatomic, readwrite) NSString *title;
@property (copy, nonatomic, readwrite) NSURL *link;
@property (copy, nonatomic, readwrite) NSString *descInfo;
@property (copy, nonatomic, readwrite) NSDate *publicationDate;
@property (copy, nonatomic, readwrite) NSString *dateString;

@end

@implementation NewsModel



-(instancetype)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    
    if (self) {
        _title = [[[ParserHelper getStringInDictionary:dictionary forKey:@"title"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] copy];
        _link = [[NSURL URLWithString:[ParserHelper getUrlInDictionary:dictionary forKey:@"link"]] copy];
        _publicationDate = [[ParserHelper getDateFromStringInDictionary:dictionary forKey:@"pubDate"] copy];
        _descInfo = [[[ParserHelper getStringInDictionary:dictionary forKey:@"description"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]copy];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd 'at' HH:mm";
        _dateString = [[dateFormatter stringFromDate:_publicationDate] copy];
        [dateFormatter release];
    }
    
    return self;
}

- (void)dealloc {
    [_title release];
    _title = nil;
    [_link release];
    _link = nil;
    [_publicationDate release];
    _publicationDate = nil;
    [_dateString release];
    _dateString = nil;
    [_descInfo release];
    _descInfo = nil;
    
    [super dealloc];
}

@end
