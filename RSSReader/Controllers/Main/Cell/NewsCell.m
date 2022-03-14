//
//  NewsCell.m
//  RSSReader
//
//  Created by Vladislav Suslov on 7.03.22.
//

#import "NewsCell.h"


@interface NewsCell ()

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;

@end


@implementation NewsCell

-(void)setupWith:(NewsModel*)model {
    _titleLabel.text = model.title;
    _dateLabel.text = model.dateString;
}

+ (NSString *)identifier {
    return @"kNewsCell";
}

- (void)dealloc {
    [_titleLabel release];
    [_dateLabel release];
    [super dealloc];
}
@end
