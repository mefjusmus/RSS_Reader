//
//  NewsCell.m
//  RSSReader
//
//  Created by Vladislav Suslov on 7.03.22.
//

#import "NewsCell.h"




@interface NewsCell ()

//@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
//@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
//@property (retain, nonatomic) IBOutlet UILabel *descLabel;
//@property (retain, nonatomic) IBOutlet UIButton *annotationButton;

@end


@implementation NewsCell



- (void)setupWith:(NewsModel*)model {
    _titleLabel.text = model.title;
//    _dateLabel.text = model.dateString;
//    _descLabel.text = model.descInfo;
}

+ (NSString *)identifier {
    return @"kNewsCell";
}

- (IBAction)buttonDidTap:(UIButton *)sender {
    [_delegate buttonDidTappedAtIndex:sender.tag];
}


- (void)dealloc {
    [_titleLabel release];
    [_dateLabel release];
    [_descLabel release];
    [_annotationButton release];
    [super dealloc];
}
@end
