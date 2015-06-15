//
//  LeftTrace.m
//  TestFootTrace
//
//  Created by lcl on 16/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "LeftTrace.h"
#import "TraceHeader.h"
#import "UtilityHeaders.h"

@interface LeftTrace()

@end

@implementation LeftTrace


-(instancetype)initWithFrame:(CGRect)frame
                       title:(NSString*)title
                    coverImg:(NSString*)coverImg
                      detail:(NSString*)detail
                        foot:(NSString*)foot
                       scale:(CGFloat)scale
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lTitle.text = title;
        self.lCoverImg.image = [UIImage imageNamed:coverImg];
        self.lDetail.text = detail;
        [self.container addSubview:_lTitle];
        [_container addSubview:_lCoverImg];
        [_container addSubview:_lDetail];
        [self addSubview:_container];
        self.lFoot.image = [UIImage imageNamed:foot];
        [self addSubview:_lFoot];
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

-(UILabel*)lTitle
{
    if (!_lTitle) {
        CGFloat x = Trace_Padding;
        CGFloat y = Trace_Padding;
        CGFloat w = Trace_Img_Width;
        CGFloat h = 20;
        _lTitle = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _lTitle.textAlignment = NSTextAlignmentLeft;
        _lTitle.font = [UIFont fontWithName:Trace_Font_Type size:10];
        _lTitle.textColor = [UIColor whiteColor];
    }
    return _lTitle;

}

-(UIImageView*)lCoverImg
{
    if (!_lCoverImg) {
        CGFloat x = CGRectGetMinX(_lTitle.frame);
        CGFloat y = CGRectGetMaxY(_lTitle.frame) + Trace_Padding;
        _lCoverImg = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, Trace_Img_Width, Trace_Img_Height)];
    }
    return _lCoverImg;
}

-(UILabel*)lDetail
{
    if (!_lDetail) {
        CGFloat x = CGRectGetMaxX(_lCoverImg.frame) + Trace_Padding;
        CGFloat y = CGRectGetMinY(_lCoverImg.frame);
        CGFloat w = Trace_Img_Width - Trace_Padding;
        CGFloat h = Trace_Img_Height;
        _lDetail = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _lDetail.textAlignment = NSTextAlignmentLeft;
        _lDetail.font = [UIFont fontWithName:Trace_Font_Type size:Trace_Font_Size];
        _lDetail.textColor = [UIColor whiteColor];
        _lDetail.numberOfLines = 0;
     }
    return _lDetail;

}

-(UIView*)container
{
    if(!_container){
        CGFloat w = 2*Trace_Img_Width + Trace_Padding * 2;
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, self.bounds.size.height)];
        _container.layer.cornerRadius = 2;
        _container.layer.masksToBounds = YES;
//        _container.backgroundColor = RANDOM_COLOR;
    }
    return _container;
}

-(UIImageView*)lFoot
{
    if (!_lFoot) {
        CGFloat x = CGRectGetMaxX(_container.frame) + 5;
        CGFloat y = 0;
        CGFloat w = CGRectGetHeight(self.bounds) * 0.8;
        CGFloat h = CGRectGetHeight(self.bounds);
        _lFoot = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    }
    return _lFoot;
}

#pragma mark - Tag Selector Methods
-(void) didOpenBook:(id)sender
{
    NSLog(@"%@ clicked..",_lTitle.text);
    if(self.openBookDelegate && [self.openBookDelegate conformsToProtocol:@protocol(OpenLeftBookDelegate)]){
        [self.openBookDelegate didOpenLeftBook:self];
    }
}

@end
