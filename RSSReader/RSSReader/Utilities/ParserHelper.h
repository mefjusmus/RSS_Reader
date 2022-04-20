//
//  ParseHelper.h
//  RSSReader
//
//  Created by Vladislav Suslov on 5.03.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParserHelper : NSObject


+ (NSString *)getStringInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSString *)getUrlInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSDate *)getDateFromStringInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSString *)getDateStringFromStringInDictionary:(NSDictionary *) dictionary forKey: (NSString *)key;

@end

NS_ASSUME_NONNULL_END
