//
//  NewsCell.m
//  RSSReader
//
//  Created by Vladislav Suslov on 7.03.22.
//

#import "NewsCell.h"


@interface NewsCell ()
@property (retain, nonatomic) NewsModel* model;

@end

@implementation NewsCell

- (void)setupWith:(NewsModel*)model {
    _model = model;
    _titleLabel.text = model.title;
}

+ (NSString *)identifier {
    return @"kNewsCell";
}

- (IBAction)buttonDidTap:(UIButton *)sender {
    if (_model) {
        [_delegate expandNewsWith:_model];
    }
}

- (void)dealloc {
    [_titleLabel release];
    [super dealloc];
}
@end
