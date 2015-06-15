//
//  InfoTableViewCell.h
//  iReader20140811
//
//  Created by lcl on 12/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel* title;
@property (nonatomic,strong) UILabel* subTitle;
@property (nonatomic,strong) UIView* container;
-(void)setLayoutCustom;
@end
