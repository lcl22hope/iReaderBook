//
//  question.m
//  TestTagAddViewAnimation
//
//  Created by lcl on 15/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#define questionCornerRadius     3.0f
#define questionFontSize         (20.0f)
#define questionFontType         @"Helvetica-Light"
#define questionMargin           5.0f
#define questionHeight           25.0f
#define qChangeQuestionButtonSize    7.0f
#import "question.h"
#import "QuestionRefreshButton.h"

@implementation question

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.qBackgroundColor = [UIColor colorWithRed:23/255.0 green:50/255.0 blue:77/255.0 alpha:1.0];
        self.qLabelColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.layer.cornerRadius = questionCornerRadius;
        self.layer.masksToBounds = YES;
    }
    return self;
}

#pragma mark - public methods
-(CGSize)getQuestionSize
{
    CGSize tSize = [self.qTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:questionFontType size:questionFontSize]}];
    
    NSString* tTitle = @"换一换";
    CGSize btnTitleSize = [tTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:questionFontType size:15.0]}];
    //questionHeight equal to image width
    CGFloat w = btnTitleSize.width + questionHeight + questionMargin;
    
    return CGSizeMake(questionMargin + tSize.width + questionMargin + w, questionHeight);
}

#pragma mark - redraw view

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.layer.backgroundColor = self.qBackgroundColor.CGColor;
    CGSize tSize = [self.qTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:questionFontType size:questionFontSize]}];
    [self.qTitle drawInRect:CGRectMake(questionMargin, ([self getQuestionSize].height / 2.0f) - (tSize.height / 2.0f), tSize.width, tSize.height) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:questionFontType size:questionFontSize], NSForegroundColorAttributeName:self.qLabelColor}];
    NSString* tTitle = @"换问题";
    CGSize btnTitleSize = [tTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:questionFontType size:15.0]}];
    //questionHeight equal to image Height
    CGFloat x = questionMargin + tSize.width +  questionMargin;
    CGFloat w = btnTitleSize.width + questionHeight + questionMargin;
    CGFloat h = questionHeight;
    QuestionRefreshButton* qBtn = [[QuestionRefreshButton alloc] initWithFrame:CGRectMake(x, 0, w, h) withColor:[UIColor whiteColor]];
    [self addSubview:qBtn];
    
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(questionItemsChanged:)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:recognizer];

}

#pragma mark - methods of question selected
-(void)questionItemsChanged:(id)sender
{
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(questionDelegate)]) {
        [self.delegate didQuestionItemsChange:self];
    }
}

#pragma mark - methods implements for QusetionRefreshButton
-(void)buttonRefresh:(id)sender
{
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(questionDelegate)]) {
        [self.delegate didQuestionItemsChange:self];
    }
}



@end



