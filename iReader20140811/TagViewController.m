//
//  ViewController.m
//  TestTagAddViewAnimation
//
//  Created by lcl on 14/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#define UTILITY_VIEW_SIZE        (50.0f)
#define CORNER_RADIUS            (4.0f)
#define BORDER_WIDTH             (2.0f)
#define maxKeyWord               (10)
#define minimum_height_tag       (100.0)

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HIGH [UIScreen mainScreen].bounds.size.height
#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)



#import "UtilityHeaders.h"
#import "TagViewController.h"
#import "question.h"
#import "CLItem.h"

#import "pop/POP.h"

@interface TagViewController ()<questionDelegate,CLItemDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) UIView* bookShelfView;
@property (nonatomic,strong) UIView* trashView;
@property (nonatomic,strong) UIImageView* like0;
@property (nonatomic,strong) UIImageView* like1;
@property (nonatomic,strong) UIImageView* unlike0;
@property (nonatomic,strong) UIImageView* unlike1;
@property (nonatomic,strong) question* question;
@property (nonatomic,strong) UIButton* refresh;

//后台数据
@property (nonatomic,strong) NSMutableArray* authors;
@property (nonatomic,strong) NSMutableArray* questions;
@end

@implementation TagViewController
{
    BOOL isFirst;
    BOOL isSendToTrash;
    BOOL isSendToBookShelf;
    CGFloat oriDistance_tag2trash;
    CGFloat oriDistance_tag2bookshelf;
    CGPoint oriTrashCenter;
    CGPoint oriBookShelfCenter;
    CGPoint oriTagCenter;
    UIActionSheet* choiceTrashSheet;
    UIActionSheet* choiceBookShelfSheet;
    CLItem* pointToTag;
}
            
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = bgColor;
    [self.view addSubview:self.trashView];
    [self.view addSubview:self.bookShelfView];
    [self.view addSubview:self.unlike0];
    [self.view addSubview:self.like0];
    [self.view addSubview:self.like1];
    [self.view addSubview:self.question];
    

    self.authors = [NSMutableArray arrayWithArray:@[@"韩寒",@"朱自清",@"但丁",@"白居易",@"井上彦雄",@"村上春树",@"陆游",@"李白",@"三岛由纪夫",@"东野圭吾",@"夏日漱石",@"柴静",@"杨红樱",@"雷欧幻像",@"俞敏洪",@"郭敬明",@"沈石溪",@"张小娴",@"刘同",@"凯利•麦格尼格尔",@"陶立夏",@"马克·盖特雷恩",@"庆山",@"麦克尔•莫斯利",@"特立独行的猫",@"刘同",@"M·斯科特·派克",@"科林·胡佛",@"迈克•贝克特尔",@"松浦弥太郎",@"八月长安",@"李笑来",@"张泉灵",@"大冰"]];

    //初始数据
    [self changeItems];
    oriDistance_tag2bookshelf = MAXFLOAT;
    oriDistance_tag2trash = MAXFLOAT;
    
    //ActionSheet
    
    choiceTrashSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"不再关注", nil];
    choiceBookShelfSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"我要看", nil];
    
    //初始化控件,这样视图切换过程中就不会有扫尾的影子了
    _trashView.hidden = YES;
    _unlike0.hidden = YES;
}

#pragma mark - property getter
-(UIView*)trashView
{
    if (!_trashView) {
        CGFloat y = CGRectGetHeight([[UIScreen mainScreen] bounds])/2.0 - UTILITY_VIEW_SIZE / 2.0 + 50;
        _trashView = [[UIView alloc] initWithFrame:CGRectMake(-UTILITY_VIEW_SIZE -10, y, UTILITY_VIEW_SIZE + 10, UTILITY_VIEW_SIZE)];
        UIImageView* trashImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        trashImg.image = [UIImage imageNamed:@"trash"];
        trashImg.center = CGPointMake(_trashView.bounds.size.width / 2 + 5,_trashView.bounds.size.height / 2);
        _trashView.backgroundColor = [UIColor darkTextColor];
        _trashView.layer.borderWidth = BORDER_WIDTH;
        _trashView.layer.borderColor = [UIColor whiteColor].CGColor;
        _trashView.layer.cornerRadius = CORNER_RADIUS;
        _trashView.clipsToBounds = YES;
        _trashView.tag = 101;
        [_trashView addSubview:trashImg];
        _trashView.alpha = 0.5;
    }
    return _trashView;
}

