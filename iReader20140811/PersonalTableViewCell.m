//
//  PersonalTableViewCell.m
//  iReader20140811
//
//  Created by lcl on 11/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//


#import "PersonalTableViewCell.h"
#import "CLImageFillter.h"
#import "Masonry.h"

#define AVATOR_W (80.0f)
#define AVATOR_H (80.0f)

@interface PersonalTableViewCell()

@end

@implementation PersonalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self setLayoutCustom];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setLayoutCustom
{
    //autoLayout
    [self.container addSubview:self.thumbNail];
    
    [_container addSubview:self.title];

    
    [_thumbNail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_container.mas_right).offset(-80);
        make.centerY.equalTo(_container.mas_centerY).offset(0);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_container.mas_left).offset(50);
        make.centerY.equalTo(_container.mas_centerY).offset(0);
    }];
}

#pragma mark - property getter
-(UIImageView*)thumbNail
{
    //thumbnail 如果调用self.thumbNail 就会无限循环，这里就是实例变量与属性的区别
    if (!_thumbNail) {
        _thumbNail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AVATOR_W, AVATOR_H)];
        UIImage* oriImage = [UIImage imageNamed:@"showgirl2cropped"];
//        NSLog(@"oriImage.size %@",NSStringFromCGSize(oriImage.size));
        _thumbNail.image = [self virtualLizeImg:oriImage];
//        NSLog(@"_thumbNail.image.size %@",NSStringFromCGSize(_thumbNail.image.size));
    }
    return _thumbNail;
}

-(UILabel*)title
{
//  title
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        //  self.title.backgroundColor = [UIColor greenColor];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.textColor = [UIColor darkTextColor];
        _title.font = [UIFont boldSystemFontOfSize:25.0];
    }
    return _title;
}

-(UIView*)container
{
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 88)];
    }
    return _container;
}

#pragma mark - avatar virtual operation
- (UIImage*)virtualLizeImg:(UIImage*)oriImage
{
    CIFilter* imgFilter = [CLImageFillter new];
    CIImage* inputImg = [CIImage imageWithCGImage:oriImage.CGImage];
    [imgFilter setValue:inputImg forKey:@"inputImage"];
    CIImage* outImg = [imgFilter outputImage];
    CGImageRef imgRef = [[CIContext contextWithOptions:nil] createCGImage:outImg fromRect:outImg.extent];
    UIImage* imgRefToImg = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    return imgRefToImg;
}

#pragma mark - thumbNail getter
//-(UIImageView*)thumbNail{
//    if(!self.thumbNail){
//        self.thumbNail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AVATOR_W, AVATOR_H)];
//    }
//    return self.thumbNail;
//}

#pragma mark -

@end
