//
//  GreatPushContainerCellView.h
//  iReaderWithAirbnb
//
//  Created by lcl on 4/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GreatPushCell;
@protocol GreatPushCellDelegate <NSObject>

-(void)didShowWorkDetailViewController:(GreatPushCell*)cell;

@end

@interface GreatPushCollectionViewContainer : UIView

@property (nonatomic,weak) id <GreatPushCellDelegate> delegate;
-(void)setCollectionData:(NSArray*)collectionData;


@end