-(UIView*)bookShelfView
{
    if (!_bookShelfView) {
        CGFloat y = CGRectGetHeight([[UIScreen mainScreen] bounds])/2.0 - UTILITY_VIEW_SIZE / 2.0 + 50;
        CGFloat x = CGRectGetWidth([[UIScreen mainScreen] bounds]);//- UTILITY_VIEW_SIZE
        _bookShelfView = [[UIView alloc] initWithFrame:CGRectMake( x, y, UTILITY_VIEW_SIZE + 10, UTILITY_VIEW_SIZE)];
        UIImageView* bookShelfImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        bookShelfImg.image = [UIImage imageNamed:@"bookshelf"];
        bookShelfImg.center = CGPointMake(_bookShelfView.bounds.size.width/2.0 - 4, _bookShelfView.bounds.size.height/2.0);
        _bookShelfView.backgroundColor = [UIColor darkTextColor];
        _bookShelfView.layer.borderWidth = BORDER_WIDTH;
        _bookShelfView.layer.borderColor = [UIColor whiteColor].CGColor;
        _bookShelfView.layer.cornerRadius = CORNER_RADIUS;
        _bookShelfView.clipsToBounds = YES;
        _bookShelfView.tag = 102;
        [_bookShelfView addSubview:bookShelfImg];
        _bookShelfView.alpha = 0.5;

    }
    return _bookShelfView;
}

-(UIImageView*)unlike0
{
    if (!_unlike0) {
        CGFloat y = CGRectGetMinY(_trashView.frame) - UTILITY_VIEW_SIZE;
        _unlike0 = [[UIImageView alloc] initWithFrame:CGRectMake(-UTILITY_VIEW_SIZE, y, UTILITY_VIEW_SIZE, UTILITY_VIEW_SIZE)];
        NSMutableArray* arr = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            NSString* tmp = [NSString stringWithFormat:@"unlike0-_000%d.png",i];
            UIImage* frameImg = [UIImage imageNamed:tmp];
            [arr addObject:frameImg];
        }
        UIImage* gif = [UIImage animatedImageWithImages:arr duration:0.5];
        _unlike0.image = gif;
        _unlike0.tag = 103;

    }
    return _unlike0;


}

-(UIImageView*)like0
{
    if (!_like0) {
        CGFloat y = CGRectGetMinY(_bookShelfView.frame)-UTILITY_VIEW_SIZE;
        CGFloat x = CGRectGetMinX(_bookShelfView.frame);
        _like0 = [[UIImageView alloc] initWithFrame:CGRectMake(x + 2, y, UTILITY_VIEW_SIZE, UTILITY_VIEW_SIZE)];
        NSMutableArray* arr = [NSMutableArray array];
        for (int i = 0; i < 8; i++) {
            NSString* tmp = [NSString stringWithFormat:@"like0-%d.png",i];
            UIImage* frameImg = [UIImage imageNamed:tmp];
            [arr addObject:frameImg];
        }
        UIImage* gif = [UIImage animatedImageWithImages:arr duration:1.5];
        _like0.image = gif;
        _like0.tag = 104;
    }
    return _like0;

}

-(UIImageView*)like1
{
    if (!_like1) {
        CGFloat y = CGRectGetMaxY(_bookShelfView.frame);
        CGFloat x = CGRectGetMinX(_bookShelfView.frame);
        _like1 = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, UTILITY_VIEW_SIZE, UTILITY_VIEW_SIZE)];
        NSMutableArray* arr = [NSMutableArray array];
        for (int i = 0; i < 16; i++) {
            NSString* tmp = [NSString stringWithFormat:@"like1-%d.png",i];
            UIImage* frameImg = [UIImage imageNamed:tmp];
            [arr addObject:frameImg];
        }
        UIImage* gif = [UIImage animatedImageWithImages:arr duration:2.0];
        _like1.image = gif;
        _like1.tag = 105;
    }
    return _like1;
}

