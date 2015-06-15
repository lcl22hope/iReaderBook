//
//  BookBestSaleCollectionViewCell.m
//  TestBookStore
//
//  Created by lcl on 4/9/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//



#import "BestSaleCollectionViewCell.h"

@interface BestSaleCollectionViewCell ()


@end

@implementation BestSaleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        self.bookImgView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
        self.bookImgView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:self.bookImgView];
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return self;
}



@end
