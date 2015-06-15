//
//  commentViewINDetail.m
//  iReader20140811
//
//  Created by lcl on 19/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "commentViewINDetail.h"

@implementation commentViewINDetail

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.comment];
        [self addSubview:self.avator];
        [self addSubview:self.name];
        [self addSubview:self.date];
        [self addSubview:self.likeBtn];
        [self addSubview:self.likeCount];
        [self addSubview:self.commentBtn];
        [self addSubview:self.commentCount];
    }
    return self;
}

-(UILabel*)comment
{
    if (!_comment) {
        _comment = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 140)];
        _comment.textAlignment = NSTextAlignmentCenter;
        _comment.font = [UIFont systemFontOfSize:15];
        _comment.numberOfLines = 0;
        _comment.layer.borderWidth = 2;
        _comment.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _comment;
}

-(UIImageView*)avator
{
    if (!_avator) {
        CGFloat x = CGRectGetMinX(_comment.frame) - 20;
        CGFloat y = 0;
        _avator = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 40, 40)];
        _avator.layer.cornerRadius = 20;
        _avator.layer.masksToBounds = YES;
        _avator.layer.borderColor = [UIColor whiteColor].CGColor;
        _avator.layer.borderWidth = 2;
    }
    return _avator;
}

-(UILabel*)name
{
    if (!_name) {
        CGFloat x = CGRectGetMaxX(_avator.frame);
        CGFloat y = 0;
        _name = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 100, 20)];
        _name.textColor = [UIColor grayColor];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = [UIFont systemFontOfSize:15];
    }
    return _name;
}

-(UILabel*)date
{
    if (!_date) {
        CGFloat x = CGRectGetMaxX(_comment.frame) - 100;
        CGFloat y = 0;
        _date = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 100, 20)];
        _date.textColor = [UIColor grayColor];
        _date.textAlignment = NSTextAlignmentRight;
        _date.font = [UIFont systemFontOfSize:10];
    }
    return _date;
}

-(UIButton*)likeBtn
{
    if (!_likeBtn) {
        CGFloat x = CGRectGetMaxX(_comment.frame) - 110;
        CGFloat y = CGRectGetMaxY(_comment.frame) + 2;
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setBackgroundImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
        _likeBtn.frame = CGRectMake(x, y, 30, 20);
//        _likeBtn.backgroundColor = [UIColor grayColor];
    }
    return _likeBtn;
}

-(UILabel*)likeCount
{
    if (!_likeCount) {
        CGFloat x = CGRectGetMaxX(_likeBtn.frame);
        CGFloat y = CGRectGetMaxY(_comment.frame) + 2 ;
        _likeCount = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 20, 20)];
        _likeCount.textAlignment = NSTextAlignmentCenter;
        _likeCount.font = [UIFont systemFontOfSize:15];
    }
    return _likeCount;
}

-(UIButton*)commentBtn
{
    if (!_commentBtn) {
        CGFloat x = CGRectGetMaxX(_likeCount.frame);
        CGFloat y = CGRectGetMaxY(_comment.frame) + 2;
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setBackgroundImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
        _commentBtn.frame = CGRectMake(x, y, 40, 20);
//        _commentBtn.backgroundColor = [UIColor grayColor];
    }
    return _commentBtn;
}

-(UILabel*)commentCount
{
    if (!_commentCount) {
        CGFloat x = CGRectGetMaxX(_commentBtn.frame);
        CGFloat y = CGRectGetMaxY(_comment.frame) + 2;
        _commentCount = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 20, 20)];
        _commentCount.textAlignment = NSTextAlignmentCenter;
        _commentCount.font = [UIFont systemFontOfSize:15];
    }
    return _commentCount;
}


@end
