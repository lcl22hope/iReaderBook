//
//  WoWoUIView.m
//  iReader20140811
//
//  Created by lcl on 13/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#define SLIDER_TRACE_COLOR ([UIColor colorWithRed:153.0/255.0 green:76.0/255.0 blue:83.0/255.0 alpha:1.0])

#define MARGIN (10.0f)

#import "WoWoUIView.h"
#import "Masonry.h"

@implementation WoWoUIView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.aLabel];
        [self addSubview:self.value_0];
        [self addSubview:self.aSlider];
        [self addSubview:self.value_100];
//        _aLabel.backgroundColor = [UIColor redColor];
//        _value_0.backgroundColor = [UIColor blueColor];
//        _aSlider.backgroundColor = [UIColor yellowColor];
//        _value_100.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

-(UILabel*)aLabel{
    if (!_aLabel) {
        CGFloat x = CGRectGetMinX(self.bounds) + MARGIN;
        CGFloat y = CGRectGetMinY(self.bounds);
        CGFloat w = 50;
        CGFloat h = 30;
        _aLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _aLabel.textAlignment = NSTextAlignmentCenter;
        _aLabel.textColor = [UIColor darkTextColor];
        _aLabel.font = [UIFont boldSystemFontOfSize:12.0];
    }
    return _aLabel;
}

-(UILabel*)value_0{
    CGFloat x = CGRectGetMaxX(_aLabel.frame)+MARGIN;
    CGFloat y = _aLabel.frame.origin.y;
    CGFloat w = 20;
    CGFloat h = 30;
    if (!_value_0) {
        _value_0 = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _value_0.textColor = [UIColor colorWithRed:229.0/255.0 green:180.0/255.0 blue:78.0/255.0 alpha:1.0];
        _value_0.text = @"0";
        _value_0.textAlignment = NSTextAlignmentCenter;
        _value_0.font = [UIFont boldSystemFontOfSize:15.0];
    }
    return _value_0;
}

-(ANPopoverSlider*)aSlider{
    CGFloat x = CGRectGetMaxX(_value_0.frame)+MARGIN;
    CGFloat y = _aLabel.frame.origin.y;
    CGFloat w = 150;
    CGFloat h = 30;
    if (!_aSlider) {
        _aSlider = [[ANPopoverSlider alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _aSlider.minimumValue = 0.0f;
        _aSlider.maximumValue = 100.0f;
    }
    return _aSlider;
}

-(UILabel*)value_100{
    CGFloat x = CGRectGetMaxX(_aSlider.frame)+MARGIN;
    CGFloat y = _aLabel.frame.origin.y;
    CGFloat w = 50;
    CGFloat h = 30;
    if (!_value_100) {
        _value_100 = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _value_100.textColor = [UIColor colorWithRed:229.0/255.0 green:180.0/255.0 blue:78.0/255.0 alpha:1.0];
        _value_100.text = @"100";
        _value_100.textAlignment = NSTextAlignmentCenter;
        _value_100.font = [UIFont boldSystemFontOfSize:15.0];
    }
    return _value_100;
}



-(void)setLayoutCustom
{
    [_aLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(MARGIN);
        make.right.equalTo(_value_0).offset(MARGIN);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    
    [_value_0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_aSlider.mas_left).offset(-MARGIN);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    
    [_aSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_value_100).offset(-MARGIN);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    
    [_value_100 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-MARGIN);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
}


@end
