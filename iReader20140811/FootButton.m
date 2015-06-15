//
//  FootButton.m
//  TestFootTrace
//
//  Created by lcl on 16/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "FootButton.h"
#import "UtilityHeaders.h"
#import <math.h>


@interface FootButton()

@end

@implementation FootButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.arrowImgView.image = [UIImage imageNamed:@"left_arrow"];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:_arrowImgView];
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{

    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 23.0/255.0, 50.0/255.0, 77.0/255.0, 1.0);
    CGContextMoveToPoint(context,40,40);
    CGContextAddArc(context,40,40,40,-M_PI_2,M_PI_2,1);//重置currentPoint为圆心
    CGContextDrawPath(context, kCGPathFill);
//  CGContextDrawImage(context, CGRectMake(10, 30, 20, 20), _arrowImg.CGImage);

}


-(UIImageView*)arrowImgView
{
    if (!_arrowImgView) {
        _arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 20, 20)];
//        _arrowImgView.image = [UIImage imageNamed:@"left_arrow"];
    }
    return _arrowImgView;
}

@end