-(UIView*)question
{
    if (!_question) {
        CGFloat x = 60;
        CGFloat y = 100;
        _question = [[question alloc] initWithFrame:CGRectZero];
        _question.qTitle = @"你最喜欢的作家？";
        _question.frame = CGRectMake(x, y, [_question getQuestionSize].width, [_question getQuestionSize].height);
        CGFloat center_x = CGRectGetMidX([[UIScreen mainScreen] bounds]);
        _question.center = CGPointMake(center_x, y);
        _question.delegate = self;
        _question.tag = 106;
    }
    return _question;

}


-(NSMutableArray*)questions
{
    if (!_questions) {
        
    }
    return _questions;
}

/**
 question delegate methods,use to handle events when question did select
 */
#pragma mark - methods implements for Qusetion
-(void)didQuestionItemsChange:(question *)question
{
    [self changeItems];

}

#pragma mark - methods implements for CLItemDelegate

- (void)tagDidAddTag:(CLItem *)tag
{
    
}

- (void)tagDidRemoveTag:(CLItem *)tag
{
    
}

- (void)tagDidLongPressedStart:(CLItem *)tag
{
    _trashView.hidden = NO;
    _unlike0.hidden = NO;
    CGFloat tag_x = tag.center.x;
    CGFloat tag_y = tag.center.y;
    oriTagCenter = CGPointMake(tag_x, tag_y);
 
    [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        tag.transform = CGAffineTransformMakeScale(2.0, 2.0);
        _trashView.center = CGPointMake(20, _trashView.center.y);
        _bookShelfView.center = CGPointMake(300, _bookShelfView.center.y);
        CGFloat w2trash = fabs(tag_x - _trashView.center.x);
        CGFloat h2trash = fabs(tag_y - _trashView.center.y);
        oriDistance_tag2trash =sqrt(pow(w2trash, 2.0) + pow(h2trash, 2.0));
        CGFloat w2bookShelf = fabs(tag_x - _bookShelfView.center.x);
        CGFloat h2bookShelf = fabs(tag_y - _bookShelfView.center.y);
        oriDistance_tag2bookshelf = sqrt(pow(w2bookShelf, 2.0) + pow(h2bookShelf, 2.0));
        oriTrashCenter = _trashView.center;
        oriBookShelfCenter = _bookShelfView.center;
    } completion:^(BOOL finished) {
        //to do
    }];
}

-(void)tagDidLongPressedEnd:(CLItem *)tag
{
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        tag.transform = CGAffineTransformMakeScale(1.0, 1.0);
        _trashView.center = CGPointMake(-30, _trashView.center.y);
        _bookShelfView.center = CGPointMake(350, _bookShelfView.center.y);
        _unlike0.center = CGPointMake(-25, _unlike0.center.y);
        _like0.center = CGPointMake(350, _like0.center.y);
        
    } completion:^(BOOL finished) {
        _trashView.backgroundColor = [UIColor darkTextColor];
        tag.alpha = 1.0;
    }];
    if (isSendToTrash) {
        [UIView animateWithDuration:1 animations:^{
            tag.hidden = YES;
        }];
        [choiceTrashSheet showInView:self.view];
    }else{
        [UIView animateWithDuration:1.0 animations:^{
            tag.center = oriTagCenter;
        }];
    }
    if (isSendToBookShelf) {
        [UIView animateWithDuration:1 animations:^{
            tag.hidden = YES;
        }];
        [choiceBookShelfSheet showInView:self.view];
    }else{
        [UIView animateWithDuration:1.0 animations:^{
            tag.center = oriTagCenter;
        }];
    }
    //最后仍需隐藏
    _trashView.hidden = YES;
    _unlike0.hidden = YES;
}

