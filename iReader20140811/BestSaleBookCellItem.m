//
//  BestSaleBookCellItem.m
//  BookStoreDemo
//
//  Created by lcl on 9/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "BestSaleBookCellItem.h"


@interface BestSaleBookCellItem()
@property (nonatomic,strong) UIImageView* bookCover;
@end

@implementation BestSaleBookCellItem


- (instancetype)initWithFrame:(CGRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        self.bookCover = [[UIImageView alloc] initWithImage:self.bookCover.image];
        self.bookCover.frame = self.bounds;
        [self.contentView addSubview:self.bookCover];
    }
    return self;
}

-(void)setBookImg:(UIImage*)bookImg{
    self.bookCover.image = bookImg;
}

@end
