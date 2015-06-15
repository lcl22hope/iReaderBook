//
//  commentViewINDetail.h
//  iReader20140811
//
//  Created by lcl on 19/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentViewINDetail : UIView
@property (nonatomic,strong) UIImageView* avator;
@property (nonatomic,strong) UILabel*  name;
@property (nonatomic,strong) UILabel*  date;
@property (nonatomic,strong) UILabel*  comment;
@property (nonatomic,strong) UIButton* likeBtn;
@property (nonatomic,strong) UILabel*  likeCount;
@property (nonatomic,strong) UIButton* commentBtn;
@property (nonatomic,strong) UILabel*  commentCount;
@end
