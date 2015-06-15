//
//  CLPhotographyHelper.h
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^DidFinishTakeMediaCompledBlock)(UIImage *image, NSDictionary *editingInfo);

@interface CLPhotographyHelper : NSObject

- (void)showOnPickerViewControllerSourceType:(UIImagePickerControllerSourceType)sourceType onViewController:(UIViewController *)viewController compled:(DidFinishTakeMediaCompledBlock)compled;

@end
