//
//  UIButton+Position.m
//  TestAutolayout
//
//  Created by lcl on 3/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "UIButton+Position.h"

@implementation UIButton(ImageTitleCentering)

-(void) centerButtonAndImageWithSpacing:(CGFloat)spacing {
    self.imageEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing*2);
}

@end
