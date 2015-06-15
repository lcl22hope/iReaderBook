//
//  WoWoViewController.h
//  iReader20140811
//
//  Created by lcl on 13/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WoWoViewController;
@protocol WoWoViewControllerDelegate <NSObject>

-(void)didFinishSetting:(WoWoViewController*)wowoVC;

@end


@interface WoWoViewController : UIViewController

@property (nonatomic,weak) id <WoWoViewControllerDelegate> wowoVCDelegate;

@end
