//
//  question.h
//  TestTagAddViewAnimation
//
//  Created by lcl on 15/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class question;
@protocol questionDelegate <NSObject>

@optional
-(void)didQuestionItemsChange:(question*)question;

@end


@interface question : UIView
@property (nonatomic,weak)   id <questionDelegate> delegate;
@property (nonatomic,strong) UIColor* qLabelColor;//文字颜色
@property (nonatomic,strong) UIColor* qBackgroundColor;//背景色
@property (nonatomic,strong) UIColor* qChangeQuestionBtnColor;//按键颜色
@property (nonatomic,strong) NSString* qTitle;

/**
 * Return a question object size
 *
 * @return return a question object CGSize
 */
- (CGSize)getQuestionSize;

@end