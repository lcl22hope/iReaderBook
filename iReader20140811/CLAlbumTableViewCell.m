//
//  CLAlbumTableViewCell.m
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "CLAlbumTableViewCell.h"
#import "CLAlbumRichTextView.h"

@interface CLAlbumTableViewCell ()

@property (nonatomic, strong) CLAlbumRichTextView *albumRichTextView;

@end


@implementation CLAlbumTableViewCell

+ (CGFloat)calculateCellHeightWithAlbum:(CLAlbum *)currentAlbum {
    return [CLAlbumRichTextView calculateRichTextHeightWithAlbum:currentAlbum];
}

#pragma mark - Propertys

- (void)setCurrentAlbum:(CLAlbum *)currentAlbum {
    if (!currentAlbum)
        return;
    _currentAlbum = currentAlbum;
    
    self.albumRichTextView.displayAlbum = currentAlbum;
}

- (CLAlbumRichTextView *)albumRichTextView {
    if (!_albumRichTextView) {
        _albumRichTextView = [[CLAlbumRichTextView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 40)];
    }
    return _albumRichTextView;
}

#pragma mark - Life Cycle

- (void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.albumRichTextView];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)dealloc {
    _currentAlbum = nil;
    self.albumRichTextView = nil;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
