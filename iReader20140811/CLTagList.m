//
//  TagsContainerView.m
//  iReader20140811
//
//  Created by lcl on 12/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "CLTagList.h"
#import "UtilityHeaders.h"

@implementation CLTagList

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        self.tags = [NSMutableArray array];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
//    NSLog(@"%@ is calling",NSStringFromSelector(_cmd));
    int n = 0;
    float x = 40.0f;
    float y = 0.0f;
    
    for (id v in [self subviews]){
        if ([v isKindOfClass:[CLTag class]]){
            [v removeFromSuperview];
        }
    }
    for (CLTag *tag in self.tags)
    {
        if (x + [tag getTagSize].width + tagMargin > self.frame.size.width) {
            n = 0;
            x = 40.0;
            y += [tag getTagSize].height + tagMargin;
        }
        else
            x += (n ? tagMargin : 0.0f);
        
        [tag setFrame:CGRectMake(x, y, [tag getTagSize].width, [tag getTagSize].height)];
        [self addSubview:tag];
        
        x += [tag getTagSize].width;
        
        n++;
    }
    
    CGRect r = [self frame];
    r.size.height = y + tagHeight;
    self.tagListHeight = r.size.height;
    [self setFrame:r];
}

- (CLTag *)generateTagWithLabel:(NSString *)tTitle withImage:(NSString *)tImage
{
//    NSLog(@"%@ is calling",NSStringFromSelector(_cmd));
    CLTag *tag = [[CLTag alloc] initWithFrame:CGRectZero];
    
//    [tag setDelegate:self.delegate];
    [tag setTImage:[UIImage imageNamed:tImage]];
    [tag setTTitle:tTitle];
    
    [self.tags addObject:tag];
    
    return tag;
}

- (void)addTag:(NSString *)tTitle withImage:(NSString *)tImage
{
//    NSLog(@"%@ is calling",NSStringFromSelector(_cmd));
    [self generateTagWithLabel:(tTitle ? tTitle : @"") withImage:(tImage ? tImage : @"")];
    
    [self setNeedsDisplay];
}

- (void)addTag:(NSString *)tTitle withImageURL:(NSURL *)imageURL andImagePlaceholder:(NSString *)tPlaceholderImage
{
    CLTag *tag = [self generateTagWithLabel:(tTitle ? tTitle : @"") withImage:(tPlaceholderImage ? tPlaceholderImage : @"")];
    [tag setTURL:imageURL];
    
    [self setNeedsDisplay];
}

- (void)addTag:(NSString *)tTitle
     withImage:(NSString *)tImage
withLabelColor:(UIColor *)labelColor
withBackgroundColor:(UIColor *)backgroundColor
withCloseButtonColor:(UIColor *)closeColor
{
    CLTag *tag = [self generateTagWithLabel:(tTitle ? tTitle : @"") withImage:(tImage ? tImage : @"")];
    
    if (labelColor) [tag setTLabelColor:labelColor];
    if (backgroundColor) [tag setTBackgroundColor:backgroundColor];
    if (closeColor) [tag setTCloseButtonColor:closeColor];
    
    [self setNeedsDisplay];
}

- (void)addTag:(NSString *)tTitle
withImagePlaceholder:(NSString *)tPlaceholderImage
  withImageURL:(NSURL *)imageURL
withLabelColor:(UIColor *)labelColor
withBackgroundColor:(UIColor *)backgroundColor
withCloseButtonColor:(UIColor *)closeColor
{
    CLTag *tag = [self generateTagWithLabel:(tTitle ? tTitle : @"") withImage:(tPlaceholderImage ? tPlaceholderImage : @"")];
    
    [tag setTURL:imageURL];
    
    if (labelColor) [tag setTLabelColor:labelColor];
    if (backgroundColor) [tag setTBackgroundColor:backgroundColor];
    if (closeColor) [tag setTCloseButtonColor:closeColor];
    
    [self setNeedsDisplay];
}

- (void)addTags:(NSArray *)tags
{
    for (NSDictionary *tag in tags)
        [self addTag:[tag objectForKey:@"title"] withImage:[tag objectForKey:@"image"]];
}

- (void)removeTag:(CLTag *)tag
{
    [self.tags removeObject:tag];
    
    [self setNeedsDisplay];
}

- (void)removeAllTag
{
    for (id t in [NSArray arrayWithArray:[self tags]])
        [self removeTag:t];
}


@end
