//
//  CLAlbumRichTextView.m
//  DynamiInfo
//
//  Created by lcl on 7/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "CLAlbumRichTextView.h"
#import "CLMessageAvatorFactory.h"
#import "CLAlbumPhotoCollectionViewCell.h"
#import "CLAlbumCollectionViewFlowLayout.h"
#import "CLImageViewer.h"
#import "UIImage+CLRounded.h"
#import "CLAlbumShareBookTableViewCell.h"
#import "ShareBookView.h"

#define kCLPhotoCollectionViewCellIdentifier @"CLPhotoCollectionViewCellIdentifier"

@interface CLAlbumRichTextView () //<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *avatorImageView;
@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) UICollectionView *sharePhotoCollectionView;

@property (nonatomic, strong) UILabel *timestampLabel;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UILabel *commentCounter;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UILabel* likeCounter;
@property (nonatomic, strong) ShareBookView* shareBookView;
@property (nonatomic, strong) UIImageView* likeImgView;

@property (nonatomic) NSUInteger tapped;

@end


@implementation CLAlbumRichTextView

+ (CGFloat)getRichTextHeightWithText:(NSString *)text {
    if (!text || !text.length)
        return 0;
    return [SETextView frameRectWithAttributtedString:[[NSAttributedString alloc] initWithString:text]
                                       constraintSize:CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - kCLAvatarImageSize - (kCLAlbumAvatorSpacing * 3), CGFLOAT_MAX)
                                          lineSpacing:kCLAlbumContentLineSpacing
                                                 font:kCLAlbumContentFont].size.height;
}

+ (CGFloat)getSharePhotoCollectionViewHeightWithPhotos:(NSArray *)photos {
    // 上下间隔已经在frame上做了
    NSInteger row = (photos.count / 3 + (photos.count % 3 ? 1 : 0));
    return (row * (kCLAlbumPhotoSize) + ((row - 1) * kCLAlbumPhotoInsets));
}

+ (CGFloat)calculateRichTextHeightWithAlbum:(CLAlbum *)currentAlbum {
    CGFloat richTextHeight = kCLAlbumAvatorSpacing * 2;
    
    richTextHeight += kCLAlbumUserNameHeigth;
    
    richTextHeight += kCLAlbumContentLineSpacing;
    richTextHeight += [self getRichTextHeightWithText:currentAlbum.albumShareContent];
    
    richTextHeight += kCLAlbumPhotoInsets;
//    richTextHeight += [self getSharePhotoCollectionViewHeightWithPhotos:currentAlbum.albumSharePhotos];
    richTextHeight += 120;
    
    richTextHeight += kCLAlbumContentLineSpacing;
    richTextHeight += kCLAlbumCommentButtonHeight;
    
    return richTextHeight;
}

#pragma mark - Propertys

- (void)setDisplayAlbum:(CLAlbum *)displayAlbum {
    if (!displayAlbum)
        return;
    _displayAlbum = displayAlbum;
    
    self.userNameLabel.text = displayAlbum.userName;
    
    self.richTextView.attributedText = [[NSAttributedString alloc] initWithString:displayAlbum.albumShareContent];
    
    self.timestampLabel.text = @"3小时前";
    self.tapped = 0;
    self.likeCounter.text = @"5";
    self.commentCounter.text = @"2";
//    [self.sharePhotoCollectionView reloadData];
    
    [self setNeedsLayout];
}



-(UIView*)shareBookView
{
    if (!_shareBookView) {
//        NSLog(@"%@",NSStringFromSelector(_cmd));
        
        CGFloat shareBookViewX = CGRectGetMaxX(self.avatorImageView.frame) + kCLAlbumAvatorSpacing;
        CGFloat shareBookViewY = CGRectGetMaxY(self.richTextView.frame) + kCLAlbumPhotoInsets;
        CGFloat shareBookViewWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - kCLAvatarImageSize - kCLAlbumAvatorSpacing*3;
        CGFloat shareBookViewHeight= 120;
        _shareBookView = [[ShareBookView alloc] initWithFrame:CGRectMake(shareBookViewX, shareBookViewY, shareBookViewWidth, shareBookViewHeight)];
        _shareBookView.backgroundColor = [UIColor colorWithRed:0.390 green:0.820 blue:0.764 alpha:1.000];
        
        UIView* share = [[UIView alloc] initWithFrame:_shareBookView.frame];
        
//        NSLog(@"shareBookViewFrame is %@ in %@",NSStringFromCGRect(self.shareBookView.frame),NSStringFromSelector(_cmd));
        CGFloat ImgWidth = CGRectGetWidth(share.frame) / 3.0;
        UIImageView* sharebookImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, ImgWidth-10, CGRectGetHeight(share.frame)-10)];
        sharebookImage.image =[UIImage imageNamed:@"rb3"];
        [self.shareBookView addSubview:sharebookImage];
        
        CGFloat BookNameWidth = (CGRectGetWidth(share.frame) - ImgWidth)-5;
        CGFloat BookNameHeight = CGRectGetHeight(share.frame) /4.0;
        CGFloat BookNameX = sharebookImage.frame.size.width + 5.0;
        UILabel *shareBookName = [[UILabel alloc] initWithFrame:CGRectMake(BookNameX+5, 5, BookNameWidth, BookNameHeight)];
        shareBookName.text = @"背包十年";
        shareBookName.textColor = [UIColor whiteColor];
        shareBookName.textAlignment = NSTextAlignmentLeft;
        shareBookName.font = [UIFont boldSystemFontOfSize:16];
