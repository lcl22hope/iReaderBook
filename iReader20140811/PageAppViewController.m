//
//  PageAppViewController.m
//  TestPageDemo
//
//  Created by lcl on 18/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "PageAppViewController.h"
#import "ContentViewController.h"
#import "EPubBook.h"
#import "PannelMenu.h"
#import "KxMenu.h"

@interface PageAppViewController ()<UIGestureRecognizerDelegate,UITabBarDelegate>
@property (strong,nonatomic) UIPageViewController* pageController;
@property (strong,nonatomic) NSArray* pageContent;
@property (strong,nonatomic) PannelMenu* pannelMenu;
@end
@implementation PageAppViewController
{
    BOOL isHiddenSetting;
    UIButton* buy;
    UIButton* commemtBtn;
    UIButton* store;
    UIButton* other;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatContentPages];
    NSDictionary* options = [NSDictionary dictionaryWithObject:
                             [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                  forKey:UIPageViewControllerOptionSpineLocationKey];
    self.pageController = [[UIPageViewController alloc]
                           initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                             navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                           options:options];
    self.pageController.dataSource = self;
    self.pageController.view.frame = self.view.bounds;
    ContentViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray* viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController didMoveToParentViewController:self];
    
    UITapGestureRecognizer* showSettingRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSetting:)];
    showSettingRecognizer.numberOfTapsRequired = 1;
    showSettingRecognizer.numberOfTouchesRequired = 1;
    showSettingRecognizer.delegate = self;
    [self.view addGestureRecognizer:showSettingRecognizer];
    isHiddenSetting = YES;
    
    
    self.pannelMenu = [[PannelMenu alloc] initWithFrame:CGRectMake(0, 508, 320, 60)];
    [self.view addSubview:self.pannelMenu];
    
    [self setNavigationBar];
}

//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    for (UIView* view in self.navigationController.navigationBar.subviews) {
//        if ([view isKindOfClass:[UIButton class]]) {
//            [view removeFromSuperview];
//        }
//    }
//}

//为什么这里就行，上面就不行呢？
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    for (UIView* view in self.navigationController.navigationBar.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
}


#pragma mark - initData
-(void)creatContentPages
{
    NSString *bookPath = [[NSBundle mainBundle] pathForResource:@"情人无泪" ofType:@"epub"];
    EPubBook* epub = [[EPubBook alloc] initWithEPubBookPath:bookPath];
    self.pageContent = [[NSArray alloc] initWithArray:epub.spineArray];
}

-(ContentViewController*)viewControllerAtIndex:(NSUInteger)index
{
    // Return the data view controller for the given index.
    if (([self.pageContent count] == 0) ||
        (index >= [self.pageContent count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    ContentViewController *dataViewController = [[ContentViewController alloc] init];
    dataViewController.dataObject = [self.pageContent objectAtIndex:index];
    return dataViewController;
}

-(NSUInteger)indexOfViewController:(ContentViewController*)viewController
{
    return [self.pageContent indexOfObject:viewController.dataObject];
}

#pragma mark - UIPageViewController dataSource

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}


-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageContent count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

#pragma mark - Tap Gestures
-(void)showSetting:(UITapGestureRecognizer*)gestureRecognizer
{
    if (isHiddenSetting) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
            self.pannelMenu.alpha = 0.0;
            self.navigationController.navigationBar.alpha = 0.0;
        } completion:^(BOOL finished) {
            //TO do
        }];
        isHiddenSetting = NO;
    }else{
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
            self.pannelMenu.alpha = 1;
            self.navigationController.navigationBar.alpha = 1;
        } completion:^(BOOL finished) {
            //TO do
        }];
        isHiddenSetting = YES;
    }

}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - setNavigationBar
-(void)setNavigationBar
{
//  1.other
    other = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat w = CGRectGetWidth(self.view.bounds);
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    other.frame = CGRectMake(w-h-5, 0, h, h);
//    other.backgroundColor = [UIColor yellowColor];
    [other setBackgroundImage:[UIImage imageNamed:@"item0"] forState:UIControlStateNormal];
    [other addTarget:self action:@selector(showOtherMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:other];
    
//  2.store
    store = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat store_x = CGRectGetMinX(other.frame) - h;
    store.frame = CGRectMake(store_x, 0, h, h);
    [store setBackgroundImage:[UIImage imageNamed:@"item1"] forState:UIControlStateNormal];
    [store addTarget:self action:@selector(openStore:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:store];
//    store.backgroundColor = [UIColor yellowColor];
    
//  3.commemtBtn
    commemtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat commemtBtn_x = CGRectGetMinX(store.frame) - h;
    commemtBtn.frame = CGRectMake(commemtBtn_x, 0, h, h);
    [commemtBtn setBackgroundImage:[UIImage imageNamed:@"item2"] forState:UIControlStateNormal];
    [commemtBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:commemtBtn];
//    commemtBtn.backgroundColor = [UIColor redColor];
    
//  4.buy
    buy = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat buy_x = CGRectGetMinX(commemtBtn.frame) - 10-h;
    buy.frame = CGRectMake(buy_x, 5, h + 10, h - 10);
    buy.layer.borderWidth = 2;
    buy.layer.borderColor = [UIColor orangeColor].CGColor;
    buy.layer.cornerRadius = 2;
    [buy setTitle:@"购买" forState:UIControlStateNormal];
    [buy addTarget:self action:@selector(buyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:buy];
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor darkTextColor];
//    self.navigationController.navigationBar.alpha = 0.5;

   

}


#pragma mark - action for navigationbar
-(void)buyBtnClicked:(id)sender
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

-(void)openStore:(id)sender
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

-(void)commentBtnClicked:(id)sender
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

-(void)showOtherMenu:(UIButton*)sender
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"书签"
                     image:[UIImage imageNamed:@"bookmark"]
                    target:nil
                    action:NULL],
      
      [KxMenuItem menuItem:@"搜索"
                     image:[UIImage imageNamed:@"search_icon"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"分享"
                     image:[UIImage imageNamed:@"action_icon"]
                    target:self
                    action:@selector(pushMenuItem:)],
    
      ];
    
    KxMenuItem *first = menuItems[0];
//    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentLeft;
    
    [KxMenu showMenuInView:self.view.superview.superview
                  fromRect:sender.frame
                 menuItems:menuItems];
}

- (void) pushMenuItem:(id)sender
{
    NSLog(@"%@", sender);
}

#pragma mark - status Bar hidden
- (BOOL)prefersStatusBarHidden
{
    if (isHiddenSetting) {
        return YES;
    }else{
        return NO;
    }
    
}

@end
