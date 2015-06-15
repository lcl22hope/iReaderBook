//
//  BookInFriendReadingCell.h
//  TestUITableview
//
//  Created by lcl on 5/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookInFriendReadingCell : UICollectionViewCell
//-(void)init:(UIImage*)userImg userName:(NSString*)name bookInReading:(UIImage*)bookImg;
@property (nonatomic) UIView* containerView;
-(void)setUserImgName:(UIImage*)userImgName;
-(void)setUserNmae:(NSString*)userName;
-(void)setBookInReadingCover:(UIImage*)imgName;
@end
