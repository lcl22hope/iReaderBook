//
//  CLImageFillter.m
//  iReader20140811
//
//  Created by lcl on 11/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#define INNER_R (@30)
#define OUTER_R (@40)
#import "CLImageFillter.h"

@interface CLImageFillter()
@property (nonatomic, strong) CIImage* inputImage;
@end

@implementation CLImageFillter
-(CIImage *)outputImage {
    
    CGRect inextent = self.inputImage.extent;
    
    CIFilter* grad = [CIFilter filterWithName:@"CIRadialGradient"];
    CIVector* center = [CIVector vectorWithX:inextent.size.width/2.0
                                           Y:inextent.size.height/2.0];
    
    [grad setValue:center forKey:@"inputCenter"];
    [grad setValue:INNER_R forKey:@"inputRadius0"];
    [grad setValue:OUTER_R forKey:@"inputRadius1"];
    CIImage *gradimage = [grad valueForKey: @"outputImage"];
    
    CIFilter* blend = [CIFilter filterWithName:@"CIBlendWithMask"];
    [blend setValue:self.inputImage forKey:@"inputImage"];
    [blend setValue:gradimage forKey:@"inputMaskImage"];
    
    return blend.outputImage;
}
@end
