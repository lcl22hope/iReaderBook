//
//  CLWaterDropRefresh.h
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLWaterDropRefresh : UIView

@property (nonatomic, assign) CGFloat radius; // default is 5.
@property (nonatomic, assign) CGFloat maxOffset; // default is 70
@property (nonatomic, assign) CGFloat deformationLength; // default is 0.4 (between 0.1 -- 0.9)
@property (nonatomic, assign) CGFloat offsetHeight;
@property (nonatomic, strong) UIImage *refreshCircleImage;
@property (nonatomic, readonly) BOOL isRefreshing;

- (void)stopRefresh;
- (void)startRefreshAnimation;

@property (nonatomic, copy) void(^handleRefreshEvent)(void) ;
@property (nonatomic) float currentOffset;

@end
