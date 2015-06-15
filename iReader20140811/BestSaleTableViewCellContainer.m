//
//  BestSaleTableViewCellContainer.m
//  TestBookStore
//
//  Created by lcl on 4/9/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "BestSaleTableViewCellContainer.h"
#import "BestSaleCollectionViewCell.h"

static NSString *cellIndentifier = @"BookBestSaleCollectionViewCell";

@interface BestSaleTableViewCellContainer ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSArray* collectionData;
@end

@implementation BestSaleTableViewCellContainer

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.dataSource = self;
        self.contentOffset = CGPointZero;
        
        [self registerClass:[BestSaleCollectionViewCell class] forCellWithReuseIdentifier:cellIndentifier];
    }
    return self;
}

-(void)setCollectionData:(NSArray*)collectionData
{
    _collectionData = collectionData;
    [self setContentOffset:CGPointZero animated:NO];
//    [self reloadData];
}

#pragma mark UICollectionView DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [_collectionData count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BestSaleCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    NSString* cellData = [_collectionData objectAtIndex:indexPath.row];
    cell.bookImgView.image = [UIImage imageNamed:cellData];
    return cell;
}




@end
