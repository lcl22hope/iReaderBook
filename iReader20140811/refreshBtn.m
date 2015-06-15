//
//  refreshBtn.m
//  TestUITableview
//
//  Created by lcl on 5/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "refreshBtn.h"

@implementation refreshBtn


-(CGRect)backgroundRectForBounds:(CGRect)contentRect
{
    CGRect frame = [super backgroundRectForBounds:contentRect];
    frame.origin.x = 2;
//    frame.size.width = 8;
    return frame;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super titleRectForContentRect:contentRect];
    frame.origin.x = 18;
    return frame;
}

@end
