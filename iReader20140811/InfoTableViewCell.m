//
//  InfoTableViewCell.m
//  iReader20140811
//
//  Created by lcl on 12/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "InfoTableViewCell.h"
#import "Masonry.h"

@interface InfoTableViewCell()<UITextFieldDelegate>

@end

@implementation InfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setLayoutCustom];
    }
    return self;
}

#pragma mark - layout
-(void)setLayoutCustom{
    [self.container addSubview:self.title];
    [_container addSubview:self.subTitle];
    //  layout
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_container.mas_left).offset(50);
        make.centerY.equalTo(_container.mas_centerY).offset(0);
    }];
    
    [_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_container.mas_right).offset(-100);
        make.centerY.equalTo(_container.mas_centerY).offset(0);
    }];
}

#pragma mark - property getter
-(UILabel*)title{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.font = [UIFont boldSystemFontOfSize:25];
        _title.textColor = [UIColor darkTextColor];
    }
    return _title;
}


-(UIView*)container{
    
    if (!_container) {
//2.     container
        CGFloat w = CGRectGetWidth([[UIScreen mainScreen] bounds]);
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 44)];
    }
    return _container;
}

-(UILabel*)subTitle{
    if (!_subTitle) {
//3.    subTitle
        _subTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitle.font = [UIFont boldSystemFontOfSize:15.0f];
        _subTitle.textColor = [UIColor darkGrayColor];
        _subTitle.textAlignment = NSTextAlignmentLeft;
        _subTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _subTitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

@end
