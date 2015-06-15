//
//  GreatPushCellView.m
//  iReaderWithAirbnb
//
//  Created by lcl on 4/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//



#import "GreatPushCell.h"
#import "Masonry.h"
#import "UIButton+Position.h"
#import "UIImage+ImageRender.h"
#import "UtilityHeaders.h"

@implementation GreatPushCell
{
    NSString* bookName;
    NSString* description;
    NSString* buttonTitle;
    NSString* categoryName;
    NSString* bookCoverName;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        NSLog(@"frame is %@",NSStringFromCGRect(frame));
        //1
        UIView *superView= self.contentView;
//        [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x,
//                                                                    frame.origin.y,
//                                                                    BOOK_CELL_WIDTH,
//                                                                    BOOK_CELL_WIDTH)]
        
//        NSLog(@"frame is %@",NSStringFromCGRect(frame));
//        NSLog(@"superView frame is %@",NSStringFromCGRect(self.contentView.frame));
//        NSLog(@"superView bounds is %@",NSStringFromCGRect(self.contentView.bounds));
        
//        superView.center = CGPointMake(self.contentView.frame.origin.x + 5 + BOOK_CELL_WIDTH / 2.0, BOOK_CELL_WIDTH /2.0);
        superView.layer.cornerRadius = 5.0f;
        self.head = UILabel.new;
        self.head.textAlignment = NSTextAlignmentLeft;
        self.head.font = [UIFont boldSystemFontOfSize:10.0f];
        self.head.textColor = [UIColor whiteColor];
        self.head.backgroundColor = [UIColor clearColor];
        self.head.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [self setHeadText:@"法国中尉的女人"];//bookName
        [superView addSubview:self.head];
        
        //2
        self.detail = UILabel.new;
        self.detail.font = [UIFont boldSystemFontOfSize:8.0f];
        self.detail.textAlignment = NSTextAlignmentLeft;
        self.detail.lineBreakMode = NSLineBreakByWordWrapping;
        self.detail.numberOfLines = 0;
        self.detail.textColor = [UIColor whiteColor];
        self.detail.backgroundColor = [UIColor clearColor];
        self.detail.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //    NSString* tmp = @"世界眼中堕落的女人萨拉，抑郁成瘾，生活在保守的英国小镇上，大家都叫她";
//        [self setDetailText:description];
        [superView addSubview:self.detail];
        
        //3
        UIImage* btnImg = [UIImage imageNamed:@"right_arrow"];
        self.checkWholeContent = [[BtnWholeContent alloc] init];
        [self setButtonTitle:@"查看全文"];
        [self.checkWholeContent setTitle:buttonTitle forState:UIControlStateNormal];
        [self.checkWholeContent.titleLabel setFont:[UIFont systemFontOfSize:7.]];
        [self.checkWholeContent setBackgroundImage:btnImg forState:UIControlStateNormal];
        self.checkWholeContent.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.checkWholeContent.tintColor = [UIColor whiteColor];
        self.checkWholeContent.backgroundColor = [UIColor clearColor];
        self.checkWholeContent.autoresizingMask = UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
        [superView addSubview:self.checkWholeContent];
        
        //4
        self.category = UILabel.new;
        self.category.font = [UIFont boldSystemFontOfSize:8.0f];
        self.category.textAlignment = NSTextAlignmentCenter;
        self.category.contentMode = UIViewContentModeScaleToFill;
        self.category.textColor = [UIColor whiteColor];
        self.category.autoresizingMask = UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
        self.category.backgroundColor = [self randomColor];
//        [self setCategoryText:categoryName];
        [superView addSubview:self.category];
        
        
        //5
        self.faceCover = UIImageView.new;
        self.faceCover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        UIImage* bookCover = self.faceCover.image;//[UIImage imageNamed:@"1.png"];//bookCoverName
        CGSize newSize = CGSizeMake(IMG_WIDTH, IMG_HEIGHT);
        UIGraphicsBeginImageContext(newSize);
        [bookCover drawInRect:CGRectMake(0, 0, newSize.width,newSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.faceCover.image = newImage;
        [superView addSubview:self.faceCover];
        superView.backgroundColor = [self randomColor];//[UIColor colorWithRed:23.0/255.0 green:50.0/255.0 blue:77.0/255.0 alpha:1];
        
        int padding = 5;
        
        [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.mas_top).offset(padding);
            make.left.equalTo(superView.mas_left).offset(padding);
            make.right.equalTo(superView.mas_right).offset(-padding);
            make.bottom.equalTo(superView.mas_bottom).offset(-135);
        }];
        
//        NSNumber* w = [[NSNumber alloc] initWithFloat:IMG_WIDTH];
        [self.faceCover mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.head.mas_bottom).offset(padding);
            make.left.equalTo(superView.mas_left).offset(padding);
            make.right.equalTo(superView.mas_right).offset(-padding);
            make.bottom.equalTo(superView.mas_top).offset(IMG_HEIGHT);
        }];
//        CGSize consttainedSize = CGSizeMake(IMG_WIDTH, 9999);
//        CGRect labelRect = [self.detail.text boundingRectWithSize:consttainedSize
//                                                          options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
//                                                       attributes:@{NSFontAttributeName:self.detail.font}
//                                                          context:nil];
//        NSNumber* labelHeight = [[NSNumber alloc] initWithFloat:labelRect.size.height];
        [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.faceCover.mas_bottom).offset(padding);
            make.left.equalTo(superView.mas_left).offset(padding);
            make.right.equalTo(superView.mas_right).offset(-padding);
            make.bottom.equalTo(superView.mas_bottom).offset(-15);
//            make.width.equalTo(w);
//            make.height.equalTo(labelHeight);
        }];
        
        [self.checkWholeContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.detail.mas_bottom).offset(padding);
            make.left.equalTo(superView.mas_left).offset(padding);
            make.right.equalTo(self.category.mas_left).offset(-60);
            make.bottom.equalTo(superView.mas_bottom).offset(-2);
//            make.width.equalTo(@60);
//            make.height.equalTo(@10);
        }];
        
        [self.category mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.detail.mas_bottom).offset(padding);
            make.left.equalTo(self.checkWholeContent.mas_right).offset(60);
            make.right.equalTo(superView.mas_right).offset(0);
            make.bottom.equalTo(superView.mas_bottom).offset(0);
            make.width.equalTo(@40);
        }];
        
//        [self.contentView addSubview:superView];
    }
    return self;
}


- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}




-(void)setHeadText:(NSString *)text
{
//    NSLog(@"head text is %@",text);
    if (text==nil) {
        NSLog(@"invalided book title in every day push");
        return;
    }
    self.head.text = text;
}

-(void)setDetailText:(NSString *)detail
{
    if (detail==nil ) {
        NSLog(@"invalided detail in every day push");
        return;
    }
    self.detail.text = detail;
}

-(void)setButtonTitle:(NSString*)title
{
    if (title == nil) {
        NSLog(@"invalided ButtonTile in every day push");
        return;
    }
    buttonTitle = title;
}

-(void)setBookCoverName:(NSString*)bcName
{
    if (bcName==nil) {
        NSLog(@"invalided book cover name in every day push");
        return;
    }
    self.faceCover.image = [UIImage imageNamed:bcName];
}


-(void)setCategoryText:(NSString *)categoryTmp
{
    if (categoryTmp==nil || [categoryTmp length]==0) {
        NSLog(@"invalided category in every day push");
        return;
    }
    self.category.text = categoryTmp;
}

@end
