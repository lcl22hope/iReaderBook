//
//  CLAlbum.h
//  DynamiInfo
//
//  Created by lcl on 6/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <Foundation/Foundation.h>

// 朋友圈分享人的名称高度
#define kCLAlbumUserNameHeigth 18

// 朋友圈分享的图片以及图片之间的间隔
#define kCLAlbumPhotoSize 60
#define kCLAlbumPhotoInsets 5

// 朋友圈分享内容字体和间隔
#define kCLAlbumContentFont [UIFont systemFontOfSize:13]
#define kCLAlbumContentLineSpacing 4

// 朋友圈评论按钮大小
#define kCLAlbumCommentButtonWidth 25
#define kCLAlbumCommentButtonHeight 25

@interface CLAlbum : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *profileAvatorUrlString;
@property (nonatomic, copy) NSString *albumShareContent;
@property (nonatomic, strong) NSArray *albumSharePhotos;
@property (nonatomic, strong) NSArray *albumShareComments;
@property (nonatomic, strong) NSArray *albumShareLikes;
@property (nonatomic, strong) NSDate *timestamp;

@end
