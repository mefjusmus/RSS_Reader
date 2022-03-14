//
//  ParseHelper.h
//  RSSReader
//
//  Created by Vladislav Suslov on 5.03.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParserHelper : NSObject

+ (NSArray *)getArrayInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSDictionary *)getDictionaryInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSInteger)getIntValueFromStringInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSInteger)getBOOLValueFromStringInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSString *)getStringInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSString *)getUrlInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSDate *)getDateFromStringInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSDate *)getDateFromUnixFormatStringInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSNumber *)getFloatNumberFromStringInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSNumber *)getBooleanInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSNumber *)getNumberInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSNumber *)getLongLongNumberInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
