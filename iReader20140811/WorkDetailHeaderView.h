//
//  WorkDetailHeaderView.h
//  iReader20140811
//
//  Created by lcl on 19/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LikeCountView.h"

@interface WorkDetailHeaderView : UIView

@property (nonatomic,strong) UIImageView* bookCover;
@property (nonatomic,strong) UILabel* bookTitle;
@property (nonatomic,strong) UILabel* author;
@property (nonatomic,strong) UILabel* price;
@property (nonatomic,strong) UILabel* size;
@property (nonatomic,strong) LikeCountView* loveCountView;
@property (nonatomic,strong) UILabel* bookDetail;

@end
