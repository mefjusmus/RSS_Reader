//
//  NewsCell.h
//  RSSReader
//
//  Created by Vladislav Suslov on 7.03.22.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

NS_ASSUME_NONNULL_BEGIN
@class NewsCell;

@protocol ShowAnnotationForCellDelegate <NSObject>

- (void) buttonDidTappedAtIndex: (NSInteger) index;

@end


@interface NewsCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UILabel *descLabel;
@property (retain, nonatomic) IBOutlet UIButton *annotationButton;
@property (assign, nonatomic) id <ShowAnnotationForCellDelegate> delegate;

+(NSString *)identifier;

-(void)setupWith:(NewsModel*)model;

@end

NS_ASSUME_NONNULL_END