- (void)tagDidMoveTag:(CLItem*)tag withCurrentLocation:(CGPoint)tagPoint
{
    CGFloat new_tag_x = tagPoint.x;
    CGFloat new_tag_y = tagPoint.y;
    CGFloat newD_tag2Trash = sqrt(pow(fabs(new_tag_x - oriTrashCenter.x), 2.0) + pow(fabs(new_tag_y-oriTrashCenter.y), 2.0));
    CGFloat newD_tag2BookShelf = sqrt(pow(fabs(new_tag_x - oriBookShelfCenter.x), 2.0) + pow(fabs(new_tag_y-oriBookShelfCenter.y), 2.0));
    
//  tag --- trash
    if (newD_tag2Trash < oriDistance_tag2trash && new_tag_x < 160) {
        [UIView animateWithDuration:0.5 animations:^{
            
            _unlike0.center = CGPointMake(25, _unlike0.center.y);
            _trashView.backgroundColor = [UIColor redColor];
        } completion:^(BOOL finished) {

        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _unlike0.center = CGPointMake(-25, _unlike0.center.y);
            _trashView.backgroundColor = [UIColor darkTextColor];
        } completion:^(BOOL finished) {
            
        }];
    }
//  tag --- bookshelf
    if (newD_tag2BookShelf < oriDistance_tag2bookshelf && new_tag_x > 160) {
        [UIView animateWithDuration:0.5 animations:^{
            _like0.center = CGPointMake(300, _like0.center.y);
            _bookShelfView.backgroundColor = [UIColor greenColor];
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _like0.center = CGPointMake(350, _like0.center.y);
            _bookShelfView.backgroundColor = [UIColor darkTextColor];
        } completion:^(BOOL finished) {
            
        }];
    }
//  tag very close to trash
    
    if (newD_tag2Trash < 50 ) {
        [UIView animateWithDuration:0.5 animations:^{
            tag.alpha = 0.5;
        }completion:^(BOOL finished) {
            isSendToTrash = YES;
        }];
        pointToTag = tag;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            tag.alpha = 1.0;
        }];
        isSendToTrash = NO;
    }
    
//  tag very close to bookshelf
    if (newD_tag2BookShelf < 50) {
        [UIView animateWithDuration:0.5 animations:^{
            tag.alpha = 0.5;
        }completion:^(BOOL finished) {
            isSendToBookShelf = YES;
        }];
        pointToTag = tag;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            tag.alpha = 1.0;
        }];
        isSendToBookShelf = NO;
        
    }
}


#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        pointToTag.hidden = NO;
        [UIView animateWithDuration:1.0 animations:^{
            pointToTag.alpha = 1.0;
            pointToTag.center = oriTagCenter;
        }];
        isSendToBookShelf = NO;
        isSendToTrash = NO;
    }
    if (buttonIndex == 0) {
        if (isSendToBookShelf) {
           
            [_authors removeObject:pointToTag.tTitle];
           
        }
        if (isSendToTrash) {
           
            [_authors removeObject:pointToTag.tTitle];
           
        }
        pointToTag.hidden = YES;
    }
}








































#pragma mark - method for change items that show on self.view
-(void)changeItems
{
    for (UIView* view in self.view.subviews) {
        if ([view isMemberOfClass:[CLItem class]]) {
            [view removeFromSuperview];
        }
    }
    
    NSArray* itemsTmp = [self rondomkeyWordArray];
    NSMutableArray* itemsWillShowArray = [NSMutableArray array];
    for (int i = 0; i < [itemsTmp count]; i++) {
        CLItem* tag = [self TagWithTitle:[itemsTmp objectAtIndex:i] tag:i];
        tag.delegate = self;
        [itemsWillShowArray addObject:tag];
        [self.view addSubview:tag];
    }
    NSArray* frameArray = [self keyWordButtonAnimationFrameWithButtonArray:itemsWillShowArray];
    for (CLItem* tagView in [self.view subviews]) {
        if (tagView.tag < 100) {
            NSValue* value = frameArray[tagView.tag];
            CGRect tagFrame = [value CGRectValue];
            [self showPopWithPopButton:tagView showPosition:tagFrame];
        }
    }
}

