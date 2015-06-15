//
//  WorkDetailHeaderView.m
//  iReader20140811
//
//  Created by lcl on 19/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "WorkDetailHeaderView.h"

#define padding_work 10


@implementation WorkDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.bookCover];
        [self addSubview:self.bookTitle];
        [self addSubview:self.author];
        [self addSubview:self.price];
        [self addSubview:self.size];
        [self addSubview:self.loveCountView];
        [self addSubview:self.bookDetail];
    }
    return self;
}


-(UIImageView*)bookCover
{
    if (!_bookCover) {
        CGFloat x = padding_work;
        CGFloat y = padding_work;
        CGFloat w = 80;
        CGFloat h = 120;
        _bookCover = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _bookCover.layer.borderWidth = 2;
        _bookCover.layer.borderColor = [UIColor whiteColor].CGColor;
        _bookCover.layer.cornerRadius = 2;
        _bookCover.layer.masksToBounds = YES;
    }
    return _bookCover;
}

-(UILabel*)bookTitle
{
    if (!_bookTitle) {
        CGFloat x = CGRectGetMaxX(_bookCover.frame) + padding_work / 2;
        CGFloat y = CGRectGetMinY(_bookCover.frame);
        _bookTitle = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 200, 20)];
        _bookTitle.text = @"题目: ";
        _bookTitle.font = [UIFont boldSystemFontOfSize:15];
        _bookTitle.textAlignment = NSTextAlignmentLeft;
        _bookTitle.textColor = [UIColor darkTextColor];
    }
    return _bookTitle;
}

-(UILabel*)author
{
    if (!_author) {
        CGFloat x = CGRectGetMinX(_bookTitle.frame);
        CGFloat y = CGRectGetMaxY(_bookTitle.frame) + 5;
        _author = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 200, 20)];
        _author.text = @"作者: ";
        _author.font = [UIFont systemFontOfSize:15];
        _author.textAlignment = NSTextAlignmentLeft;
        _author.textColor = [UIColor grayColor];
    }
    return _author;
}

-(UILabel*)price
{
    if (!_price) {
        CGFloat x = CGRectGetMinX(_bookTitle.frame);
        CGFloat y = CGRectGetMaxY(_author.frame) + 5;
        _price = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 200, 20)];
        _price.text = @"价格: ";
        _price.font = [UIFont systemFontOfSize:15];
        _price.textAlignment = NSTextAlignmentLeft;
        _price.textColor = [UIColor grayColor];
    }
    return _price;
}

-(UILabel*)size
{
    if (!_size) {
        CGFloat x = CGRectGetMinX(_bookTitle.frame);
        CGFloat y = CGRectGetMaxY(_price.frame) + 5;
        _size = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 200, 20)];
        _size.text = @"大小: ";
        _size.font = [UIFont systemFontOfSize:15];
        _size.textAlignment = NSTextAlignmentLeft;
        _size.textColor = [UIColor grayColor];
    }
    return _size;
}

-(LikeCountView*)loveCountView
{
    if (!_loveCountView) {
        CGFloat x = CGRectGetMinX(_bookTitle.frame);
        CGFloat y = CGRectGetMaxY(_size.frame) + 5 ;
        _loveCountView = [[LikeCountView alloc] initWithFrame:CGRectMake(x, y, 200, 20)];
    }
    return _loveCountView;
}

-(UILabel*)bookDetail
{
    if (!_bookDetail) {
        CGFloat x = padding_work;
        CGFloat y = CGRectGetMaxY(_bookCover.frame) + 5;
        _bookDetail = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 320-2*padding_work, 60)];
        _bookDetail.numberOfLines = 0;
        _bookDetail.font = [UIFont systemFontOfSize:13];
        _bookDetail.textAlignment = NSTextAlignmentLeft;
//        [_bookDetail sizeToFit];
    }
    return _bookDetail;
}



@end