//        shareBookName.backgroundColor = [UIColor greenColor];
        [self.shareBookView addSubview:shareBookName];
        
        CGFloat BookAuthorHeight = BookNameHeight / 2.0;
        CGFloat BookAuthorX = shareBookName.frame.origin.x;
        CGFloat BookAuthorY = shareBookName.frame.origin.y + BookNameHeight + 5;
        UILabel* shareBookAuthor = [[UILabel alloc] initWithFrame:CGRectMake(BookAuthorX,BookAuthorY , BookNameWidth, BookAuthorHeight)];
//        shareBookAuthor.backgroundColor = [UIColor yellowColor];
        shareBookAuthor.text = @"小鹏";
        shareBookAuthor.textColor = [UIColor whiteColor];
        shareBookAuthor.textAlignment = NSTextAlignmentLeft;
        shareBookAuthor.font = [UIFont boldSystemFontOfSize:(BookAuthorHeight-1.0)];
        [self.shareBookView addSubview:shareBookAuthor];
        
        CGFloat BookDescriptionWidth = BookNameWidth;
        CGFloat BookDescriptionHeight = CGRectGetMaxY(sharebookImage.frame) - BookNameHeight - BookAuthorHeight -15;
        UILabel *shareBookDescription = [[UILabel alloc] initWithFrame:CGRectMake(BookNameX +5, BookAuthorY + BookAuthorHeight + 5, BookDescriptionWidth , BookDescriptionHeight)];
        shareBookDescription.text = @"每个年轻人都该看的一本书，为叛逆的灵魂找个出口，从菜鸟背包到职业旅行家，一百万个男孩愿意为了这份工作“去死”！出走十年，永远年轻，永远在路上，永远热泪盈眶";//@"世人眼中堕落女人萨拉，抑郁成瘾，生活在保守的英国小镇上，大家都叫她“法国中尉的女人”";
//        shareBookDescription.backgroundColor = [UIColor orangeColor];
        shareBookDescription.textColor = [UIColor whiteColor];
        shareBookDescription.textAlignment = NSTextAlignmentLeft;
        shareBookDescription.font = [UIFont boldSystemFontOfSize:12];
        shareBookDescription.numberOfLines = 0;
        
        [self.shareBookView addSubview:shareBookDescription];
        

    }
    return _shareBookView;
}

- (UIImageView *)avatorImageView {
    if (!_avatorImageView) {
        _avatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kCLAlbumAvatorSpacing, kCLAlbumAvatorSpacing, kCLAvatarImageSize, kCLAvatarImageSize)];
        _avatorImageView.image = [UIImage imageNamed:@"showgirl2"];
        _avatorImageView.layer.cornerRadius = (_avatorImageView.frame.size.height)/2.0;
        _avatorImageView.clipsToBounds = YES;
    }
    return _avatorImageView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        CGFloat userNameLabelX = CGRectGetMaxX(self.avatorImageView.frame) + kCLAlbumAvatorSpacing;
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(userNameLabelX, CGRectGetMinY(self.avatorImageView.frame), CGRectGetWidth([[UIScreen mainScreen] bounds]) - userNameLabelX - kCLAlbumAvatorSpacing, kCLAlbumUserNameHeigth)];
        _userNameLabel.backgroundColor = [UIColor clearColor];
        _userNameLabel.textColor = [UIColor colorWithRed:0.294 green:0.595 blue:1.000 alpha:1.000];
        
    }
    return _userNameLabel;
}

