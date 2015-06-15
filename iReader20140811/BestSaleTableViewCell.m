//
//  BestSaleTableViewCell.m
//  TestBookStore
//
//  Created by lcl on 4/9/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "BestSaleTableViewCell.h"
#import "BestSaleTableViewCellContainer.h"
#import "BestSaleCollectionViewLayout.h"
@interface BestSaleTableViewCell()
@property (strong,nonatomic) BestSaleTableViewCellContainer* container;
@end

@implementation BestSaleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        BestSaleCollectionViewLayout* flowLayout = [[BestSaleCollectionViewLayout alloc] init];
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        flowLayout.itemSize = CGSizeMake(66,100);
//        flowLayout.minimumInteritemSpacing = 10.0f;
        
        self.container = [[BestSaleTableViewCellContainer alloc] initWithFrame:CGRectMake(0, 0, 320, 142) collectionViewLayout:flowLayout];
        self.container.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.container];
        
    }
    return self;
}

-(void)setCollectionData:(NSArray *)collectionData
{
    [self.container setCollectionData:collectionData];
}

@end
