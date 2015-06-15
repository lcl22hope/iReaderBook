//
//  CLAlbumShareBookTableViewBookCell.m
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "CLAlbumShareBookTableViewCell.h"

@interface CLAlbumShareBookTableViewCell()
@end

@implementation CLAlbumShareBookTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self baseSetup];
    }
    return self;
}

-(void)baseSetup
{
//    self.imageView.image = [UIImage imageNamed:@"1"];
//    self.textLabel.text = @"法国中尉的女人";
//    self.detailTextLabel.text = @"世人眼中堕落女人萨拉，抑郁成瘾，生活在保守的英国小镇上，大家都叫她“法国中尉的女人”";
    CGFloat ImgWidth = CGRectGetWidth(self.frame)/ 3.0;
    _sharebookImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ImgWidth, CGRectGetHeight(self.frame))];
    CGFloat BookNameWidth = (CGRectGetWidth(self.frame) - ImgWidth) / 2.0;
    CGFloat BookNameHeight = CGRectGetHeight(self.frame)/2.0;
    CGFloat BookNameX = _sharebookImage.frame.size.width + 5.0;
    _shareBookName = [[UILabel alloc] initWithFrame:CGRectMake(BookNameX, 0, BookNameWidth, BookNameHeight)];
    _shareBookName.textColor = [UIColor whiteColor];
    _shareBookName.textAlignment = NSTextAlignmentLeft;
    _shareBookName.font = [UIFont boldSystemFontOfSize:(BookNameHeight-2.0)];
    CGFloat BookAuthorWidth = BookNameWidth - 5.0;
    CGFloat BookAuthorHeight = BookNameHeight / 2.0;
    CGFloat BookAuthorX = ImgWidth + BookNameWidth + 5.0;
    _shareBookAuthor = [[UILabel alloc] initWithFrame:CGRectMake(BookAuthorX, BookNameHeight/2.0, BookAuthorWidth, BookAuthorHeight)];
    _shareBookAuthor.textColor = [UIColor whiteColor];
    _shareBookAuthor.textAlignment = NSTextAlignmentLeft;
    _shareBookAuthor.font = [UIFont boldSystemFontOfSize:(BookAuthorHeight-1.0)];
    CGFloat BookDescriptionWidth = CGRectGetWidth(self.frame) - ImgWidth;
    _shareBookDescription = [[UILabel alloc] initWithFrame:CGRectMake(BookNameX, BookNameHeight+2.0, BookDescriptionWidth , CGRectGetHeight(self.frame)/2.0)];
    _shareBookDescription.textColor = [UIColor whiteColor];
    _shareBookDescription.textAlignment = NSTextAlignmentLeft;
    _shareBookDescription.font = [UIFont boldSystemFontOfSize:(BookAuthorHeight-1.0)];
    _shareBookDescription.numberOfLines = 0;
    [self addSubview:_sharebookImage];
    [self addSubview:_shareBookName];
    [self addSubview:_shareBookAuthor];
    [self addSubview:_shareBookDescription];
}

@end
