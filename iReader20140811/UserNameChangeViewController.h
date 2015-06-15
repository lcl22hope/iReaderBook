//
//  UserNameChangeViewController.h
//  iReader20140811
//
//  Created by lcl on 13/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserNameChangeViewController;

@protocol UserNameChangeVCDelegate <NSObject>

-(void)didChangeUserName:(UserNameChangeViewController*)userNameChangeVC withNewName:(NSString*)newName;

@end



@interface UserNameChangeViewController : UIViewController
@property (nonatomic,weak) id <UserNameChangeVCDelegate> userNameChangeDelegate;
@property (nonatomic,strong) UITextField* textField;
@end
