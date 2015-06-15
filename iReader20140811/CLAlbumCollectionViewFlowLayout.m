//
//  CLAlbumCollectionViewFlowLayout.m
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "CLAlbumCollectionViewFlowLayout.h"
#import "CLAlbum.h"
@implementation CLAlbumCollectionViewFlowLayout


- (id)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(kCLAlbumPhotoSize, kCLAlbumPhotoSize);
        self.minimumInteritemSpacing = kCLAlbumPhotoInsets;
        self.minimumLineSpacing = kCLAlbumPhotoInsets;
    }
    return self;
}

@end
