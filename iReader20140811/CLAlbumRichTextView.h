//
//  CLAlbumRichTextView.h
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SETextView.h"
#import "CLAlbum.h"


@interface CLAlbumRichTextView : UIView

@property (nonatomic, strong) NSFont *font;
@property (nonatomic, strong) NSColor *textColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) CGFloat lineSpacing;
@property (nonatomic, strong) SETextView *richTextView;
@property (nonatomic, strong) CLAlbum *displayAlbum;

+(CGFloat)calculateRichTextHeightWithAlbum:(CLAlbum *)currentAlbum;


@end
