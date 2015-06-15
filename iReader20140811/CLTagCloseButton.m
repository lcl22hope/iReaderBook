//
//  CLTagCloseButton.m
//  iReader20140811
//
//  Created by lcl on 12/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "CLTagCloseButton.h"
#import "UtilityHeaders.h"


@implementation CLTagCloseButton

- (id)initWithFrame:(CGRect)frame withColor:(UIColor *)color{
    self = [super initWithFrame:frame];
    if (self){
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        
        [self setCColor:color];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect { //use to draw cross
    [super drawRect:rect];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(rect.size.width - tagCloseButton + 1.0, (rect.size.height - tagCloseButton) / 2.0)];
    [bezierPath addLineToPoint:CGPointMake(rect.size.width - (tagCloseButton * 2.0) + 1.0, ((rect.size.height - tagCloseButton) / 2.0) + tagCloseButton)];
    [self.cColor setStroke];
    bezierPath.lineWidth = 2.0;
    [bezierPath stroke];
    
    UIBezierPath *bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint:CGPointMake(rect.size.width - tagCloseButton + 1.0, ((rect.size.height - tagCloseButton) / 2.0) + tagCloseButton)];
    [bezier2Path addLineToPoint:CGPointMake(rect.size.width - (tagCloseButton * 2.0) + 1.0, (rect.size.height - tagCloseButton) / 2.0)];
    [self.cColor setStroke];
    bezier2Path.lineWidth = 2.0;
    [bezier2Path stroke];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagClose:)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:recognizer];
}

- (void)tagClose:(id)sender
{
    if ([[self superview] respondsToSelector:@selector(tagClose:)])
        [[self superview] performSelector:@selector(tagClose:) withObject:self];
}

@end
