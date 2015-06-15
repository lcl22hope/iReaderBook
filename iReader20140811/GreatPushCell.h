//
//  GreatPushCellView.h
//  iReaderWithAirbnb
//
//  Created by lcl on 4/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BtnWholeContent.h"


@interface GreatPushCell : UICollectionViewCell

@property (nonatomic) UILabel* head;
@property (nonatomic) UIImageView* faceCover;
@property (nonatomic) UILabel* detail;
@property (nonatomic) BtnWholeContent* checkWholeContent;
@property (nonatomic) UILabel* category;
-(void)setHeadText:(NSString*)text;
-(void)setDetailText:(NSString*)description;
//-(void)setButtonTile:(NSString*)title;
-(void)setCategoryText:(NSString*)category;
-(void)setBookCoverName:(NSString*)bcName;

@end
