//
//  NewsCellWithDesc.h
//  RSSReader
//
//  Created by Vladislav Suslov on 3.04.22.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsCellWithDesc : UITableViewCell

+(NSString *)identifier;

-(void)setupWith:(NewsModel*)model;

@end

NS_ASSUME_NONNULL_END
