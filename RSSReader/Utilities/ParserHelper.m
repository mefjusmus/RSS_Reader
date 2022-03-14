//
//  ParseHelper.m
//  RSSReader
//
//  Created by Vladislav Suslov on 5.03.22.
//

#import "ParserHelper.h"

#define kSlash @"\\/"

@implementation ParserHelper

+ (NSNumber *)getNumberInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key
{
    if ([[dictionary objectForKey:key] isKindOfClass:[NSNumber class]]) {
        return [dictionary objectForKey:key];
    }
    return [NSNumber numberWithInt:-1];
}

+ (NSNumber *)getBooleanInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key
{
    id _something = [dictionary objectForKey:key];
    if ([NSStringFromClass([_something class]) isEqualToString:@"NSCFBoolean"]) {
        NSNumber * _number = (NSNumber *)[dictionary objectForKey:key];
        return _number;
    }
    return [NSNumber numberWithBool:NO];
    
}

+ (NSNumber *)getLongLongNumberInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key
{
    id _something = [dictionary objectForKey:key];
    if (_something)
    {
        if ( [_something isKindOfClass:[NSNumber class]]) {
            return _something;
        }
        else
        {
            if ( [_something isKindOfClass:[NSString class]])
            {
                return [NSNumber numberWithLongLong:[_something longLongValue]];
            }
        }
    }
    return [NSNumber numberWithInt:-1];
    
}

+ (NSArray *)getArrayInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key
{
    if ([[dictionary objectForKey:key] isKindOfClass:[NSArray class]]) {
        return [dictionary objectForKey:key];
    }
    return [NSArray array];
}

+ (NSDictionary *)getDictionaryInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key
{
    if ([[dictionary objectForKey:key] isKindOfClass:[NSDictionary class]]) {
        return [dictionary objectForKey:key];
    }
    return [NSDictionary dictionary];
}

+ (NSInteger)getIntValueFromStringInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key
{
    if ([[dictionary objectForKey:key] isKindOfClass:[NSString class]]) {
        return [[dictionary objectForKey:key] intValue];
    }
    return -1;
}

+ (NSNumber *)getFloatNumberFromStringInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key
{
    return [NSNumber numberWithFloat:[[dictionary objectForKey:key] floatValue]];
}

+ (NSInteger)getBOOLValueFromStringInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key
{
    if ([self getIntValueFromStringInDictionary: dictionary forKey: key] == 1) {
        return YES;
    }
    return NO;
}

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
        NSDateFormatter * _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
        [_dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
        NSDate * _date = [_dateFormatter dateFromString:_string];
        return _date;
    }
    return nil;
}

+ (NSDate *)getDateFromUnixFormatStringInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key {
    NSString * _string = [dictionary objectForKey:key];
    if ([_string isKindOfClass:[NSString class]] || [_string isKindOfClass:[NSNumber class]]) {
        NSTimeInterval _intervalSince1970 = (NSTimeInterval)[_string doubleValue];
        NSDate * _date = [NSDate dateWithTimeIntervalSince1970:_intervalSince1970];
        return _date;
    }
    return nil;
}

@end
