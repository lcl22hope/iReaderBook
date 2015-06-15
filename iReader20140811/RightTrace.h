//
//  RightTrace.h
//  TestFootTrace
//
//  Created by lcl on 16/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightTrace : UIView
@property (nonatomic,strong) UILabel* rTitle;
@property (nonatomic,strong) UIImageView* rCoverImg;
@property (nonatomic,strong) UILabel* rDetail;
@property (nonatomic,strong) UIImageView* rFoot;
@property (nonatomic,strong) UIView* container;
-(instancetype)initWithFrame:(CGRect)frame
                       title:(NSString*)title
                    coverImg:(NSString*)coverImg
                      detail:(NSString*)detail
                        foot:(NSString*)foot
                       scale:(CGFloat)scale;
@end
