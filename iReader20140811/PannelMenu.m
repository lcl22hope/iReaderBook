//
//  PannelMenu.m
//  iReader20140811
//
//  Created by lcl on 19/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#define Pannel_Menu_Padding (15.f)
#define btnWidth  (80.f)
#define btnHeight (60.f)

#import "PannelMenu.h"

@interface PannelMenu()
@property (nonatomic,strong) UIButton* catalogueBtn;
@property (nonatomic,strong) UIButton* setBtn;
@property (nonatomic,strong) UIButton* reverseBtn;
@property (nonatomic,strong) UIButton* fontBtn;
@end

@implementation PannelMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.catalogueBtn];
        [self addSubview:self.fontBtn];
        [self addSubview:self.reverseBtn];
        [self addSubview:self.setBtn];
        self.backgroundColor = [UIColor colorWithRed:23.0/255.0 green:50.0/255.0 blue:77.0/255.0 alpha:1];
    }
    return self;
}

-(UIButton*)catalogueBtn
{
    if (!_catalogueBtn) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = btnWidth;
        CGFloat h = btnHeight;
        _catalogueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _catalogueBtn.frame = CGRectMake(x, y, w, h);
        UIImage* img = [UIImage imageNamed:@"catalogue"];
        [_catalogueBtn setBackgroundImage:img forState:UIControlStateNormal];
//        [_catalogueBtn setImageEdgeInsets:UIEdgeInsetsMake(-5*2, -15*2, -5*2, -15*2)];
        [_catalogueBtn addTarget:self action:@selector(catalogueBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _catalogueBtn;

}

-(UIButton*)fontBtn
{
    if (!_fontBtn) {
        CGFloat x = btnWidth;
        CGFloat y = 0;
        CGFloat w = btnWidth;
        CGFloat h = btnHeight;
        _fontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fontBtn.frame = CGRectMake(x, y, w, h);
        UIImage* img = [UIImage imageNamed:@"font"];
        [_fontBtn setBackgroundImage:img forState:UIControlStateNormal];
//        [_fontBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 15, 5, 15)];
        [_fontBtn addTarget:self action:@selector(fontBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fontBtn;
}

-(UIButton*)reverseBtn
{
    if (!_reverseBtn) {
        CGFloat x = btnWidth * 2 ;
        CGFloat y = 0;
        CGFloat w = btnWidth;
        CGFloat h = btnHeight;
        _reverseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reverseBtn.frame = CGRectMake(x, y, w, h);
        UIImage* img = [UIImage imageNamed:@"reverse"];
        [_reverseBtn setBackgroundImage:img forState:UIControlStateNormal];
        [_reverseBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 15, 5, 15)];
        [_reverseBtn addTarget:self action:@selector(reverseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reverseBtn;
}

-(UIButton*)setBtn
{
    if (!_setBtn) {
        CGFloat x = btnWidth * 3;
        CGFloat y = 0;
        CGFloat w = btnWidth;
        CGFloat h = btnHeight;
        _setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _setBtn.frame = CGRectMake(x, y, w, h);
        UIImage* img = [UIImage imageNamed:@"set"];
        [_setBtn setBackgroundImage:img forState:UIControlStateNormal];
        [_setBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 15 , 5, 15)];
        [_setBtn addTarget:self action:@selector(setBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setBtn;
}

#pragma mark - action
-(void)catalogueBtnClicked:(id)sender
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}


-(void)fontBtnClicked:(id)sender
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

-(void)reverseBtnClicked:(id)sender
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

-(void)setBtnClicked:(id)sender
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

@end
