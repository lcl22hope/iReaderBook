//
//  GreatPushContainerCellView.m
//  iReaderWithAirbnb
//
//  Created by lcl on 4/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//



#import "GreatPushCollectionViewContainer.h"
#import "GreatPushCell.h"
#import "UtilityHeaders.h"
#import "WorkDetailViewController.h"

@interface GreatPushCollectionViewContainer() <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView* collectionView;
@property (strong,nonatomic) NSArray* collectionData;

@end


@implementation GreatPushCollectionViewContainer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(kPushBookCellWidth,kPushBookCellHeight);
        flowLayout.minimumInteritemSpacing = 5.0f;
        self.collectionView = [[UICollectionView alloc] initWithFrame:frame
                                                 collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.dataSource = self;
        self.collectionView.delegate =self;
        [_collectionView registerClass:[GreatPushCell class] forCellWithReuseIdentifier:@"GreatPushCellView"];
        [self addSubview:self.collectionView];
    }
    return self;
}

-(void)setCollectionData:(NSArray *)collectionData
{
    _collectionData = collectionData;
    [_collectionView setContentOffset:CGPointZero animated:NO];
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource methods
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
    GreatPushCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GreatPushCellView" forIndexPath:indexPath];
    NSDictionary *cellData = [self.collectionData objectAtIndex:indexPath.row];
    [cell setHeadText:[cellData objectForKey:@"title"]];
    [cell setBookCoverName:[cellData objectForKey:@"coverName"]];
    [cell setCategoryText:[cellData objectForKey:@"category"]];
    [cell setDetailText:[cellData objectForKey:@"desciption"]];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    GreatPushCell* cell = (GreatPushCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(GreatPushCellDelegate)]) {
        [self.delegate didShowWorkDetailViewController:cell];
    }
    
    
}


#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5); // top, left, bottom, right
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    
//    return 5.0;
//}


//添加观察者，当点击某个view时用来交互？？？？
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSDictionary *cellData = [self.collectionData objectAtIndex:[indexPath row]];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectItemFromCollectionView" object:cellData];
//}

@end


