//
//  CLTag.h
//  iReader20140811
//
//  Created by lcl on 12/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLItem;

@protocol CLItemDelegate <NSObject>

@optional

- (void)tagDidAddTag:(CLItem *)tag;
- (void)tagDidRemoveTag:(CLItem *)tag;
- (void)tagDidLongPressedStart:(CLItem *)tag;
- (void)tagDidLongPressedEnd:(CLItem *)tag;
- (void)tagDidMoveTag:(CLItem*)tag withCurrentLocation:(CGPoint)tagPoint;

@end

@interface CLItem : UIView
@property (nonatomic, weak) id <CLItemDelegate> delegate;
@property (nonatomic, strong) UIColor *tLabelColor; //文字色
@property (nonatomic, strong) UIColor *tBackgroundColor;//tag背景色
@property (nonatomic, strong) UIColor *tCloseButtonColor;//close button 颜色
@property (nonatomic, copy)   NSString *tTitle;
@property (nonatomic, strong) NSURL *tURL;
@property (nonatomic, strong) UIImage *tImage;


/**
 * Return a tag object size
 *
 * @return return a tag object CGSize size
 */
- (CGSize)getTagSize;

@end
