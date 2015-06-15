//
//  CloudTagsView.m
//  BookStoreDemo
//
//  Created by lcl on 8/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "CloudTagsView.h"
#define BUDDLEGAP_X 35
#define BUDDLEGAP_Y 10
#define FONTHEIGHT 35
#define CONTRAINT_WIDTH (280)
#define DURATION 16
#define FONTSIZE (16)
#define FIREINTERVAL 2

//random color generator
/*
 
 CGFloat hue = ( arc4random() % 256 / 256.0 ); // 0.0 to 1.0
 CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from white
 CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from black
 UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
 
 */

#define HUE        (arc4random() % 256 / 256.0 )
#define SATURATION ((arc4random()% 128 / 256.0 ) + 0.5)
#define BRIGHTNESS ((arc4random()% 128 / 256.0 ) + 0.5)
#define RANDOM_COLOR ([UIColor colorWithHue:HUE saturation:SATURATION brightness:BRIGHTNESS alpha:1])


@interface CloudTagsView ()
{
    NSArray *dataArray;
    NSInteger index;
}
@end

@implementation CloudTagsView

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

-(void)reloadData:(NSArray *)customData{
    if (dataArray!=nil) {
        @autoreleasepool {
            dataArray = nil;
        }
    }
    dataArray=customData;
    //设置初始动画偏移量
//    NSLog(@"DURATION/FIREINTERVAL is %d ",DURATION/FIREINTERVAL);
    for (int i=0; i<DURATION/FIREINTERVAL; i++) {
        NSArray *buttonaRY=[self bubbleUp];
        for (UIView *vie in buttonaRY) {
            [vie setValue:[NSNumber numberWithFloat:(i+1)*FIREINTERVAL] forKeyPath:@"timeoffset"];
//            vie.alpha = 0.0;
        }
    }
    NSTimer *time;
    time=[NSTimer scheduledTimerWithTimeInterval:FIREINTERVAL target:self selector:@selector(bubbleUp) userInfo:nil repeats:YES];
    
    [time fire];
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    for (UIView *vie in self.subviews) {
//        if (CGRectContainsPoint(((CALayer *)vie.layer.presentationLayer).frame, point)) {
//            return vie;
//        }
//    }
//    return nil;
//}

#pragma mark - Tag show Animations
//动画
-(NSArray *)bubbleUp{
    index = index % [dataArray count];
    NSArray* tmp = [self containThree];
    NSMutableArray* tagsArray = [NSMutableArray array];
    for (int i=0; i < [tmp count]; i++) {
            NSString* curTagStr = [tmp objectAtIndex:i];
            UIFont* curTagFont = [UIFont systemFontOfSize:FONTSIZE];
            CGRect curTagFrame = [curTagStr boundingRectWithSize:CGSizeMake(1000, FONTHEIGHT)
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:curTagFont}
                                                         context:nil];
            CGFloat curTag_w = CGRectGetWidth(curTagFrame);
            BubbleTag* tag = [[BubbleTag alloc] init];
            tag.frame=CGRectMake(self.frame.size.width/2-curTag_w/2, self.frame.size.height-FONTHEIGHT, curTag_w,FONTHEIGHT);
            tag.text = curTagStr;
            tag.font = curTagFont;
            tag.delegate = self;
            tag.textColor = RANDOM_COLOR;
            tag.backgroundColor = [UIColor clearColor];
            //        NSLog(@"tag.frame is %@",NSStringFromCGRect(tag.frame));
            [self addSubview:tag];
            [tagsArray addObject:tag];
            //        tag = nil;
            CGRect ZeroObjInTmp_Frame = [[tmp objectAtIndex:0] boundingRectWithSize:CGSizeMake(1000, FONTHEIGHT)
                                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                                         attributes:@{NSFontAttributeName:curTagFont}
                                                                            context:nil];
            //如果只有两个，那么左边一个、右边一个
            if ([tmp count]==2) {
                if (i==0) {
                    //左边的
                    CGRect rect=tag.frame;
                    rect.origin.x=self.frame.size.width/4-curTag_w/2;
                    rect.origin.y-=FONTHEIGHT/2;
                    tag.frame = rect;
                }else if(i==1){
                    //右边的
                    CGRect rect=tag.frame;
                    rect.origin.x=self.frame.size.width/4*3-curTag_w/2;
                    rect.origin.y-=FONTHEIGHT/2;
                    tag.frame=rect;
                }
            }else{
                //如果是有1个或者3个
                if (i==1) {
                    //计算origin.x  x+width=this.origin.x
                    CGRect rect=tag.frame;
                    rect.origin.x=self.frame.size.width/2-(ZeroObjInTmp_Frame.size.width/2);
                    rect.origin.x-=(curTag_w-BUDDLEGAP_X);
                    rect.origin.y-=(FONTHEIGHT-BUDDLEGAP_Y);
                    tag.frame=rect;
                }
                if (i==2) {
                    //计算origin.x  x+width=this.origin.x
                    CGRect rect=tag.frame;
                    rect.origin.x=self.frame.size.width/2-(ZeroObjInTmp_Frame.size.width/2);
                    rect.origin.x+=ZeroObjInTmp_Frame.size.width-BUDDLEGAP_X;
                    rect.origin.y-=(FONTHEIGHT-BUDDLEGAP_Y);
                    tag.frame=rect;
                }
            }
            //        NSLog(@"after change frame tag.frame is %@",NSStringFromCGRect(tag.frame));
            CABasicAnimation *basicScale=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
            basicScale.fromValue=[NSNumber numberWithFloat:.65];
            basicScale.toValue=[NSNumber numberWithFloat:1.];
            basicScale.autoreverses=YES;
            basicScale.duration=DURATION/2;
            basicScale.fillMode=kCAFillModeForwards;
            basicScale.removedOnCompletion=NO;
            basicScale.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [tag.layer addAnimation:basicScale forKey:@"s"];
            
            CABasicAnimation *basicOpa=[CABasicAnimation animationWithKeyPath:@"opacity"];
            basicOpa.fromValue=[NSNumber numberWithFloat:0.3];
            basicOpa.toValue=[NSNumber numberWithFloat:1.];
            basicOpa.autoreverses=YES;
            basicOpa.duration=DURATION/2;
            basicOpa.fillMode=kCAFillModeForwards;
            basicOpa.removedOnCompletion=NO;
            
            basicOpa.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [tag.layer addAnimation:basicOpa forKey:@"o"];
            
            
            UIBezierPath *path=[UIBezierPath bezierPath];
            
            [path moveToPoint:CGPointMake(tag.frame.origin.x+curTag_w/2, tag.frame.origin.y+FONTHEIGHT/2)];
            
            switch (i) {
                case 0:{
                    if ([tmp count]==1||[tmp count]==3) {
                        //此时中间的走直线
                        [path addLineToPoint:CGPointMake(tag.frame.origin.x+curTag_w/2, FONTHEIGHT/2)];
                    }else if([tmp count]==2){
                        //没有中间 走左弧
                        [path addCurveToPoint:CGPointMake(tag.frame.origin.x+curTag_w/2, FONTHEIGHT/2)
                                controlPoint1:CGPointMake(tag.frame.origin.x+curTag_w/2, tag.frame.origin.y+FONTHEIGHT/2)
                                controlPoint2:CGPointMake(0, self.frame.size.height/2)];
                    }
                }
                    break;
                case 1:{
                    if ([tmp count]==3) {
                        //i==1 走左弧
                        [path addCurveToPoint:CGPointMake(tag.frame.origin.x+curTag_w/2, FONTHEIGHT/2)
                                controlPoint1:CGPointMake(tag.frame.origin.x+curTag_w/2, tag.frame.origin.y+FONTHEIGHT/2)
                                controlPoint2:CGPointMake(0, self.frame.size.height/2)];
                    }else if([tmp count]==2){
                        //走右弧
                        [path addCurveToPoint:CGPointMake(tag.frame.origin.x+curTag_w/2, FONTHEIGHT/2)
                                controlPoint1:CGPointMake(tag.frame.origin.x+curTag_w/2, tag.frame.origin.y+FONTHEIGHT/2)
                                controlPoint2:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
                    }
                }
                    break;
                case 2:{
                    [path addCurveToPoint:CGPointMake(tag.frame.origin.x+curTag_w/2, FONTHEIGHT/2)
                            controlPoint1:CGPointMake(tag.frame.origin.x+curTag_w/2, tag.frame.origin.y+FONTHEIGHT/2)
                            controlPoint2:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
                }
                    
                    break;
            }
            
            CAKeyframeAnimation *keyPosi=[CAKeyframeAnimation animationWithKeyPath:@"position"];
            keyPosi.path=path.CGPath;
            keyPosi.fillMode=kCAFillModeForwards;
            keyPosi.removedOnCompletion=NO;
            keyPosi.duration=DURATION;
            keyPosi.delegate=self;
            [keyPosi setValue:tag forKeyPath:@"itslayer"];
            keyPosi.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [tag.layer addAnimation:keyPosi forKey:@"x"];
        }
    return tagsArray;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        UIView *view=[anim valueForKeyPath:@"itslayer"];
        [view removeFromSuperview];
//        view = nil;
    }
}
- (void)animationDidStart:(CAAnimation *)anim{
    
    @autoreleasepool {
        UIView *view=[anim valueForKeyPath:@"itslayer"];
        NSNumber *num=[view valueForKeyPath:@"timeoffset"];
        if (num!=nil) {
            view.layer.timeOffset=num.floatValue;
        }
    }
}

//根据界面宽度选择显示的标签
-(NSArray*)containThree{
    NSInteger tmpIndex = index;
    NSObject* ob1 = [dataArray objectAtModuloIndex:tmpIndex];
//    NSLog(@"ob1 is %@",ob1);
    NSString* ob1_Str = (NSString*)ob1;
    CGRect ob1_frame = [ob1_Str boundingRectWithSize:CGSizeMake(1000, FONTHEIGHT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONTSIZE]}
                                          context:nil];
    ++tmpIndex;
    NSObject* ob2 = [dataArray objectAtModuloIndex:tmpIndex];
//    NSLog(@"ob2 is %@",ob2);
    NSString* ob2_Str = (NSString*)ob2;
    CGRect ob2_frame = [ob2_Str boundingRectWithSize:CGSizeMake(1000, FONTHEIGHT)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONTSIZE]}
                                             context:nil];
    ++tmpIndex;
    NSObject* ob3 = [dataArray objectAtModuloIndex:tmpIndex];
    NSString* ob3_Str = (NSString*)ob3;
    CGRect ob3_frame = [ob3_Str boundingRectWithSize:CGSizeMake(1000, FONTHEIGHT)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONTSIZE]}
                                             context:nil];
