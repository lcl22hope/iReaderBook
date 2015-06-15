//
//  CLMessageAvatorFactory.h
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 头像大小以及头像与其他控件的距离
static CGFloat const kCLAvatarImageSize = 40.0f;
static CGFloat const kCLAlbumAvatorSpacing = 15.0f;

typedef NS_ENUM(NSInteger, CLMessageAvatorType) {
    CLMessageAvatorTypeNormal = 0,
    CLMessageAvatorTypeSquare,
    CLMessageAvatorTypeCircle
};

@interface CLMessageAvatorFactory : NSObject

+(UIImage *)avatarImageNamed:(UIImage *)originImage
            messageAvatorType:(CLMessageAvatorType)type;

@end
