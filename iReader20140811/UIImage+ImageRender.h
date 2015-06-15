//
//  UIImage+ImageRender.h
//  TestAutolayout
//
//  Created by lcl on 3/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageRender)
+(UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color;
+(UIImage *)scaleToSize:(NSString *)name withSize:(CGSize)size;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