//    NSLog(@"ob3 is %@",ob3);
    CGFloat totalWidth = ob1_frame.size.width + ob2_frame.size.width + ob3_frame.size.width;
    //如果三条显示的长度太长 就取两条显示
    if (totalWidth>CONTRAINT_WIDTH) {
        //如果两条显示的长度太长 就取一条显示
        if (ob1_frame.size.width+ob2_frame.size.width>CONTRAINT_WIDTH) {
            ++index;
            return [NSArray arrayWithObject:ob1];
        }else{
            index+=2;
            return [NSArray arrayWithObjects:ob1,ob2, nil];
        }
    }else{
        index+=3;
        return [NSArray arrayWithObjects:ob1,ob2,ob3, nil];
    }
}


#pragma mark - Tag clicked respond Animations
//点击标签
-(void)touchUpInside:(UIButton *)ges{
    NSLog(@"点击");
    //这里应该有跳转动作...
}
//点下标签暂停动画
-(void)touchDown:(UIButton *)ges{
    CFTimeInterval pausedTime = [ges.layer convertTime:CACurrentMediaTime()
                                             fromLayer:nil];
//    NSLog(@"pausedTime is %lf",pausedTime);
    ges.layer.speed = 0.0;
    ges.layer.timeOffset = pausedTime;
}
//点离标签继续动画
-(void)touchOut:(UIButton *)but{
    CFTimeInterval pausedTime = [but.layer timeOffset];
    but.layer.speed = 1.0;
    but.layer.timeOffset = 0.0;
    but.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [but.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    but.layer.beginTime = timeSincePause;
}

@end


@implementation NSArray(Modulo)
- (id)objectAtModuloIndex:(NSUInteger)index{
    return [self objectAtIndex:index%[self count]];
}
@end


@implementation BubbleTag
@synthesize delegate;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [delegate performSelector:@selector(touchDown:) withObject:self];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *tou= [touches anyObject];
    if (CGRectContainsPoint([(CALayer *)[self.layer presentationLayer] frame], [tou locationInView:self.superview])) {
        [delegate performSelector:@selector(touchUpInside:) withObject:self];
    }else{
        [delegate performSelector:@selector(touchOut:) withObject:self];
    }
    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *tou= [touches anyObject];
    if (CGRectContainsPoint([(CALayer *)[self.layer presentationLayer] frame], [tou locationInView:self.superview])) {
        [delegate performSelector:@selector(touchUpInside:) withObject:self];
    }else{
        [delegate performSelector:@selector(touchOut:) withObject:self];
    }
    
}
@end