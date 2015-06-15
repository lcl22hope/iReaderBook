//
//  CLAlbumPhotoCollectionViewCell.m
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "CLAlbumPhotoCollectionViewCell.h"

@implementation CLAlbumPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.photoImageView];
    }
    return self;
}
#pragma mark - Properties
- (UIImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _photoImageView.image = [UIImage imageNamed:@"showgirl2"];
    }
    return _photoImageView;
}

@end
