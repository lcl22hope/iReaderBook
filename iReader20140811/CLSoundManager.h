//
//  CLSoundManager.h
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CLSoundManager : NSObject

+ (instancetype)sharedInstance;
- (void)playRefreshSound;

@end