- (SETextView *)richTextView {
    if (!_richTextView) {
        _richTextView = [[SETextView alloc] initWithFrame:self.bounds];
        _richTextView.backgroundColor = [UIColor clearColor];
        _richTextView.font = self.font;
        _richTextView.textColor = self.textColor;
        _richTextView.textAlignment = self.textAlignment;
        _richTextView.lineSpacing = self.lineSpacing;
        _richTextView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:245.0/255.0 blue:228.0/255.0 alpha:1.0];
        _richTextView.layer.borderWidth = 1.0;
        _richTextView.layer.borderColor = [UIColor colorWithRed:249.0/255.0 green:231.0/255.0 blue:207.0/255.0 alpha:1.0].CGColor;
        _richTextView.layer.cornerRadius = 4.0;
        _richTextView.clipsToBounds = YES;
    }
    return _richTextView;
}

//- (UICollectionView *)sharePhotoCollectionView {
//    if (!_sharePhotoCollectionView) {
//        _sharePhotoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[CLAlbumCollectionViewFlowLayout alloc] init]];
//        _sharePhotoCollectionView.backgroundColor = [UIColor clearColor];//self.richTextView.backgroundColor;
//        [_sharePhotoCollectionView registerClass:[CLAlbumPhotoCollectionViewCell class] forCellWithReuseIdentifier:kCLPhotoCollectionViewCellIdentifier];
//        [_sharePhotoCollectionView setScrollsToTop:NO];
////        _sharePhotoCollectionView.delegate = self;
////        _sharePhotoCollectionView.dataSource = self;
//    }
//    return _sharePhotoCollectionView;
//}

- (UILabel *)timestampLabel {
    if (!_timestampLabel) {
        _timestampLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timestampLabel.backgroundColor = [UIColor clearColor];
        _timestampLabel.font = [UIFont systemFontOfSize:11];
        _timestampLabel.textColor = [UIColor grayColor];
    }
    return _timestampLabel;
}


- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_commentButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
//        [_commentButton setImage:[UIImage imageNamed:@"AlbumOperateMoreHL"] forState:UIControlStateHighlighted];
        [_commentButton addTarget:self action:@selector(commentBtnTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}

-(UILabel*)commentCounter{
    if (!_commentCounter) {
        _commentCounter = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentCounter.textAlignment = NSTextAlignmentCenter;
        _commentCounter.backgroundColor = [UIColor clearColor];
        _commentCounter.textColor = [UIColor grayColor];
        _commentCounter.font = [UIFont systemFontOfSize:11];
    }
    return _commentCounter;
}

-(UIButton*)likeButton
{
    if (!_likeButton) {
        _likeButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_likeButton setImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal];
        [_likeButton addTarget:self action:@selector(singleTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeButton;
}


-(UILabel*)likeCounter
{
    if (!_likeCounter) {
        _likeCounter = [[UILabel alloc] initWithFrame:CGRectZero];
//        _likeCounter.text = [NSString stringWithFormat:@""];
        _likeCounter.textAlignment = NSTextAlignmentCenter;
        _likeCounter.backgroundColor = [UIColor clearColor];
        _likeCounter.textColor = [UIColor grayColor];
        _likeCounter.font = [UIFont systemFontOfSize:11];
    }
    return _likeCounter;
}


#pragma mark - Life Cycle

- (void)setup {
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    self.font = kCLAlbumContentFont;
    self.textColor = [UIColor blackColor];
    self.textAlignment = NSTextAlignmentLeft;
    self.lineSpacing = kCLAlbumContentLineSpacing;
    
    [self addSubview:self.avatorImageView];
    [self addSubview:self.userNameLabel];
    
    [self addSubview:self.richTextView];
//    [self addSubview:self.sharePhotoCollectionView];
    [self addSubview:self.shareBookView];
    
    [self addSubview:self.timestampLabel];
    [self addSubview:self.likeButton];
    [self addSubview:self.likeCounter];
    [self addSubview:self.commentButton];
    [self addSubview:self.commentCounter];
    self.userInteractionEnabled = YES;
}

- (id)initWithFrame:(CGRect)frame {
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)dealloc {
    self.font = nil;
    self.textColor = nil;
    self.richTextView = nil;
    _displayAlbum = nil;
    self.shareBookView = nil;
    self.avatorImageView = nil;
    self.userNameLabel = nil;
    self.sharePhotoCollectionView.delegate = nil;
    self.sharePhotoCollectionView.dataSource = nil;
    self.sharePhotoCollectionView = nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    CGFloat richTextViewX = CGRectGetMinX(self.userNameLabel.frame);
    CGRect richTextViewFrame = CGRectMake(richTextViewX, CGRectGetMaxY(self.userNameLabel.frame) + kCLAlbumContentLineSpacing, CGRectGetWidth([[UIScreen mainScreen] bounds]) - richTextViewX - kCLAlbumAvatorSpacing, [CLAlbumRichTextView getRichTextHeightWithText:self.displayAlbum.albumShareContent]);
    self.richTextView.frame = richTextViewFrame;
//    NSLog(@"self.richTextView.frame is %@",NSStringFromCGRect(self.richTextView.frame));
    
    
//    CGRect sharePhotoCollectionViewFrame = CGRectMake(richTextViewX, CGRectGetMaxY(richTextViewFrame) + kCLAlbumPhotoInsets, kCLAlbumPhotoInsets * 4 + kCLAlbumPhotoSize * 3, [CLAlbumRichTextView getSharePhotoCollectionViewHeightWithPhotos:self.displayAlbum.albumSharePhotos]);
//    self.sharePhotoCollectionView.frame = sharePhotoCollectionViewFrame;
    
//    NSLog(@"%lf",CGRectGetMaxY(sharePhotoCollectionViewFrame));
//    NSLog(@"%lf",CGRectGetWidth([[UIScreen mainScreen] bounds])-kCLAlbumAvatorSpacing);
    
    CGRect shareBookViewFrame = CGRectMake(richTextViewX, CGRectGetMaxY(richTextViewFrame) + kCLAlbumPhotoInsets, CGRectGetWidth([[UIScreen mainScreen] bounds]) - richTextViewX - kCLAlbumAvatorSpacing, 120);
    self.shareBookView.frame = shareBookViewFrame;
//    NSLog(@"shareBookViewFrame is %@ in %@",NSStringFromCGRect(self.shareBookView.frame),NSStringFromSelector(_cmd));
    
    
    CGRect likeCounterFrame = self.likeCounter.frame;
    likeCounterFrame.origin = CGPointMake(CGRectGetWidth(self.bounds) - kCLAlbumAvatorSpacing - kCLAlbumCommentButtonWidth, CGRectGetMaxY(shareBookViewFrame) + kCLAlbumContentLineSpacing);
    likeCounterFrame.size = CGSizeMake(kCLAlbumCommentButtonWidth, kCLAlbumCommentButtonHeight);
    self.likeCounter.frame = likeCounterFrame;
    
    CGFloat padding = 4;
    CGRect likeBtnFrame = self.likeButton.frame;
    CGFloat likeBtnFrameOri_x = CGRectGetMinX(likeCounterFrame) - kCLAlbumCommentButtonWidth ;
    CGFloat likeBtnFrameOri_y = CGRectGetMinY(likeCounterFrame) ;
    likeBtnFrame.origin = CGPointMake(likeBtnFrameOri_x, likeBtnFrameOri_y);
    likeBtnFrame.size = CGSizeMake(kCLAlbumCommentButtonWidth, kCLAlbumCommentButtonHeight);
    self.likeButton.frame = likeBtnFrame;
    self.likeButton.imageEdgeInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
    
    CGRect commentButtonFrame = self.commentButton.frame;
    CGFloat commentBtnOri_x = likeBtnFrameOri_x - kCLAlbumCommentButtonWidth * 2;
    CGFloat commentBtnOri_y = likeBtnFrameOri_y;
    commentButtonFrame.origin = CGPointMake(commentBtnOri_x,commentBtnOri_y);
    commentButtonFrame.size = CGSizeMake(kCLAlbumCommentButtonWidth, kCLAlbumCommentButtonHeight);
    self.commentButton.frame = commentButtonFrame;
//    self.commentButton.backgroundColor = [UIColor greenColor];
//    NSLog(@"self.commentButton.frame is %@",NSStringFromCGRect(self.commentButton.frame));
    
    CGRect commentLabelFrame = self.commentCounter.frame;
    CGFloat commentLabel_x = CGRectGetMaxX(commentButtonFrame);
    CGFloat commentLabel_y = commentBtnOri_y;
    commentLabelFrame.origin = CGPointMake(commentLabel_x, commentLabel_y);
    commentLabelFrame.size = CGSizeMake(kCLAlbumCommentButtonWidth, kCLAlbumCommentButtonHeight);
    self.commentCounter.frame = commentLabelFrame;
//    self.commentCounter.backgroundColor = [UIColor orangeColor];
    
    CGRect timestampLabelFrame = self.timestampLabel.frame;
    timestampLabelFrame.origin = CGPointMake(CGRectGetMinX(richTextViewFrame), CGRectGetMinY(commentButtonFrame));
    timestampLabelFrame.size = CGSizeMake(CGRectGetWidth(self.bounds) - kCLAlbumAvatorSpacing * 3 - kCLAvatarImageSize - kCLAlbumCommentButtonWidth-130, CGRectGetHeight(commentButtonFrame));
    self.timestampLabel.frame = timestampLabelFrame;
//    self.timestampLabel.backgroundColor = [UIColor blueColor];
//    NSLog(@"self.timestampLabel.frame is %@",NSStringFromCGRect(self.timestampLabel.frame));
    
    
//    CGRect likeImgViewFrame = self.likeImgView.frame;
//    likeImgViewFrame.origin = CGPointMake(commentButtonFrame.origin.x - 80,timestampLabelFrame.origin.y+3);
//    likeImgViewFrame.size = CGSizeMake(kCLAlbumCommentButtonWidth-5, kCLAlbumCommentButtonHeight-5);
//    self.likeImgView.frame = likeImgViewFrame;
//    self.likeImgView.userInteractionEnabled = YES;
//    
//    CGRect likeCounterFrame = self.likeCounter.frame;
//    likeCounterFrame.origin = CGPointMake(likeImgViewFrame.origin.x + kCLAlbumCommentButtonWidth,timestampLabelFrame.origin.y);
//    likeCounterFrame.size = CGSizeMake(50, 25);
//    self.likeCounter.frame = likeCounterFrame;
    
    
    CGRect frame = self.frame;
    frame.size.height = CGRectGetMaxY(commentButtonFrame);
    self.frame = frame;
}

#pragma mark Btn clicked
-(void)singleTap
{
    int value = [self.likeCounter.text intValue];
    if (self.tapped==0) {
        
        [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal] ;
            self.likeButton.transform = CGAffineTransformMakeScale(2.0, 2.0);
            self.likeButton.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.likeButton.transform = CGAffineTransformMakeScale(1.5, 1.5);
                self.likeButton.alpha = 0;
            }completion:^(BOOL finished){
                self.likeButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
                self.likeButton.alpha = 1.0;
            }];
        }];
        value = value + 1;
        self.likeCounter.text = [NSString stringWithFormat:@"%d",value];
        self.tapped = self.tapped + 1;
    }else{
        self.tapped = 0;
        [self.likeButton setImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal] ;
        value = value - 1;
        if(value == 0)
            self.likeCounter.text = [NSString stringWithFormat:@""];
        else
            self.likeCounter.text = [NSString stringWithFormat:@"%d",value];
    }
    
}

