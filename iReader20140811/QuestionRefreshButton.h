//
//  QuestionRefreshButton.h
//  TestTagAddViewAnimation
//
//  Created by lcl on 15/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionRefreshButton : UIView

@property (nonatomic, strong) UIColor *btnColor;

@property (nonatomic, strong) UIImageView* refreshImg;

@property (nonatomic, strong) NSString* title;

- (id)initWithFrame:(CGRect)frame withColor:(UIColor *)color;

- (CGSize)getBtnSize;

@end
