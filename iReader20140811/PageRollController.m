//
//  BriliantPushController.m
//  iReaderWithAirbnb
//
//  Created by lcl on 1/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//
#define ROLLING_IMG_HEIGHT (150.0f)

#import "UtilityHeaders.h"
#import "PageRollController.h"

@interface PageRollController ()<UIScrollViewDelegate>
@end

@implementation PageRollController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    _imageArray = [NSArray arrayWithObjects:@"精推1",@"精推2",@"精推3",@"精推4", nil];
    
//    CGFloat scrollView_y =  CGRectGetMaxY(self.navigationController.navigationBar.frame)+ CGRectGetMaxY([UIApplication sharedApplication].statusBarFrame);
//    NSLog(@"scrollView_y is %lf",scrollView_y);
    _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), ROLLING_IMG_HEIGHT)];
    _imageScrollView.backgroundColor = bgColor;//[UIColor colorWithPatternImage:[UIImage imageNamed:@"white-tweed"]];
    _imageScrollView.showsHorizontalScrollIndicator = NO;
    _imageScrollView.bounces = YES;
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.userInteractionEnabled = YES;
    _imageScrollView.delegate = self;
//    _imageScrollView.layer.cornerRadius = 10.0f;
    
    [self.view addSubview:_imageScrollView];
    CGFloat w = self.view.frame.size.width;
    //setup UIPageControll
    _imagePageControll = [[UIPageControl alloc] init];
    _imagePageControll.center = CGPointMake(w * 0.5, ROLLING_IMG_HEIGHT-10.0f);
    _imagePageControll.bounds = CGRectMake(0, 0, 150, 50);
    _imagePageControll.numberOfPages = [_imageArray count];
    _imagePageControll.pageIndicatorTintColor = [UIColor whiteColor];// 设置非选中页的圆点颜色
    _imagePageControll.currentPageIndicatorTintColor = [UIColor grayColor];
    [_imagePageControll addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_imagePageControll];
    
    for (NSUInteger i = 0; i < [_imageArray count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:[_imageArray objectAtIndex:i] ofType:@"png"];
        UIImage* theImage = [self getPageImage:[UIImage imageWithContentsOfFile:path]
                                  scaledToSize:CGSizeMake(w, ROLLING_IMG_HEIGHT)];
        imageView.frame = CGRectMake(w * i + w, 0, w, ROLLING_IMG_HEIGHT);
        imageView.layer.cornerRadius = 10.0f;
//        NSLog(@"imageView frame is %lf %lf",imageView.frame.size.width,imageView.frame.size.height);
        imageView.image = theImage;
        [_imageScrollView addSubview:imageView];
    }
    //取数组最后一张图片，放到第0页
    NSString* path = [[NSBundle mainBundle] pathForResource:[_imageArray objectAtIndex:([_imageArray count]-1)]
                                                     ofType:@"png"];
    
    UIImage* firstImage = [self getPageImage:[UIImage imageWithContentsOfFile:path]
                                scaledToSize:CGSizeMake(w, ROLLING_IMG_HEIGHT)];
    UIImageView* firstImgView = [[UIImageView alloc] initWithImage:firstImage];
    firstImgView.frame = CGRectMake(0, 0, w, ROLLING_IMG_HEIGHT);
    firstImgView.layer.cornerRadius = 10.0f;
    firstImgView.image = firstImage;
    [_imageScrollView addSubview:firstImgView];
    
    
    //取数组第一张图片放到最后一页
    path = [[NSBundle mainBundle] pathForResource:[_imageArray objectAtIndex:0] ofType:@"png"];
    UIImage* endImage = [self getPageImage:[UIImage imageWithContentsOfFile:path]
                                scaledToSize:CGSizeMake(w, ROLLING_IMG_HEIGHT)];
    UIImageView* endImgView = [[UIImageView alloc] initWithImage:endImage];
    endImgView.frame = CGRectMake(w * ([_imageArray count] + 1), 0, w, ROLLING_IMG_HEIGHT);
    endImgView.layer.cornerRadius = 10.0f;
    endImgView.image = endImage;
    [_imageScrollView addSubview:endImgView];
    
    [_imageScrollView setContentSize:CGSizeMake(w * ([_imageArray count] + 2), ROLLING_IMG_HEIGHT)];
    [_imageScrollView scrollRectToVisible:CGRectMake(w,0,w,ROLLING_IMG_HEIGHT) animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIImage*)getPageImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    //    UIGraphicsBeginImageContextWithOptions(newSize, NO,0.0);
    [image drawInRect:CGRectMake(0,0, newSize.width, newSize.height)];
    UIImage*newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


#pragma mark - UIPageControl change Page
// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = (int)_imagePageControll.currentPage; // 获取当前的page
//    NSLog(@"ROOTVIEW_WIDTH is %lf",ROOTVIEW_WIDTH);
    [_imageScrollView scrollRectToVisible:CGRectMake(ROOTVIEW_WIDTH*(page+1),0,ROOTVIEW_WIDTH,ROLLING_IMG_HEIGHT) animated:NO];
}

- (void)runTimePage
{
    int page = (int)_imagePageControll.currentPage; // 获取当前的page
    page++;
    page = page > 3 ? 0 : page ;
    _imagePageControll.currentPage = page;
    [self turnPage];
}

#pragma mark - UIScrollView Delegate
#pragma mark - 当scrollView正在滚动的时候调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
//    int page = floor(scrollView.contentOffset.x / pageWidth)
//    NSLog(@"%d",page);
    int page = floor((scrollView.contentOffset.x - pageWidth/([_imageArray count]+2))/pageWidth) + 1;
    page--;
    _imagePageControll.currentPage = page;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pageWidth/ ([_imageArray count]+2)) / pageWidth) + 1;
    if (currentPage==0)
    {
        [scrollView scrollRectToVisible:CGRectMake(ROOTVIEW_WIDTH * [_imageArray count],0,ROOTVIEW_WIDTH,ROLLING_IMG_HEIGHT) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([_imageArray count]+1))
    {
        [scrollView scrollRectToVisible:CGRectMake(ROOTVIEW_WIDTH,0,ROOTVIEW_WIDTH,ROLLING_IMG_HEIGHT) animated:NO]; // 最后+1,循环第1页
    }
}


@end
