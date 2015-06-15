//
//  CLTag.m
//  iReader20140811
//
//  Created by lcl on 12/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "CLItem.h"
#import "UtilityHeaders.h"

static NSMutableArray* oriLocationArray;

@implementation CLItem
{
    CGPoint oriLocation;
    NSMutableDictionary *oriLocationDic;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tBackgroundColor = RANDOM_COLOR;
        self.tLabelColor = [UIColor darkTextColor];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        [[self layer] setCornerRadius:tagCornerRadius];
        [[self layer] setMasksToBounds:YES];
        oriLocationArray = [NSMutableArray array];
        
    }
    return self;
}

- (CGSize)getTagSize
{
    CGSize tSize = [self.tTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:tagFontType size:tagFontSize]}];
    
    return CGSizeMake(tagMargin + tSize.width + tagMargin , tagHeight);}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.layer.backgroundColor = [self.tBackgroundColor CGColor];
    
    
    CGSize tSize = [self.tTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:tagFontType size:tagFontSize]}];
    
    [self.tTitle drawInRect:CGRectMake(tagMargin, ([self getTagSize].height / 2.0f) - (tSize.height / 2.0f), tSize.width, tSize.height)
             withAttributes:@{NSFontAttributeName:[UIFont fontWithName:tagFontType size:tagFontSize], NSForegroundColorAttributeName:self.tLabelColor}];
    UILongPressGestureRecognizer* longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tagLongPressed:)];
    longPressRecognizer.numberOfTouchesRequired = 1;
    longPressRecognizer.minimumPressDuration = 1.0;
    longPressRecognizer.allowableMovement = 10.0f;
    [self addGestureRecognizer:longPressRecognizer];
    
//    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tagMove:)];
//    [self addGestureRecognizer:panRecognizer];
//    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagSelected:)];
//    [recognizer setNumberOfTapsRequired:1];
//    [recognizer setNumberOfTouchesRequired:1];
//    [self addGestureRecognizer:recognizer];
    
   
////    NSLog(@"location is %@",NSStringFromCGPoint(oriLocation));
////    NSLog(@"self.tag is %ld",(long)self.tag);
//    oriLocation = self.center;
//    NSValue* pointValue = [NSValue valueWithCGPoint:oriLocation];
//    [oriLocationArray addObject:@{[NSString stringWithFormat:@"%ld",(long)self.tag]:pointValue}];

}




-(void)tagLongPressed:(UIGestureRecognizer*)gestureRecognizer
{
//    UIView *view = gestureRecognizer.view;
    CGPoint location = [gestureRecognizer locationInView:self.superview];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if (self.delegate && [self.delegate conformsToProtocol:@protocol(CLItemDelegate)]) {
            [self.delegate tagDidLongPressedStart:self];
        }
    }else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
        self.center = location;
        if (self.delegate && [self.delegate conformsToProtocol:@protocol(CLItemDelegate)]) {
            [self.delegate tagDidMoveTag:self withCurrentLocation:location];
        }
    }
    else if(gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled){
        if (self.delegate && [self.delegate conformsToProtocol:@protocol(CLItemDelegate)]) {
            [self.delegate tagDidLongPressedEnd:self];
        }
        [UIView animateWithDuration:1.0 animations:^{

        }];
    }else if (gestureRecognizer.state == UIGestureRecognizerStateFailed){
        NSLog(@"%@ failed",NSStringFromSelector(_cmd));
    }
}


//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.superview bringSubviewToFront:self];
//    // initialize translation offsets
//    tx = self.transform.tx;
//    ty = self.transform.ty;
//}

//- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self.superview bringSubviewToFront:self];
//    
//    UITouch* t = touches.anyObject;
//    CGPoint loc = [t locationInView: self.superview];
//    CGPoint oldP = [t previousLocationInView: self.superview];
//    CGFloat deltaX = loc.x - oldP.x;
//    CGFloat deltaY = loc.y - oldP.y;
//    CGPoint c = self.center;
//    c.x += deltaX;
//    c.y += deltaY;
//    self.center = c;
//    
//    if(self.delegate && [self.delegate conformsToProtocol:@protocol(CLItemDelegate)]){
//        [self.delegate tagDidMoveTag:self withCurrentLocation:self.center];
//    }
//}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


@end
