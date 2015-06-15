//
//  BestSaleBookCollectionViewContainer.m
//  BookStoreDemo
//
//  Created by lcl on 9/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#define kBestSaleBookCellHeight (100.0f)
#define kBestSaleBookCellWidth (60.0f)
#define kBestSaleCell_SPACE (35.0)

#import "BestSaleBookCollectionViewContainer.h"
#import "BestSaleBookCellItem.h"
#import "BestSaleCollectionViewFlowLayout.h"

@interface BestSaleBookCollectionViewContainer()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *bestSaleBooks;
@property (nonatomic,strong) NSArray* collectionData;

@end


@implementation BestSaleBookCollectionViewContainer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        BestSaleCollectionViewFlowLayout* flowLayout = [[BestSaleCollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(kBestSaleBookCellWidth,kBestSaleBookCellHeight);
        flowLayout.minimumInteritemSpacing = 5.0f;
//        flowLayout.minimumLineSpacing = 5.0f;
        
        self.bestSaleBooks = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        self.bestSaleBooks.backgroundColor = [UIColor clearColor];
//        self.bestSaleBooks.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
        self.bestSaleBooks.showsHorizontalScrollIndicator = NO;
        self.bestSaleBooks.dataSource = self;
        self.bestSaleBooks.delegate =self;
//        [self.bestSaleBooks registerClass:[BestSaleBookCellItem class] forCellWithReuseIdentifier:@"BestSaleBookCellItem"];
        [self.bestSaleBooks registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [self addSubview:self.bestSaleBooks];

    }
    return self;
}

-(void)setCellData:(NSArray *)cellData
{
    _collectionData = cellData;
    [_bestSaleBooks setContentOffset:CGPointZero animated:NO];
    [_bestSaleBooks reloadData];
}

#pragma mark UICollectionView DataSource 
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSLog(@"_collectionData count is %ld",[_collectionData count]);
    return [_collectionData count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    BestSaleBookCellItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BestSaleBookCellItem" forIndexPath:indexPath];
////    if (cell==nil) {
////        cell = [[BestSaleBookCellItem alloc] initW]
////    }
    NSString* bookCoverName = [self.collectionData objectAtIndex:indexPath.row];
//    [cell setBookImg:[UIImage imageNamed:bookCoverName]];
//    return cell;
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectZero];
    }
    UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bookCoverName]];
    image.frame = CGRectMake(0, 0, kBestSaleBookCellWidth, kBestSaleBookCellWidth);
    image.layer.borderWidth = 1;
    image.layer.borderColor = [UIColor whiteColor].CGColor;
    [cell.contentView addSubview:image];
    return cell;
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 5, 0, 5);
//}
@end