-(void)commentBtnTap
{
    
}

#pragma mark sharebookView init
//-(void)setUpShareBookView
//{
//    UIView* share = [[UIView alloc] initWithFrame:self.shareBookView.frame];
//    
//    CGFloat ImgWidth = CGRectGetWidth(share.frame)/ 3.0;
//    UIImageView* sharebookImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, ImgWidth-10, CGRectGetHeight(share.frame)-10)];
//    sharebookImage.image =[UIImage imageNamed:@"1"];
//    
//    [self.shareBookView addSubview:sharebookImage];
//    
//    CGFloat BookNameWidth = (CGRectGetWidth(share.frame) - ImgWidth)-5;
//    CGFloat BookNameHeight = CGRectGetHeight(share.frame)/4.0;
//    CGFloat BookNameX = sharebookImage.frame.size.width + 5.0;
//    UILabel *shareBookName = [[UILabel alloc] initWithFrame:CGRectMake(BookNameX+5, 5, BookNameWidth, BookNameHeight)];
//    shareBookName.text = @"法国中尉的女人";
//    shareBookName.textColor = [UIColor whiteColor];
//    shareBookName.textAlignment = NSTextAlignmentLeft;
//    shareBookName.font = [UIFont boldSystemFontOfSize:16];
//    shareBookName.backgroundColor = [UIColor greenColor];
//    [self.shareBookView addSubview:shareBookName];
//    
//    
//    //    CGFloat BookAuthorWidth = BookNameWidth - 5.0;
//    CGFloat BookAuthorHeight = BookNameHeight / 2.0;
//    CGFloat BookAuthorX = shareBookName.frame.origin.x;
//    CGFloat BookAuthorY = shareBookName.frame.origin.y + BookNameHeight + 5;
//    UILabel* shareBookAuthor = [[UILabel alloc] initWithFrame:CGRectMake(BookAuthorX,BookAuthorY , BookNameWidth, BookAuthorHeight)];
//    shareBookAuthor.backgroundColor = [UIColor yellowColor];
//    shareBookAuthor.text = @"[英]约翰•福尔斯";
//    shareBookAuthor.textColor = [UIColor whiteColor];
//    shareBookAuthor.textAlignment = NSTextAlignmentLeft;
//    shareBookAuthor.font = [UIFont boldSystemFontOfSize:(BookAuthorHeight-1.0)];
//    [self.shareBookView addSubview:shareBookAuthor];
//    
//    
//    CGFloat BookDescriptionWidth = BookNameWidth;
//    CGFloat BookDescriptionHeight = CGRectGetMaxY(sharebookImage.frame) - BookNameHeight - BookAuthorHeight -15;
//    UILabel *shareBookDescription = [[UILabel alloc] initWithFrame:CGRectMake(BookNameX +5, BookAuthorY + BookAuthorHeight + 5, BookDescriptionWidth , BookDescriptionHeight)];
//    shareBookDescription.text = @"世人眼中堕落女人萨拉，抑郁成瘾，生活在保守的英国小镇上，大家都叫她“法国中尉的女人”";
//    shareBookDescription.backgroundColor = [UIColor orangeColor];
//    shareBookDescription.textColor = [UIColor whiteColor];
//    shareBookDescription.textAlignment = NSTextAlignmentLeft;
//    shareBookDescription.font = [UIFont boldSystemFontOfSize:12];
//    shareBookDescription.numberOfLines = 0;
//    
//    [self.shareBookView addSubview:shareBookDescription];
//    self.shareBookView.backgroundColor = [UIColor grayColor];
////    [self.shareBookView addSubview:share];
//}


