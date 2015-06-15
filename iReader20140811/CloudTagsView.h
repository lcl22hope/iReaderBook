//
//  CloudTagsView.h
//  BookStoreDemo
//
//  Created by lcl on 8/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreFoundation/CoreFoundation.h>
@interface CloudTagsView : UIView

-(void)reloadData:(NSArray*)dataArray;

@end


@interface NSArray (Modulo)
- (id)objectAtModuloIndex:(NSUInteger)index;
@end


@interface BubbleTag : UILabel

@property(nonatomic,weak) id delegate;

@end
