//
//  BookInFriendReadingCollectionViewContainer.m
//  TestUITableview
//
//  Created by lcl on 5/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//



#import "BookInFriendReadingCollectionViewContainer.h"
#import "BookInFriendReadingCell.h"
#import "UtilityHeaders.h"

@interface BookInFriendReadingCollectionViewContainer()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView* collectionView;
@property (strong,nonatomic) NSArray* collectionData;

@end

@implementation BookInFriendReadingCollectionViewContainer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(kBookInReadingCellWidth,kBookInReadingCellHeight);
        flowLayout.minimumInteritemSpacing = 5.0f;
        self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.dataSource = self;
        self.collectionView.delegate =self;
        [self.collectionView registerClass:[BookInFriendReadingCell class] forCellWithReuseIdentifier:@"BookInFriendReadingCell"];
        [self addSubview:self.collectionView];
    }
    return self;
}

-(void)setCollectionData:(NSArray*)collectionData
{
    _collectionData = collectionData;
    [_collectionView setContentOffset:CGPointZero animated:NO];
    [_collectionView reloadData];
}


#pragma mark UICollectionView DataSource Methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSLog(@"self.collectionData count is %ld",[self.collectionData count]);
    return [_collectionData count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookInFriendReadingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BookInFriendReadingCell" forIndexPath:indexPath];
    NSDictionary *cellData = [self.collectionData objectAtIndex:indexPath.row];
    UIImage*userImg = [UIImage imageNamed:[cellData objectForKey:@"thumbnail"]];
    NSString*userName = [cellData objectForKey:@"username"];
    UIImage* bookImg = [UIImage imageNamed:[cellData objectForKey:@"bookCover"]];
//    [cell init:userImg userName:userName bookInReading:bookImg];
    [cell setUserNmae:userName];
    [cell setUserImgName:userImg];
    [cell setBookInReadingCover:bookImg];
//    [cell.contentView addSubview:cell.containerView];
    return cell;
}

//#pragma mark collection view cell paddings
//- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(5, 5, 5, 5); // top, left, bottom, right
//}

@end
