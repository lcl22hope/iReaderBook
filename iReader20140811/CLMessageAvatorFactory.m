//
//  CLMessageAvatorFactory.m
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "CLMessageAvatorFactory.h"
#import "UIImage+CLRounded.h"

@implementation CLMessageAvatorFactory

+(UIImage *)avatarImageNamed:(UIImage *)originImage
            messageAvatorType:(CLMessageAvatorType)messageAvatorType {
    CGFloat radius = 0.0;
    switch (messageAvatorType) {
        case CLMessageAvatorTypeNormal:
            return originImage;
            break;
        case CLMessageAvatorTypeCircle:
            radius = originImage.size.width / 2.0;
            break;
        case CLMessageAvatorTypeSquare:
            radius = 8;
            break;
        default:
            break;
    }
    UIImage *avator = [originImage createRoundedWithRadius:radius];
    return avator;
}

@end
