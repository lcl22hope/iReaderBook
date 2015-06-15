//
//  FootBtnContainer.m
//  TestFootTrace
//
//  Created by lcl on 17/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "FootBtnContainer.h"


@interface FootBtnContainer()


@end

@implementation FootBtnContainer

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.footBtn = [[FootButton alloc] initWithFrame:CGRectMake(0, 0, 40, 80)];
        self.menu = [[MenuItems alloc] initWithFrame:CGRectMake(40, 0, 60, 80)];
        [self addSubview:_footBtn];
        [self addSubview:_menu];
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapButton:)];
        tapRecognizer.numberOfTapsRequired = 1;
        tapRecognizer.numberOfTouchesRequired = 1;
        [_footBtn addGestureRecognizer:tapRecognizer];
    }
    return self;
}


-(void)didTapButton:(id)sender
{
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(FootBtnContainerDelegate)]) {
        [self.delegate didFootBtnSingleTap:self];
    }
}

@end
