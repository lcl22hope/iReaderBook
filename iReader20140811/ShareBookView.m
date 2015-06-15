//
//  ShareBookViwe.m
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "ShareBookView.h"

@implementation ShareBookView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        NSLog(@"frame is %@ in %@",NSStringFromCGRect(frame),NSStringFromSelector(_cmd));
//        [self baseSetup];
    }
    return self;
}

//-(void)baseSetup
//{
//    UIView* share = [[UIView alloc] initWithFrame:CGRectMake(70, 188, 235, 120)];
//    
//    CGFloat ImgWidth = CGRectGetWidth(share.frame)/ 3.0;
//    UIImageView* sharebookImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, ImgWidth-10, CGRectGetHeight(share.frame)-10)];
//    sharebookImage.image =[UIImage imageNamed:@"1"];
//    
//    [share addSubview:sharebookImage];
//    
//    CGFloat BookNameWidth = (CGRectGetWidth(share.frame) - ImgWidth)-5;
//    CGFloat BookNameHeight = CGRectGetHeight(share.frame)/4.0;
//    CGFloat BookNameX = sharebookImage.frame.size.width + 5.0;
//    UILabel *shareBookName = [[UILabel alloc] initWithFrame:CGRectMake(BookNameX+5, 5, BookNameWidth, BookNameHeight)];
//    shareBookName.text = @"法国中尉的女人";
//    shareBookName.textColor = [UIColor whiteColor];
//    shareBookName.textAlignment = NSTextAlignmentLeft;
//    shareBookName.font = [UIFont boldSystemFontOfSize:16];
//    shareBookName.backgroundColor = [UIColor greenColor];
//    [share addSubview:shareBookName];
//    
//    
//    //    CGFloat BookAuthorWidth = BookNameWidth - 5.0;
//    CGFloat BookAuthorHeight = BookNameHeight / 2.0;
//    CGFloat BookAuthorX = shareBookName.frame.origin.x;
//    CGFloat BookAuthorY = shareBookName.frame.origin.y + BookNameHeight + 5;
//    UILabel* shareBookAuthor = [[UILabel alloc] initWithFrame:CGRectMake(BookAuthorX,BookAuthorY , BookNameWidth, BookAuthorHeight)];
//    shareBookAuthor.backgroundColor = [UIColor yellowColor];
//    shareBookAuthor.text = @"[英]约翰•福尔斯";
//    shareBookAuthor.textColor = [UIColor whiteColor];
//    shareBookAuthor.textAlignment = NSTextAlignmentLeft;
//    shareBookAuthor.font = [UIFont boldSystemFontOfSize:(BookAuthorHeight-1.0)];
//    [share addSubview:shareBookAuthor];
//    
//    
//    CGFloat BookDescriptionWidth = BookNameWidth;
//    CGFloat BookDescriptionHeight = CGRectGetMaxY(sharebookImage.frame) - BookNameHeight - BookAuthorHeight -15;
//    UILabel *shareBookDescription = [[UILabel alloc] initWithFrame:CGRectMake(BookNameX +5, BookAuthorY + BookAuthorHeight + 5, BookDescriptionWidth , BookDescriptionHeight)];
//    shareBookDescription.text = @"世人眼中堕落女人萨拉，抑郁成瘾，生活在保守的英国小镇上，大家都叫她“法国中尉的女人”";
//    shareBookDescription.backgroundColor = [UIColor orangeColor];
//    shareBookDescription.textColor = [UIColor whiteColor];
//    shareBookDescription.textAlignment = NSTextAlignmentLeft;
//    shareBookDescription.font = [UIFont boldSystemFontOfSize:12];
//    shareBookDescription.numberOfLines = 0;
//    
//    [share addSubview:shareBookDescription];
//    
//    
//    share.backgroundColor = [UIColor grayColor];
//    
//    [self addSubview:share];
//}

@end
