//
//  AppDelegate.m
//  iReader20140811
//
//  Created by lcl on 11/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "AppDelegate.h"
#import "CLBaseTabController.h"
#import "GreatPushViewController.h"
#import "FootPrintViewController.h"
#import "DynamicViewController.h"
#import "PersonalViewController.h"
#import "BookStoreViewController.h"
#import "CLBaseNavigationViewController.h"
@interface AppDelegate ()<UITabBarControllerDelegate, UIViewControllerAnimatedTransitioning>

@end

@implementation AppDelegate

-(void)setupAppearance {
    UIImage *minImage = [[UIImage imageNamed:@"slider_minimum.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    UIImage *maxImage = [[UIImage imageNamed:@"slider_maximum.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    UIImage *thumbImage = [UIImage imageNamed:@"slider_icon.png"];
    
    [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   [self setupAppearance];
    //GreatPush
    GreatPushViewController* greatPushVC = [[GreatPushViewController alloc] init];
    greatPushVC.title = @"精推";
    greatPushVC.tabBarItem.image = [UIImage imageNamed:@"greatpush.png"];
    CLBaseNavigationViewController* greatPushNVC = [[CLBaseNavigationViewController alloc] initWithRootViewController:greatPushVC];
    
    //FootPrint
    FootPrintViewController* footPrintVC = [[FootPrintViewController alloc] init];
    footPrintVC.title = @"足迹";
    footPrintVC.tabBarItem.image = [UIImage imageNamed:@"footprintTabBar.png"];
    CLBaseNavigationViewController* footPrintNVC = [[CLBaseNavigationViewController alloc] initWithRootViewController:footPrintVC];
    
    //dynamicInfo
    DynamicViewController* dynamicInfoVC = [[DynamicViewController alloc] init];
    dynamicInfoVC.title = @"动态";
    dynamicInfoVC.tabBarItem.image = [UIImage imageNamed:@"dynamicInfo.png"];
    CLBaseNavigationViewController* dynamicInfoNVC = [[CLBaseNavigationViewController alloc] initWithRootViewController:dynamicInfoVC];
    
    //PersonalCenter
    PersonalViewController* personalVC = [[PersonalViewController alloc] init];
    personalVC.title = @"我";
    personalVC.tabBarItem.image =[UIImage imageNamed:@"person.png"];
    CLBaseNavigationViewController * personalNVC = [[CLBaseNavigationViewController alloc] initWithRootViewController:personalVC];
    
    //bookStore
    BookStoreViewController* bookStoreVC = [[BookStoreViewController alloc] init];
    bookStoreVC.title = @"书城";
    bookStoreVC.tabBarItem.image = [UIImage imageNamed:@"bookstore.png"];
    CLBaseNavigationViewController* bookStoreNVC = [[CLBaseNavigationViewController alloc] initWithRootViewController:bookStoreVC];
    
    //tab Bar
    CLBaseTabController* rootTabBarController = [[CLBaseTabController alloc] init];
    rootTabBarController.viewControllers = [NSArray arrayWithObjects:greatPushNVC,footPrintNVC,dynamicInfoNVC,personalNVC,bookStoreNVC, nil];
    
    //Setup UI
    UIColor* color = [UIColor colorWithRed:23.0/255.0 green:50.0/255.0 blue:77.0/255.0 alpha:1.0];
    [rootTabBarController.tabBar setBarTintColor:[UIColor whiteColor]];
    [rootTabBarController.tabBar setSelectedImageTintColor:color];
//    rootTabBarController.tabBar.backgroundColor = [UIColor whiteColor];
//    rootTabBarController.tabBar.tintColor = [UIColor whiteColor];
    CGFloat CURRENT_SYS_VERSION = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (CURRENT_SYS_VERSION >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:color];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    } else {
        [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.071 green:0.060 blue:0.086 alpha:1.000]];
    }
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:20], NSFontAttributeName, nil]];
    
    self.window.rootViewController = rootTabBarController;
    UITabBarController* tbc = (UITabBarController*)self.window.rootViewController;
    tbc.delegate = self;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    //    NSLog(@"%@", [self.window performSelector:@selector(recursiveDescription)]);
    
    
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController* vc1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* vc2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* con = [transitionContext containerView];
    
    
    //    NSLog(@"%@", [con performSelector:@selector(recursiveDescription)]);
    
    CGRect r1start = [transitionContext initialFrameForViewController:vc1];
    CGRect r2end = [transitionContext finalFrameForViewController:vc2];
    UIView* v1 = vc1.view;
    UIView* v2 = vc2.view;
    
    // which way we are going depends on which vc is which
    // the most general way to express this is in terms of index number
    UITabBarController* tbc = (UITabBarController*)self.window.rootViewController;
    NSUInteger ix1 = [tbc.viewControllers indexOfObject:vc1];
    NSUInteger ix2 = [tbc.viewControllers indexOfObject:vc2];
    int dir = ix1 < ix2 ? 1 : -1;
    CGRect r = r1start;
    r.origin.x -= r.size.width * dir;
    CGRect r1end = r;
    r = r2end;
    r.origin.x += r.size.width * dir;
    CGRect r2start = r;
    v2.frame = r2start;
    [con addSubview:v2];
    
    //    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0,0,100,100)];
    //    v.backgroundColor = [UIColor blackColor];
    //    [con addSubview:v];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.4 animations:^{
        v1.frame = r1end;
        v2.frame = r2end;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}

@end
