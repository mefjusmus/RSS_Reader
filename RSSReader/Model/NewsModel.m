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
@property (copy, nonatomic, readwrite) NSDate *publicationDate;
@property (copy, nonatomic, readwrite) NSString *dateString;

@end

@implementation NewsModel



-(instancetype)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    
    if (self) {
        self.title = [[ParserHelper getStringInDictionary:dictionary forKey:@"title"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.link = [NSURL URLWithString:[ParserHelper getUrlInDictionary:dictionary forKey:@"link"]];
        self.publicationDate = [ParserHelper getDateFromStringInDictionary:dictionary forKey:@"pubDate"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd 'at' HH:mm";
        self.dateString = [dateFormatter stringFromDate:_publicationDate];
    }
    
    return self;
}

@end
