//
//  TagsContainerView.h
//  iReader20140811
//
//  Created by lcl on 12/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTag.h"

@interface CLTagList : UIView

//@property (nonatomic,weak) id <CLTagDelegate>  delegate;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic) CGFloat tagListHeight;
/**************************
 * Methods to load tags with bundle images
 **************************/
/**
 * Dynamically calculate the taglist height for footerView
 */


/**************************
 * Methods to load tags with bundle images
 **************************/

/**
 * Create a new tag object
 *
 * @param tTitle the NSString tag label
 * @param tImage the NSString tag image named
 */
- (void)addTag:(NSString *)tTitle withImage:(NSString *)tImage;
/**
 * Create a new tag object with custom colors
 *
 * @param tTitle the NSString tag label
 * @param tImage the NSString tag image named
 * @param labelColor the UIColor tag label color. Default color is [UIColor whiteColor]
 * @param backgroundColor the UIColor tag background color. Default color is [UIColor colorWithRed:0.204 green:0.588 blue:0.855 alpha:1.000]
 * @param closeColor the UIColor tag close button color. Default color is [UIColor colorWithRed:0.710 green:0.867 blue:0.953 alpha:1.000]
 */
- (void)addTag:(NSString *)tTitle withImage:(NSString *)tImage withLabelColor:(UIColor *)labelColor withBackgroundColor:(UIColor *)backgroundColor withCloseButtonColor:(UIColor *)closeColor;

/**************************
 * Methods to load tags with distant images
 **************************/

/**
 * Create a new tag object
 *
 * @param tTitle the NSString tag label
 * @param imageURL the NSURL tag image
 * @param tPlaceholderImage the NSString tag image placeholder. If nil no image will be shown will downloading distant image
 */
- (void)addTag:(NSString *)tTitle withImageURL:(NSURL *)imageURL andImagePlaceholder:(NSString *)tPlaceholderImage;

/**
 * Create a new tag object with custom colors
 *
 * @param tTitle the NSString tag label
 * @param tPlaceholderImage the NSString tag image placeholder. If nil no image will be shown will downloading distant image
 * @param imageURL the NSURL tag image
 * @param labelColor the UIColor tag label color. Default color is [UIColor whiteColor]
 * @param backgroundColor the UIColor tag background color. Default color is [UIColor colorWithRed:0.204 green:0.588 blue:0.855 alpha:1.000]
 * @param closeColor the UIColor tag close button color. Default color is [UIColor colorWithRed:0.710 green:0.867 blue:0.953 alpha:1.000]
 */
- (void)addTag:(NSString *)tTitle withImagePlaceholder:(NSString *)tPlaceholderImage withImageURL:(NSURL *)imageURL withLabelColor:(UIColor *)labelColor withBackgroundColor:(UIColor *)backgroundColor withCloseButtonColor:(UIColor *)closeColor;

/**************************
 * Common methods for tags
 **************************/

/**
 * Create a new tags object and add them to the tag list view.
 *
 * @param tags the NSArray tag list to be added. The given tag must be of NSDictionary type (ie. @{@"title": @"Tyrion", @"image": @"tyrion.jpg"})
 */
- (void)addTags:(NSArray *)tags;

/**
 * Remove the given tag from the tag list view
 *
 * @param tag the CLTag instance to be removed
 */
- (void)removeTag:(CLTag *)tag;

/**
 * Remove all tags object
 */
- (void)removeAllTag;

@end
