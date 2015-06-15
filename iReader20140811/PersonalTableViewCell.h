//
//  PersonalTableViewCell.h
//  iReader20140811
//
//  Created by lcl on 11/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PersonalTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView* thumbNail;
@property (nonatomic,strong) UILabel* title;
@property (nonatomic,strong) UIView* container;
- (UIImage*)virtualLizeImg:(UIImage*)oriImage;
-(void)setLayoutCustom;
@end
