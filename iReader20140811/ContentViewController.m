//
//  ContentViewController.m
//  TestPageDemo
//
//  Created by lcl on 18/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "ContentViewController.h"
#import "EPubChapter.h"

@interface ContentViewController()

@end

@implementation ContentViewController

#pragma mark - init methods
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:230.0/255.0 blue:195.0/255.0 alpha:1.0];
        CGFloat h = CGRectGetHeight(self.view.bounds) - 44;
        self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, 320, h)];
        self.webview.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:230.0/255.0 blue:195.0/255.0 alpha:1.0];
        self.webview.opaque = NO;
        self.webview.scrollView.frame = CGRectMake(0, 0, 320, h);
//        self.webview.scrollView.pagingEnabled = YES;
        [self.view addSubview:self.webview];
        
//        UITapGestureRecognizer* openSettingRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openSetting:)];
//        openSettingRecognizer.numberOfTapsRequired = 1;
//        openSettingRecognizer.numberOfTouchesRequired = 1;
//            openSettingRecognizer.delegate = self;
//        
//        UITapGestureRecognizer* closeSettingRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSetting:)];
//        closeSettingRecognizer.numberOfTapsRequired = 2;
//        closeSettingRecognizer.numberOfTouchesRequired = 1;
//            closeSettingRecognizer.delegate = self;
//        
//        [openSettingRecognizer requireGestureRecognizerToFail:closeSettingRecognizer];
//        
//
//        [self.webview addGestureRecognizer:openSettingRecognizer];
//        [self.webview addGestureRecognizer:closeSettingRecognizer];


    
    }
    return self;
}

//#pragma mark - Tap Gestures
//-(void)openSetting:(UITapGestureRecognizer*)gestureRecognizer
//{
//    NSLog(@"%@",NSStringFromSelector(_cmd));
////    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//////        self.navigationController.navigationBar.hidden = YES;
//////        [[UIApplication sharedApplication] setStatusBarHidden:YES];
////    } completion:^(BOOL finished) {
////        //TO do
////    }];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
//    [UINavigationBar setAnimationDuration:3.0];
//    
//    [UINavigationBar beginAnimations:@"" context:nil];
//    [[UIApplication sharedApplication] setStatusBarHidden:!([UIApplication sharedApplication].statusBarHidden) withAnimation:NO];
//    if ([UIApplication sharedApplication].isStatusBarHidden)
//        [self.navigationController.navigationBar setAlpha:0.0];
//    else [self.navigationController.navigationBar setAlpha:1.0];
//    [UINavigationBar commitAnimations];
//    
//}
//
//-(void)closeSetting:(UITapGestureRecognizer*)gestureRecognizer
//{
//    NSLog(@"%@",NSStringFromSelector(_cmd));
//    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
////        self.navigationController.navigationBar.hidden = NO;
////        [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    } completion:^(BOOL finished) {
//        //TO do
//    }];
//}

#pragma mark - life cycle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    EPubChapter* chapter = self.dataObject;
    NSURL* url = [NSURL fileURLWithPath:chapter.spinePath];
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
}


//#pragma mark - UIGestureRecognizerDelegate
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}


@end
