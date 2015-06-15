//
//  LeftTrace.h
//  TestFootTrace
//
//  Created by lcl on 16/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeftTrace;
@protocol OpenLeftBookDelegate <NSObject>

@optional
-(void)didOpenLeftBook:(LeftTrace*)leftBook;

@end


@interface LeftTrace : UIView
@property (nonatomic,strong) UILabel* lTitle;
@property (nonatomic,strong) UIImageView* lCoverImg;
@property (nonatomic,strong) UILabel* lDetail;
@property (nonatomic,strong) UIImageView* lFoot;
@property (nonatomic,strong) UIView* content;
@property (nonatomic,strong) UIView* container;
@property (nonatomic,weak) id <OpenLeftBookDelegate> openBookDelegate;
-(instancetype)initWithFrame:(CGRect)frame title:(NSString*)title coverImg:(NSString*)coverImg detail:(NSString*)detail foot:(NSString*)foot scale:(CGFloat)scale;
@end
