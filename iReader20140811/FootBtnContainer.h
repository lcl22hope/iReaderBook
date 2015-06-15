//
//  FootBtnContainer.h
//  TestFootTrace
//
//  Created by lcl on 17/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FootButton.h"
#import "MenuItems.h"

@class FootBtnContainer;
@protocol FootBtnContainerDelegate <NSObject>

@optional
-(void)didFootBtnSingleTap:(FootBtnContainer*)container;

@end

@interface FootBtnContainer : UIView

@property (nonatomic,strong) FootButton* footBtn;
@property (nonatomic,strong) MenuItems* menu;

@property (nonatomic,weak) id <FootBtnContainerDelegate> delegate;

@end
