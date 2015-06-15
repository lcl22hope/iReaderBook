//
//  CLAlbumTableViewCell.h
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLAlbum.h"
#import "CLBaseTableViewCell.h"

@interface CLAlbumTableViewCell : UITableViewCell

@property (strong,nonatomic) CLAlbum *currentAlbum;

+(CGFloat)calculateCellHeightWithAlbum:(CLAlbum *)currentAlbum;

@end
