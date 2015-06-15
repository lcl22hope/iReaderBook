//
//  LikeCountView.m
//  iReader20140811
//
//  Created by lcl on 19/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "LikeCountView.h"

@implementation LikeCountView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.loveHeart];
        [self addSubview:self.loveCount];
    }
    return self;
}

-(UIImageView*)loveHeart
{
    if (!_loveHeart) {
        _loveHeart = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _loveHeart.image = [UIImage imageNamed:@"like"];
    }
    return _loveHeart;
}

-(UILabel*)loveCount
{
    if (!_loveCount) {
        _loveCount = [[UILabel alloc] initWithFrame:CGRectMake(23, 0, 200, 20)];
        _loveCount.font = [UIFont boldSystemFontOfSize:15];
        _loveCount.textColor = [UIColor redColor];
        _loveCount.textAlignment = NSTextAlignmentLeft;
    }
    return _loveCount;
}



@end