//#pragma mark - UITableView DataSource
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}

//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CLAlbumShareBookTableViewCell* cell = [(CLAlbumShareBookTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"CLAlbumShareBookTableViewCell" forIndexPath:indexPath]];
//    //    self.imageView.image = [UIImage imageNamed:@"1"];
//    //    self.textLabel.text = @"法国中尉的女人";
//    // /[英]约翰•福尔斯
//    //    self.detailTextLabel.text = @"世人眼中堕落女人萨拉，抑郁成瘾，生活在保守的英国小镇上，大家都叫她“法国中尉的女人”";
//    if (!cell) {
//        cell = [[CLAlbumShareBookTableViewCell alloc] initWithFrame:CGRectZero];
//    }
//    cell.shareBookAuthor.text = @"/[英]约翰•福尔斯";
//    cell.shareBookDescription.text = @"世人眼中堕落女人萨拉，抑郁成瘾，生活在保守的英国小镇上，大家都叫她“法国中尉的女人”";
//    cell.sharebookImage.image =[UIImage imageNamed:@"1"];
//    cell.shareBookName.text = @"法国中尉的女人";
//    return cell;
//}



//#pragma mark - UICollectionView DataSource
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.displayAlbum.albumSharePhotos.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CLAlbumPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCLPhotoCollectionViewCellIdentifier forIndexPath:indexPath];
//    
//    cell.indexPath = indexPath;
//    
//    return cell;
//}
//
//#pragma mark - UICollectionView Delegate
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [self showImageViewerAtIndexPath:indexPath];
//}
//
//- (void)showImageViewerAtIndexPath:(NSIndexPath *)indexPath {
//    CLAlbumPhotoCollectionViewCell *cell = (CLAlbumPhotoCollectionViewCell *)[self.sharePhotoCollectionView cellForItemAtIndexPath:indexPath];
//    
//    NSMutableArray *imageViews = [NSMutableArray array];
//    
//    NSArray *visibleCell = [self.sharePhotoCollectionView visibleCells];
//    
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"indexPath" ascending:YES];
//    
//    visibleCell = [visibleCell sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
//    
//    [visibleCell enumerateObjectsUsingBlock:^(CLAlbumPhotoCollectionViewCell *cell, NSUInteger idx, BOOL *stop) {
//        [imageViews addObject:cell.photoImageView];
//    }];
//    
//    CLImageViewer *imageViewer = [[CLImageViewer alloc] init];
//    [imageViewer showWithImageViews:imageViews selectedView:cell.photoImageView];
//}

@end
