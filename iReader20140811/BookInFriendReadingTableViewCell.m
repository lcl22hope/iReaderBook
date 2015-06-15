//
//  BookInFriendReadingTableViewCell.m
//  TestUITableview
//
//  Created by lcl on 5/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "BookInFriendReadingTableViewCell.h"
#import "BookInFriendReadingCollectionViewContainer.h"

@interface BookInFriendReadingTableViewCell()

@property (strong,nonatomic) BookInFriendReadingCollectionViewContainer* container;

@end


@implementation BookInFriendReadingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        CGRect currentScreen = [[UIScreen mainScreen] bounds];
        self.container = [[BookInFriendReadingCollectionViewContainer alloc] initWithFrame:CGRectMake(0, 0,320, 120)];
        self.container.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:230.0/255.0 blue:195.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.container];
    }
    return self;
}

-(void)setCollectionData:(NSArray*)collectionData
{
    [self.container setCollectionData:collectionData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
