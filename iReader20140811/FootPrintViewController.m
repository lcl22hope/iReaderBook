//
//  FootPrintViewController.m
//  iReader20140811
//
//  Created by lcl on 11/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "FootPrintViewController.h"
#import "LeftTrace.h"
#import "RightTrace.h"
#import "FootButton.h"
#import "MenuItems.h"
#import "FootBtnContainer.h"
#import "PageAppViewController.h"

#define DURING_TIME   1.0
#define ori_scale    (0.6)
#define ori_height   (40)
#define ori_x        (20)
#define Height_Space (40)
#define Width_Space  (130)

@interface FootPrintViewController()<FootBtnContainerDelegate,OpenLeftBookDelegate>

@property (nonatomic,strong) NSArray* books;
@property (nonatomic,strong) FootBtnContainer* container;

@end

@implementation FootPrintViewController
{
    BOOL isFirstFootBtnClicked;
    BOOL isBookOpen;
    LeftTrace*  View1;
    RightTrace* View2;
    LeftTrace*  View3;
    RightTrace* View4;
    LeftTrace*  View5;
    CGPoint bookViewOrignCenter;
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"footTrace"]];
    [self setUpData];
    
    View1.openBookDelegate = self;
//    View2.openBookDelegate = self;
    View3.openBookDelegate = self;
//    View4.openBookDelegate = self;
    View5.openBookDelegate = self;

//  btn
    self.container = [[FootBtnContainer alloc] initWithFrame:CGRectMake(280, 360, 100, 80)];
    [self.view addSubview:_container];
    _container.delegate = self;
    isFirstFootBtnClicked = YES;
}

