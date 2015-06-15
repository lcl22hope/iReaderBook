//
//  HeadlinesTodayController.h
//  iReader20140811
//
//  Created by lcl on 4/9/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commentViewINDetail.h"
@interface HeadlinesTodayController : UITableViewController
@property (nonatomic,strong) UIView* newsHeaderView;
@property (nonatomic,strong) UIImageView* newsImgView;
@property (nonatomic,strong) UITextView* newsDetailView;
@property (nonatomic,strong) commentViewINDetail* commentDetail;
@end
