//
//  CLImageViewer.h
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLImageViewer;
@protocol CLImageViewerDelegate <NSObject>
@optional
- (void)imageViewer:(CLImageViewer*)imageViewer willDismissWithSelectedView:(UIImageView*)selectedView;
@end


@interface CLImageViewer : UIView
@property (nonatomic, weak) id<CLImageViewerDelegate> delegate;
@property (nonatomic, assign) CGFloat backgroundScale;
- (void)showWithImageViews:(NSArray*)views selectedView:(UIImageView*)selectedView;
@end
