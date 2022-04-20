//
//  NewsCellWithDesc.m
//  RSSReader
//
//  Created by Vladislav Suslov on 3.04.22.
//

#import "NewsCellWithDesc.h"


@interface NewsCellWithDesc ()
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *descLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;


@end

@implementation NewsCellWithDesc


- (void)setupWith:(NewsModel*)model {
    _titleLabel.text = model.title;
    _dateLabel.text = model.dateString;
    _descLabel.text = model.descInfo;
}

+ (NSString *)identifier {
    return @"kNewsCellWithDesc";
}

- (void)dealloc {
    [_titleLabel release];
    [_descLabel release];
    [_dateLabel release];
    [super dealloc];
}
@end
