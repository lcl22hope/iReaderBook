//
//  QuestionRefreshButton.m
//  TestTagAddViewAnimation
//
//  Created by lcl on 15/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//
#define rFontSize         (15.0f)
#define rFontType         @"Helvetica-Light"
#define rHeight            15.0f
#define rMargin           5.0f

#import "QuestionRefreshButton.h"

@implementation QuestionRefreshButton

- (id)initWithFrame:(CGRect)frame withColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
    
        self.btnColor = color;
        self.title = @"换一换";
    }
    return self;
}

- (CGSize)getBtnSize
{
    CGSize tSize = [self.title sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:rFontType size:rFontSize]}];
    return CGSizeMake(tSize.width, rHeight);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.refreshImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rHeight, rHeight)];
    _refreshImg.image = [UIImage imageNamed:@"freshInDetail"];
    [self addSubview:_refreshImg];
    
    CGSize tSize = [self.title sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:rFontType size:rFontSize]}];
    CGFloat title_x = CGRectGetWidth(self.refreshImg.frame) + rMargin;
    CGFloat title_y = [self getBtnSize].height / 2.0 - tSize.height/2.0;
    
    [self.title drawInRect:CGRectMake(title_x, title_y, tSize.width, tSize.height) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:rFontType size:rFontSize],NSForegroundColorAttributeName:self.btnColor}];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonRefresh:)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:recognizer];
}

-(void)buttonRefresh:(id)sender
{
    if ([[self superview] respondsToSelector:@selector(buttonRefresh:)]) {
        [[self superview] performSelector:@selector(buttonRefresh:) withObject:self];
    }
}


@end
