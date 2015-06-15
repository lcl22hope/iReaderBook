//
//  BestSaleBookCell.m
//  BookStoreDemo
//
//  Created by lcl on 9/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "BestSaleBookCell.h"
#import "BestSaleBookCollectionViewContainer.h"

@interface BestSaleBookCell()

@property (strong,nonatomic) BestSaleBookCollectionViewContainer* container;

@end


@implementation BestSaleBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat w = CGRectGetWidth([[UIScreen mainScreen] bounds]);
        self.container = [[BestSaleBookCollectionViewContainer alloc] initWithFrame:CGRectMake(0, 0, w, 110)];
        self.container.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.container];
    }
    return self;
}

-(void)setCellData:(NSArray*)cellData{
    [self.container setCellData:cellData];
}


@end
