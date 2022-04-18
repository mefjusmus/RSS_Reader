//
//  NewsModel.h
//  RSSReader
//
//  Created by Vladislav Suslov on 3.03.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsModel : NSObject

@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) NSURL *link;
@property (copy, nonatomic, readonly) NSString *descInfo;
@property (copy, nonatomic, readonly) NSDate *publicationDate;
@property (copy, nonatomic, readonly) NSString *dateString;
@property (assign, nonatomic) BOOL isExpand;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;



@end

NS_ASSUME_NONNULL_END
