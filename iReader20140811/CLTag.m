//
//  CLTag.m
//  iReader20140811
//
//  Created by lcl on 12/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "CLTag.h"
#import "UtilityHeaders.h"
#import "CLTagCloseButton.h"
#import "CLTagList.h"


@implementation CLTag

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tBackgroundColor = RANDOM_COLOR;//[UIColor colorWithRed:0.204 green:0.588 blue:0.855 alpha:1.000];
        self.tLabelColor = [UIColor whiteColor];
        self.tCloseButtonColor = [UIColor colorWithRed:0.710 green:0.867 blue:0.953 alpha:1.000];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        [[self layer] setCornerRadius:tagCornerRadius];
        [[self layer] setMasksToBounds:YES];
    }
    return self;
}

- (CGSize)getTagSize
{
    CGSize tSize = [self.tTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:tagFontType size:tagFontSize]}];
    
    return CGSizeMake(tagMargin + tSize.width + tagMargin + tagCloseButton + tagMargin, tagHeight);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.layer.backgroundColor = [self.tBackgroundColor CGColor];
    
    
    CGSize tSize = [self.tTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:tagFontType size:tagFontSize]}];
    
    [self.tTitle drawInRect:CGRectMake(tagMargin, ([self getTagSize].height / 2.0f) - (tSize.height / 2.0f), tSize.width, tSize.height)
             withAttributes:@{NSFontAttributeName:[UIFont fontWithName:tagFontType size:tagFontSize], NSForegroundColorAttributeName:self.tLabelColor}];
    
    CLTagCloseButton *close = [[CLTagCloseButton alloc] initWithFrame:CGRectMake([self getTagSize].width - tagHeight, 0.0, tagHeight, tagHeight)
                                                            withColor:self.tCloseButtonColor];
    [self addSubview:close];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagSelected:)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:recognizer];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDidAddTag:)])
        [self.delegate performSelector:@selector(tagDidAddTag:) withObject:self];
}

- (void)tagSelected:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDidSelectTag:)])
        [self.delegate performSelector:@selector(tagDidSelectTag:) withObject:self];
}

- (void)tagClose:(id)sender
{
    NSLog(@"%@ is calling",NSStringFromSelector(_cmd));
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDidRemoveTag:)]){
        [self.delegate performSelector:@selector(tagDidRemoveTag:) withObject:self];
    }
    
    
    [(CLTagList *)[self superview] removeTag:self];
}

@end
