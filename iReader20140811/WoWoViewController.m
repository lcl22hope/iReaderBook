//
//  WoWoViewController.m
//  iReader20140811
//
//  Created by lcl on 13/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//



#import "WoWoViewController.h"
#import "WoWoUIView.h"
#import "UtilityHeaders.h"

#define MARGIN_TOP (120.0f)
#define MARGIN_SPACE (60.0f)

@interface WoWoViewController ()
@property (nonatomic,strong) WoWoUIView* hobby;
@property (nonatomic,strong) WoWoUIView* author;
@property (nonatomic,strong) WoWoUIView* friendReading;
@property (nonatomic,strong) WoWoUIView* career;
@property (nonatomic,strong) WoWoUIView* readerCare;
@property (nonatomic,strong) WoWoUIView* history;
@end

@implementation WoWoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hobby = [[WoWoUIView alloc] initWithFrame:CGRectMake(0, MARGIN_TOP, 320, 30)];
    self.hobby.aLabel.text = @"爱好兴趣";
    [self.view addSubview:self.hobby];
    
    self.author = [[WoWoUIView alloc] initWithFrame:CGRectMake(0, MARGIN_TOP + MARGIN_SPACE , 320, 30)];
    self.author.aLabel.text = @"喜欢作家";
    [self.view addSubview:self.author];
    
    self.friendReading = [[WoWoUIView alloc] initWithFrame:CGRectMake(0, MARGIN_TOP + MARGIN_SPACE * 2, 320, 30)];
    self.friendReading.aLabel.text = @"朋友在读";
    [self.view addSubview:self.friendReading];
    
    self.career = [[WoWoUIView alloc] initWithFrame:CGRectMake(0, MARGIN_TOP + MARGIN_SPACE * 3, 320, 30)];
    self.career.aLabel.text = @"读者关注";
    [self.view addSubview:self.career];
    
    self.readerCare = [[WoWoUIView alloc] initWithFrame:CGRectMake(0, MARGIN_TOP + MARGIN_SPACE * 4, 320, 30)];
    self.readerCare.aLabel.text = @"热点时事";
    [self.view addSubview:self.readerCare];
    
    self.history = [[WoWoUIView alloc] initWithFrame:CGRectMake(0, MARGIN_TOP + MARGIN_SPACE * 5, 320, 30)];
    self.history.aLabel.text = @"浏览历史";
    [self.view addSubview:self.history];
    
    UIBarButtonItem* saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(didSaveSettingState:)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    self.view.backgroundColor = bgColor;
    
    self.navigationItem.title = @"窝窝";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didSaveSettingState:(id)sender{
    if (self.wowoVCDelegate && [self.wowoVCDelegate conformsToProtocol:@protocol(WoWoViewControllerDelegate)]) {
        [self.wowoVCDelegate didFinishSetting:self];
    }
}


@end