-(void)setUpData
{
    self.books = @[
                   @{@"title":@"情人无泪",
                     @"coverImg":@"情人无泪.png",
                     @"detail":@"世上没有任何一种动物跑得比时间和生命快，赛过光阴的，不是速度，而是爱情在两个灵魂之间的慢舞",
                     @"foot":@"p0"},
                   
                   @{@"title":@"1984",
                     @"coverImg":@"1984.png",
                     @"detail":@"《1984》是一部杰出的政治寓言小说，也是一部幻想小说。作品刻画了人类在极权主义社会的生存状态，有若一个永不退色的警示标签，警醒世人提防这种预想中的黑暗成为现实",
                     @"foot":@"p1"},
                   
                   @{@"title":@"看见",
                     @"coverImg":@"看见.png",
                     @"detail":@"《看见》是知名记者和主持人柴静讲述央视十年历程的自传性作品，既是柴静个人的成长告白书，某种程度上亦可视作中国社会十年变迁的备忘录",
                     @"foot":@"p2"},
                   
                   @{@"title":@"牛奶可乐经济学",
                     @"coverImg":@"牛奶可乐经济学.png",
                     @"detail":@"一部“博物经济学”著作，它非学术大部头，而只是生活小智慧。其实经济学正生动地编织着生活的方方面面，人身边的大事小事都可以用经济学原理来一一破解，这就是博物经济学",
                     @"foot":@"p3"},
                   
                   @{@"title":@"零下一度",
                     @"coverImg":@"零下一度.png",
                     @"detail":@"年仅18岁的韩寒是一个引人注目的角色。他是上海松江二中高一的学生，以一篇《杯中窥人》问鼎首届全国新概念作文大赛一等奖，并出版了长篇新作《三重门》，但与此同时，他却在期末考试中几门功课高挂“红灯”而留级、休学..",
                     @"foot":@"p4"}
                   ];
    
    View1 = [[LeftTrace alloc] initWithFrame:CGRectMake(ori_x ,
                                                        ori_height + 30, 190, 72)
                                       title:[_books[0] objectForKey:@"title"]
                                    coverImg:[_books[0] objectForKey:@"coverImg"]
                                      detail:[_books[0] objectForKey:@"detail"]
                                        foot:[_books[0] objectForKey:@"foot"]
                                       scale:0.6];
    View1.container.backgroundColor = [UIColor colorWithRed:127/255.0 green:80/255.0 blue:198/255.0 alpha:1.0];
    
    View2 = [[RightTrace alloc] initWithFrame:CGRectMake(ori_x + Width_Space -10,
                                                         ori_height + 80, 190, 72)
                                        title:[_books[1] objectForKey:@"title"]
                                     coverImg:[_books[1] objectForKey:@"coverImg"]
                                       detail:[_books[1] objectForKey:@"detail"]
                                         foot:[_books[1] objectForKey:@"foot"]
                                        scale:0.7];
    View2.container.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:76.0/255.0 blue:82.0/255.0 alpha:1.0];
    
    View3 = [[LeftTrace alloc] initWithFrame:CGRectMake(ori_x - 10,
                                                        ori_height + 140, 190, 72)
                                       title:[_books[2] objectForKey:@"title"]
                                    coverImg:[_books[2] objectForKey:@"coverImg"]
                                      detail:[_books[2] objectForKey:@"detail"]
                                        foot:[_books[2] objectForKey:@"foot"]
                                       scale:0.6];
    View3.container.backgroundColor = [UIColor colorWithRed:76.0/255.0 green:153.0/255.0 blue:80.0/255.0 alpha:1.0];
    
    View4 = [[RightTrace alloc] initWithFrame:CGRectMake(ori_x + Width_Space + 25,
                                                         230, 190, 72)
                                        title:[_books[3] objectForKey:@"title"]
                                     coverImg:[_books[3] objectForKey:@"coverImg"]
                                       detail:[_books[3] objectForKey:@"detail"]
                                         foot:[_books[3] objectForKey:@"foot"]
                                        scale:0.7];
    View4.container.backgroundColor = [UIColor colorWithRed:217/255.0 green:117.0/255.0 blue:42.0/255.0 alpha:1.0];
    
    View5 = [[LeftTrace alloc] initWithFrame:CGRectMake(ori_x ,
                                                        310, 190, 72)
                                       title:[_books[4] objectForKey:@"title"]
                                    coverImg:[_books[4] objectForKey:@"coverImg"]
                                      detail:[_books[4] objectForKey:@"detail"]
                                        foot:[_books[4] objectForKey:@"foot"]
                                       scale:0.8];
    View5.container.backgroundColor = [UIColor colorWithRed:23/255.0 green:50/255.0 blue:77.0/255.0 alpha:1.0];
    
    [self.view addSubview:View1];
    [self.view addSubview:View2];
    [self.view addSubview:View3];
    [self.view addSubview:View4];
    [self.view addSubview:View5];
    

}

#pragma mark - FootBtnContainer delegate methods

-(void)didFootBtnSingleTap:(FootBtnContainer *)container
{
    if (isFirstFootBtnClicked==YES) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            container.center = CGPointMake(container.center.x-60, container.center.y);
            container.footBtn.arrowImgView.image = [UIImage imageNamed:@"right"];
        } completion:^(BOOL finished) {
            
        }];
        isFirstFootBtnClicked = NO;
    }else{
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            container.center = CGPointMake(container.center.x+60, container.center.y);
            container.footBtn.arrowImgView.image = [UIImage imageNamed:@"left_arrow"];
            
        } completion:^(BOOL finished) {

        }];
        isFirstFootBtnClicked=YES;
    }
}

#pragma mark - OpenBookDeleateMethod
-(void)didOpenLeftBook:(LeftTrace *)leftBook
{
//    self.navigationController.navigationBarHidden = YES;
    PageAppViewController* vc = [[PageAppViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
    
//    [self addChildViewController:vc];
//    [self.view addSubview:vc.view];
//    [vc didMoveToParentViewController:self];
}

//#pragma mark - hidden statusbar
//-(BOOL)prefersStatusBarHidden
//{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//    {
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//}

@end
