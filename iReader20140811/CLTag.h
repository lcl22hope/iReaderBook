//
//  CLTag.h
//  iReader20140811
//
//  Created by lcl on 12/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLTag;

@protocol CLTagDelegate <NSObject>

@optional

- (void)tagDidAddTag:(CLTag *)tag;
- (void)tagDidRemoveTag:(CLTag *)tag;
- (void)tagDidSelectTag:(CLTag *)tag;

@end

@interface CLTag : UIView

@property (nonatomic, weak) id <CLTagDelegate> delegate;
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
