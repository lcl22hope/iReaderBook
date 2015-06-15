//
//  ViewController.h
//  TestTagAddViewAnimation
//
//  Created by lcl on 14/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TagViewController;
@protocol TagViewControllerDelegate <NSObject>

@optional
-(void)didFinishTagSelected:(TagViewController*)tagVC;

@end


@interface TagViewController : UIViewController

@property (nonatomic,weak) id <TagViewControllerDelegate> tagViewControllerdelegate;

@end

