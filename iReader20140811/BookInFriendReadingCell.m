//
//  BookInFriendReadingCell.m
//  TestUITableview
//
//  Created by lcl on 5/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "BookInFriendReadingCell.h"
#import "Masonry.h"
#import "UtilityHeaders.h"

@interface BookInFriendReadingCell()
@property (nonatomic) UIImageView* avatarView;
@property (nonatomic) UILabel* userName;
@property (nonatomic) UIImageView* bookInReading;
@end


@implementation BookInFriendReadingCell
{
    UIImage* userImg;
    NSString*name;
    UIImage* bookImg;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.containerView = self.contentView;
        self.containerView.layer.cornerRadius = 2.0f;
        //1 用户头像
        UIImage* avatar = userImg;
        UIImage* avatarCroped = [[UIImage alloc] init];
        BOOL flag;
        if (avatar.size.width > avatar.size.height) {
            flag = YES;
            avatarCroped = [self cropImageToSquareSize:avatar
                                              withSize:CGSizeMake(avatar.size.height, avatar.size.height)
                                              withFlag:flag];
        }else{
            flag = NO;
            avatarCroped = [self cropImageToSquareSize:avatar
                                              withSize:CGSizeMake(avatar.size.width, avatar.size.width)
                                              withFlag:flag];
        }
        UIImage* avatarScaled = [self scaleToSize:avatarCroped toSize:CGSizeMake(40, 38)];
        //    NSLog(@"avatarScaled.size is %@",NSStringFromCGSize(avatarScaled.size));
        self.avatarView = [[UIImageView alloc] initWithImage:avatarScaled];
        //    NSLog(@"self.avatarView.size is %@",NSStringFromCGSize(self.avatarView.frame.size));
        self.avatarView.layer.cornerRadius = self.avatarView.frame.size.height /2.0;
        self.avatarView.layer.masksToBounds = YES;
        self.avatarView.layer.borderWidth = 1;
        self.avatarView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.avatarView.image = avatar;
        self.avatarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.containerView addSubview:self.avatarView];
        //2 用户名
        self.userName = [[UILabel alloc] init];
        self.userName.text = name;
        self.userName.font = [UIFont boldSystemFontOfSize:6.0f];
        self.userName.textColor = [UIColor blackColor];
        self.userName.textAlignment = NSTextAlignmentCenter;
        self.userName.contentMode = UIViewContentModeScaleAspectFit;
        self.userName.backgroundColor = [UIColor clearColor];
        self.userName.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.containerView addSubview:self.userName];
        //3 用户正在读的书
        UIImage* bookImgFit = [self scaleToSize:bookImg toSize:CGSizeMake((WIDTH_CELL-10)*RADIO_GOLD, WIDTH_CELL-10)];
        //    NSLog(@"bookImgFit.size is %@",NSStringFromCGSize(bookImgFit.size));
        self.bookInReading = [[UIImageView alloc] initWithImage:bookImgFit];
        self.bookInReading.layer.borderWidth = 2.;
        self.bookInReading.layer.borderColor = [UIColor whiteColor].CGColor;
        self.bookInReading.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.bookInReading.layer.cornerRadius = 2.0f;
        //    NSLog(@"self.bookInReading.frame is %@",NSStringFromCGRect(self.bookInReading.frame));
        [self.containerView addSubview:self.bookInReading];
        
        
        int padding = 2;
        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.containerView.mas_top).offset(padding);
            make.left.equalTo(self.containerView.mas_left).offset(padding);
            make.right.equalTo(self.bookInReading.mas_left).offset(-padding);
            make.bottom.equalTo(self.containerView.mas_top).offset(self.avatarView.frame.size.height+padding);
            //-(WIDTH_CELL-self.avatarView.frame.size.height-padding)
        }];
        
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarView.mas_bottom).offset(padding);
            //            make.left.equalTo(superview.mas_left).offset(padding);
            make.centerX.equalTo(self.avatarView.mas_centerX).offset(0);
            make.bottom.equalTo(self.avatarView.mas_bottom).offset(10.0);
        }];
        CGFloat w = self.bookInReading.frame.size.width;//bookImg.size.width;
        [self.bookInReading mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.containerView.mas_top).offset(padding);
            make.left.equalTo(self.containerView.mas_right).offset(-(padding+w));
            make.right.equalTo(self.containerView.mas_right).offset(-padding);
            make.bottom.equalTo(self.containerView.mas_bottom).offset(-padding);
        }];
    }
    return self;
}




-(void)setUserImgName:(UIImage*)userImgName
{
    if (userImgName == nil) {
        NSLog(@"%@ error in %@",NSStringFromSelector(_cmd),NSStringFromClass([BookInFriendReadingCell class]));
        return;
    }
//    userImg = userImgName;
    self.avatarView.image = userImgName;
}


-(void)setUserNmae:(NSString*)userName
{
    if (userName == nil) {
        NSLog(@"%@ error in %@",NSStringFromSelector(_cmd),NSStringFromClass([BookInFriendReadingCell class]));
        return;
    }
//    name = userName;
    self.userName.text = userName;
}


-(void)setBookInReadingCover:(UIImage*)imgName
{
    if (imgName == nil) {
        NSLog(@"%@ error in %@",NSStringFromSelector(_cmd),NSStringFromClass([BookInFriendReadingCell class]));
        return;
    }
//    bookImg = imgName;
    self.bookInReading.image = imgName;
}

-(UIImage*)scaleToSize:(UIImage*)image toSize:(CGSize)newSize
{
    CGFloat width = CGImageGetWidth(image.CGImage);
    CGFloat height = CGImageGetHeight(image.CGImage);
    CGFloat verticalRadio = newSize.height * 1.0 / height;
    CGFloat horizontalRadio = newSize.width * 1.0 / width;
    CGFloat radio = 1;
    if (verticalRadio > 1 && horizontalRadio > 1) {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }else{
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    width = width * radio;
    height= height* radio;
    
    CGFloat xPos = (newSize.width - width) /2.0;
    CGFloat yPos = (newSize.height- height)/2.0;
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(xPos, yPos, width, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(UIImage*)cropImageToSquareSize:(UIImage*)image withSize:(CGSize)newSize withFlag:(NSInteger)flag
{
    
    UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    if (flag) {
        [image drawInRect:CGRectMake(newSize.height / 2.0, 0, newSize.height, newSize.height)];
    }else{
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.width)];
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}

@end
