//
//  GreatPushTableViewCell.m
//  iReaderWithAirbnb
//
//  Created by lcl on 4/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "GreatPushTableViewCell.h"

@interface GreatPushTableViewCell()



@end

@implementation GreatPushTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.collectionViewContainer = [[GreatPushCollectionViewContainer alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
        self.collectionViewContainer.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:230.0/255.0 blue:195.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.collectionViewContainer];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCollectionData:(NSArray*)collectionData
{
    [self.collectionViewContainer setCollectionData:collectionData];
}

@end
