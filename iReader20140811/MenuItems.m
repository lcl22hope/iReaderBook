//
//  MenuItems.m
//  TestFootTrace
//
//  Created by lcl on 17/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "MenuItems.h"
#import "UtilityHeaders.h"


@interface MenuItems()
@property (nonatomic,strong) NSString* myLove;
@property (nonatomic,strong) NSString* myHistory;
@property (nonatomic,strong) NSString* define;
@end

@implementation MenuItems


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myLove = @"我的最爱";
        self.myHistory = @"我的历史";
        self.define = @"自定义分类";
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetRGBStrokeColor(context, 23.0/255.0, 50.0/255.0, 77.0/255.0, 1.0);
    CGContextAddRect(context, CGRectMake(0, 0, 60, 80));
    [_myLove drawInRect:CGRectMake( btn_padding, (btn_padding + btn_hight)/2.0, btn_width, btn_hight) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
    [_myHistory drawInRect:CGRectMake(btn_padding, btn_padding*2 + btn_hight + btn_hight/4.0 , btn_width, btn_hight) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
    CGContextAddRect(context,CGRectMake(btn_padding, btn_padding*3 + btn_hight*2 , btn_width, btn_hight));
    [_define drawInRect:CGRectMake(btn_padding + 1, btn_padding*3 + btn_hight*2 + btn_hight/4.0 , btn_width - 2, btn_hight -2) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:8]}];
    CGContextDrawPath(context, kCGPathStroke);
    
}



@end
