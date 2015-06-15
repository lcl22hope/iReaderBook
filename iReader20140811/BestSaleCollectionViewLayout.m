//
//  BestSaleCollectionViewLayout.m
//  TestBookStore
//
//  Created by lcl on 4/9/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "BestSaleCollectionViewLayout.h"

#define ACTIVE_DISTANCE 200
#define ZOOM_FACTOR 0.3

@implementation BestSaleCollectionViewLayout


-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}


-(void)setup
{
    self.itemSize = CGSizeMake(80, 132);
    self.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 10.0f;
}

//自动对齐到网格
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //proposedContentOffset是没有对齐到网格时本来应该停下的位置
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    //对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}


-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
//    
//    for (UICollectionViewLayoutAttributes* attributes in array) {
//        if (CGRectIntersectsRect(attributes.frame, rect)) {
//            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
//            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
//            if (ABS(distance) < ACTIVE_DISTANCE) {
//                CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
//                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
//                attributes.zIndex = 1;
//            }
//        }
//    }
    return array;
}




@end