- (NSArray *)rondomkeyWordArray
{
    if ([_authors count] > maxKeyWord) {
        if (isFirst) {
            isFirst = NO;
            //第一次取前十个热词
            NSArray *keyWordArray = [_authors objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 10)]];
            return keyWordArray;
        }
        else
        {
            //第二次开始随机取
            NSArray *rondomNumArray = [self rondomArrayWithCount:maxKeyWord totalCount:[_authors count]];
            NSMutableArray *rondomKeyWordArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i < maxKeyWord; i++) {
                NSString *indexStr = [rondomNumArray objectAtIndex:i];
                [rondomKeyWordArray addObject:[_authors objectAtIndex:[indexStr integerValue]]];
            }
            return rondomKeyWordArray;
        }
    }
    else
    {
        return _authors;
    }
    return nil;
}

// 取N个不同的随机数
- (NSArray *)rondomArrayWithCount:(NSInteger)arrayCount totalCount:(NSInteger)totalCount
{
    NSMutableArray *rondomArray = [[NSMutableArray alloc] initWithCapacity:0];
    do
    {
        int random = arc4random()%totalCount +0;
        
        NSString *randomString = [NSString stringWithFormat:@"%d",random];
        
        if (![rondomArray containsObject:randomString]) {
            [rondomArray addObject:randomString];
        }
        else{
            //            NSLog(@"数组中有已有该随机数，重新取数！");
        }
        
    } while (rondomArray.count != arrayCount);
    return rondomArray;
}

-(CLItem *)TagWithTitle:(NSString *)aTitle tag:(NSInteger)aTag
{
    CGFloat tag_X = SCREEN_WIDTH / 2;
    CGFloat tag_Y = 150;
    
    CLItem *myTag = [[CLItem alloc] init];
    myTag.tTitle = aTitle;
    myTag.frame = CGRectMake(tag_X, tag_Y, [myTag getTagSize].width, [myTag getTagSize].height);
    myTag.tag = aTag;
    
    return  myTag;
}

//#pragma mark - 获取动画的位移的frame
//获取10个位移后的frame
- (NSArray *)keyWordButtonAnimationFrameWithButtonArray:(NSArray *)aTagArray
{
    NSMutableArray *frameArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSArray *rowNoArray = [self keywordRowNoArray];
    NSInteger count = 0;
    
    NSInteger buttonCount = 0;
    for (int i = 0; i < [rowNoArray count]; i ++ ) {
        NSNumber *rowNo = [rowNoArray objectAtIndex:i];
        
        NSInteger button_y = (IPHONE5?20:0) + i * 20;
        
        NSMutableArray *widthArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int j = 0 ; j < [rowNo integerValue]; j++) {
            
            if ([aTagArray count] > buttonCount) {
                
                CLItem *tag = [aTagArray objectAtIndex:buttonCount];
                [widthArray addObject:[NSNumber numberWithInteger:tag.frame.size.width]];
                buttonCount ++ ;
            }
            
        }
        NSArray *xArray = [self rowKeyWordButtonAnimationWithFrameArray:widthArray];
        for (int k = 0; k < [xArray count]; k ++ ) {
            CLItem *tag = [aTagArray objectAtIndex:count];
            count ++;
            NSInteger rondomY = (arc4random() % 10) + minimum_height_tag;//随机Y
            NSNumber *xNumber = [xArray objectAtIndex:k];
            CGRect frameTemp = CGRectMake([xNumber integerValue] , button_y + rondomY , tag.frame.size.width, tag.frame.size.height );
            
            [frameArray addObject:[NSValue valueWithCGRect:frameTemp]];
            
        }
    }
    return frameArray;
}

