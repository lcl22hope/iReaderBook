//
//  RightTrace.m
//  TestFootTrace
//
//  Created by lcl on 16/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "RightTrace.h"
#import "TraceHeader.h"

#import "UtilityHeaders.h"



@interface RightTrace()

@end

@implementation RightTrace

-(instancetype)initWithFrame:(CGRect)frame
                       title:(NSString*)title
                    coverImg:(NSString*)coverImg
                      detail:(NSString*)detail
                        foot:(NSString*)foot
                       scale:(CGFloat)scale
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.rFoot.image = [UIImage imageNamed:foot];
        [self addSubview:_rFoot];
        
        self.rTitle.text = title;
        self.rCoverImg.image = [UIImage imageNamed:coverImg];
        self.rDetail.text = detail;
        [self.container addSubview:_rTitle];
        [_container addSubview:_rCoverImg];
        [_container addSubview:_rDetail];
        [self addSubview:_container];
        self.backgroundColor = [UIColor clearColor];
        self.transform = CGAffineTransformMakeScale(scale, scale);
        CGRect t = self.frame;
        t.origin.x = frame.origin.x;
        t.origin.y = frame.origin.y;
        self.frame = t;
        
        UITapGestureRecognizer* openBookGesturer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didOpenBook:)];
        openBookGesturer.numberOfTouchesRequired = 1;
        openBookGesturer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:openBookGesturer];
    }
    return self;
}


#pragma mark - property getter

-(UIImageView*)rFoot
{
    if (!_rFoot) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = CGRectGetHeight(self.bounds) * 0.8;
        CGFloat h = CGRectGetHeight(self.bounds);
        _rFoot = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    }
    return _rFoot;
}

-(UILabel*)rTitle
{
    if (!_rTitle) {
        CGFloat x = Trace_Padding;
        CGFloat y = Trace_Padding;
        CGFloat w = Trace_Img_Width;
        CGFloat h = 20;
        _rTitle = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _rTitle.textAlignment = NSTextAlignmentLeft;
        _rTitle.font = [UIFont fontWithName:Trace_Font_Type size:10];
        _rTitle.textColor = [UIColor whiteColor];
        
    }
    return _rTitle;

}

-(UIImageView*)rCoverImg
{
    if (!_rCoverImg) {
        CGFloat x = CGRectGetMinX(_rTitle.frame);
        CGFloat y = CGRectGetMaxY(_rTitle.frame) + Trace_Padding;
        _rCoverImg = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, Trace_Img_Width, Trace_Img_Height)];
    }
    return _rCoverImg;
}

-(UILabel*)rDetail
{
    if (!_rDetail) {
        CGFloat x = CGRectGetMaxX(_rCoverImg.frame) + Trace_Padding;
        CGFloat y = CGRectGetMinY(_rCoverImg.frame);
        CGFloat w = Trace_Img_Width - Trace_Padding;
        CGFloat h = Trace_Img_Height;
        _rDetail = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _rDetail.textAlignment = NSTextAlignmentLeft;
        _rDetail.font = [UIFont fontWithName:Trace_Font_Type size:Trace_Font_Size];
        _rDetail.textColor = [UIColor whiteColor];
        _rDetail.numberOfLines = 0;

    }
    return _rDetail;

}

-(UIView*)container
{
    if(!_container){
        CGFloat w = 2*Trace_Img_Width + Trace_Padding * 2;
        CGFloat x = CGRectGetMaxX(_rFoot.frame) + 2;
        _container = [[UIView alloc] initWithFrame:CGRectMake(x, 0, w, self.bounds.size.height)];
        _container.layer.cornerRadius = 2;
        _container.layer.masksToBounds = YES;
//        _container.backgroundColor = RANDOM_COLOR;
    }
    return _container;
}

#pragma mark - Tag Selector Methods
-(void) didOpenBook:(id)sender
{
    NSLog(@"%@ clicked..",_rTitle.text);
}


@end
