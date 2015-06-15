//
//  CLSoundManager.m
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "CLSoundManager.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CLSoundManager () {
    SystemSoundID refreshSound;
}
@end

@implementation CLSoundManager

+ (instancetype)sharedInstance {
    static CLSoundManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CLSoundManager alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"pullrefresh" withExtension:@"aif"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url) , &refreshSound);
    }
    return self;
}

- (void)playRefreshSound {
    AudioServicesPlaySystemSound(refreshSound);
}


@end