- (NSArray *)keywordRowNoArray
{
    NSInteger keyWordNo = 10;//keyword个数
    NSInteger maxRow = 5;//最大行
    NSInteger minRow = 3;//最小行
    
    NSInteger row = (arc4random() % (maxRow - minRow +1)) + 3;
    
    NSInteger theMaxRowNo = 4;
    
    NSInteger maxRowNo = keyWordNo / minRow + 1;//每行的最大数
    NSInteger minRowNo = [self keyWordCGFloatToNSInteger:(keyWordNo - maxRowNo) / (CGFloat)(row - 1) -1] ;//最小行keyWord个数
    
    NSMutableArray * rowNoArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < row; i ++ ) {
        if (i == row - 1) {
            NSInteger rowNo = keyWordNo;
            [rowNoArray addObject:[NSNumber numberWithInteger:rowNo]];
        }
        else
        {
            NSInteger rowNo = (arc4random() % (maxRowNo - minRowNo +1)) + minRowNo;
            [rowNoArray addObject:[NSNumber numberWithInteger:rowNo]];
            
            keyWordNo -= rowNo;
            NSInteger maxRowNoTemp = keyWordNo - (row - i - 1) + 1;
            maxRowNo = maxRowNoTemp>theMaxRowNo?theMaxRowNo:maxRowNoTemp ;//每行的最大数
            minRowNo =  [self keyWordCGFloatToNSInteger:(keyWordNo - maxRowNo) / (CGFloat)(row - i - 1 - 1)] ;//最小行keyWord个数
        }
        
    }
    return rowNoArray;
}

//获取一行的三个frame  如 100 100 100
- (NSArray *)rowKeyWordButtonAnimationWithFrameArray:(NSArray *)frameArray
{
    NSMutableArray *xPointArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSInteger count = [frameArray count];
    
    NSInteger totalWidth = 0;//n个frame 加起来的宽度
    for (int i = 0; i < count; i ++ ) {
        NSNumber *Width =[frameArray objectAtIndex:i];
        totalWidth += [Width floatValue];
    }
    NSInteger subWidth = SCREEN_WIDTH - totalWidth;
    if (subWidth < 0) {
        subWidth = -subWidth;
        NSInteger xTemp = (CGFloat)random() / (CGFloat)RAND_MAX * subWidth;//(arc4random() % subWidth) + 0;
        NSInteger x = 0;
        for (int i = 0; i < count; i ++ ) {
            
            if (i != 0) {
                NSNumber *Width =[frameArray objectAtIndex:i - 1];
                x = x + [Width floatValue];
                [xPointArray addObject:[NSNumber numberWithInteger:x]];
            }
            else
            {
                //                NSNumber *Width =[frameArray objectAtIndex:0];
                x = -xTemp ;//[Width floatValue] -xTemp ;
                [xPointArray addObject:[NSNumber numberWithInteger:-xTemp]];
            }
            
        }
    }
    else
    {
        
        NSMutableArray * xTempArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < count; i ++) {
            NSInteger xTemp = (CGFloat)random() / (CGFloat)RAND_MAX * (subWidth/(count - i));//(arc4random() % subWidth) + 0;
            subWidth = subWidth - xTemp;
            [xTempArray addObject:[NSNumber numberWithInteger:xTemp]];
        }
        
        for (int k = 0; k < count; k ++ ) {
            
            if (k != 0) {
                
                NSNumber *x1 = [xPointArray objectAtIndex:k - 1];
                NSNumber *rondomX =[xTempArray objectAtIndex:k];
                
                NSNumber *prevWidth = [frameArray objectAtIndex:k-1];
                
                NSInteger x = [x1 integerValue] + [rondomX integerValue] + [prevWidth floatValue];
                [xPointArray addObject:[NSNumber numberWithInteger:x]];
            }
            else
            {
                NSInteger x = [[xTempArray objectAtIndex:0] integerValue];
                [xPointArray addObject:[NSNumber numberWithInteger:x]];
            }
            
        }
    }
    return xPointArray;
}

- (NSInteger )keyWordCGFloatToNSInteger:(CGFloat)aFloat
{
    NSInteger smallInt = aFloat;
    if (aFloat - smallInt > 0) {
        return smallInt + 1;
    }
    return smallInt;
}

//弹出动画
- (void)showPopWithPopButton:(CLItem *)aTag showPosition:(CGRect)aRect
{
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    positionAnimation.fromValue = [NSValue valueWithCGRect:aTag.frame];
    positionAnimation.toValue = [NSValue valueWithCGRect:aRect];
    positionAnimation.springBounciness = 15.0f;
    positionAnimation.springSpeed = 10.0f;
    [aTag pop_addAnimation:positionAnimation forKey:@"frameAnimation"];
}


@end
