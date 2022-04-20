
//  ParseHelper.m
//  RSSReader

//  Created by Vladislav Suslov on 5.03.22.


#import "ParserHelper.h"

#define kSlash @"\\/"

@implementation ParserHelper


+ (NSString *)getStringInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key
{
    if ([[dictionary objectForKey:key] isKindOfClass:[NSString class]]) {
        return [dictionary objectForKey:key];
    }
    return [NSString string];
}

+ (NSString *)getUrlInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key
{
    NSString * _string = [[[self getStringInDictionary: dictionary forKey: key] stringByReplacingOccurrencesOfString:kSlash withString:@"/"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return _string;
}

+ (NSDate *)getDateFromStringInDictionary:(NSDictionary *) dictionary forKey:(NSString *) key {
    NSString * _string = [dictionary objectForKey:key];
    if ([_string isKindOfClass:[NSString class]]) {
        NSDateFormatter * _dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
        [_dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
        NSDate * _date = [_dateFormatter dateFromString:_string];
        return _date;
    }
    return nil;
}

+ (NSString *)getDateStringFromStringInDictionary:(NSDictionary *) dictionary forKey: (NSString *)key {
    NSDate * _date = [self getDateFromStringInDictionary: dictionary forKey:key];
    if ([_date isKindOfClass:[NSDate class]]) {
        NSDateFormatter *_dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
        [_dateFormatter setDateFormat:@"EEE, dd MMM yyyy 'at' HH:mm"];
        NSString *_stringDate = [_dateFormatter stringFromDate:_date];
        return _stringDate;
    }
    return nil;
}

@end
