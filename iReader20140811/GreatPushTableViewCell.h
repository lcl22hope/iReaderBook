//
//  GreatPushTableViewCell.h
//  iReaderWithAirbnb
//
//  Created by lcl on 4/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GreatPushCollectionViewContainer.h"
@interface GreatPushTableViewCell : UITableViewCell
@property (strong,nonatomic) GreatPushCollectionViewContainer* collectionViewContainer;
-(void)setCollectionData:(NSArray*)collectionData;
@end
