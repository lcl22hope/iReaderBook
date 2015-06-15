//
//  BtnWholeContent.m
//  TestAutolayout
//
//  Created by lcl on 3/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "BtnWholeContent.h"

@implementation BtnWholeContent

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    CGRect frame = self.imageView.frame;
////    frame = CGRectMake(truncf((self.bounds.size.width - frame.size.width) / 2), 0.0f, frame.size.width, frame.size.height);
//    frame.origin.y = 0;
//    frame.origin.x = self.frame.size.width - frame.size.width / 2;
//    self.imageView.frame = frame;
//    
//    CGRect titleLabelFrame = self.titleLabel.frame;
//    CGSize labelSize = [self.titleLabel.text sizeWithFont:self. titleLabel.font
//                                        constrainedToSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)
//                                            lineBreakMode:NSLineBreakByWordWrapping];
//    titleLabelFrame.size.width = labelSize.width;
//    titleLabelFrame.size.height = labelSize.height;
//    titleLabelFrame.origin.x = (self.frame.size.width / 2) - (labelSize.width / 2);
//    titleLabelFrame.origin.y = self.imageView.frame.origin.y + self.imageView.frame.size.height;
//    self.titleLabel.frame = titleLabelFrame;
//}

-(CGRect)backgroundRectForBounds:(CGRect)contentRect
{
    CGRect frame = [super backgroundRectForBounds:contentRect];
    frame.origin.x = 35;
    frame.size.width = 8;
//    NSLog(@"frame is %@",NSStringFromCGRect(frame));
    return frame;
}

//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    CGRect frame = [super imageRectForContentRect:contentRect];
//    frame.origin.x = CGRectGetMaxX(contentRect) - CGRectGetWidth(frame) -  self.imageEdgeInsets.right + self.imageEdgeInsets.left;
//    return frame;
//}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super titleRectForContentRect:contentRect];
    frame.origin.x = 2;
    return frame;
}

@end
