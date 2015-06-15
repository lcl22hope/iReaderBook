//
//  BookStoreViewController.m
//  iReader20140811
//
//  Created by lcl on 11/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "BookStoreViewController.h"
#import "CloudTagsView.h"
#import "BookStoreHeaderView.h"
#import "UtilityHeaders.h"
#import "BestSaleTableViewCell.h"

static NSString* const cellIdentifier = @"mycell";
static NSString* cellBestSaleIdentifier = @"bestSaleCell";

@interface BookStoreViewController()<UITableViewDataSource,UITableViewDataSource>
{
    NSArray* sections;
}
@property (nonatomic,strong) BookStoreHeaderView* bookStoreHeader;
@property (nonatomic,strong) NSArray* tags_M;
@property (nonatomic,strong) NSArray* tags_F;
@property (nonatomic,strong) NSArray* tags_book;


@end

@implementation BookStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.bookStoreHeader = [[BookStoreHeaderView alloc] initWithFrame:CGRectMake(0, 64.0, 320, 200)];
    self.tableView.tableHeaderView = _bookStoreHeader;
    
    self.tableView.backgroundColor = bgColor;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tags_M = [NSArray arrayWithObjects:@"玄幻奇幻",@"奇侠仙侠",@"都市生活",@"历史军事",@"游戏竞技",@"科幻同人",nil];
    
    self.tags_F = [NSArray arrayWithObjects:@"古代言情",@"青春校园",@"悬疑灵异",@"宫斗宅斗",@"女尊女强",@"恐怖惊悚", nil];
    self.tags_book = [NSArray arrayWithObjects:@"b1.png",@"b2.png",@"b3.png", @"b4.png",@"b5.png",@"b6.png",@"b7.png",@"b8.png",@"b10.png",nil];
    
    NSDictionary* section1 = @{@"description":@"男频",@"tags":_tags_M};
    NSDictionary* section2 = @{@"description":@"女频",@"tags":_tags_F};
    NSDictionary* section3 = @{@"description":@"畅销榜",@"tags":_tags_book};
    sections = @[section1,section2,section3];
}



#pragma mark -TableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [sections count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section<2) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        CGFloat tagBtn_x;
        CGFloat tagBtn_y;
        NSArray* content = [[sections objectAtIndex:indexPath.section] objectForKey:@"tags"];
        NSInteger count = [content count];
        for (int i = 0; i < count; i ++) {
            UIButton* tagBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            tagBtn.tag = i + 100;
            [tagBtn setTitle:[content objectAtIndex:i] forState:UIControlStateNormal];
            [tagBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            
            if (i<3) {
                tagBtn_x = TAG_BUTTON_SPACE + (TAG_BUTTON_WIDTH)*(i%3) + TAG_BUTTON_SPACE*(i%3);
                tagBtn_y = CONTROLS_TO_BOUNDS_SPACE;
                
            }else{
                tagBtn_x = TAG_BUTTON_SPACE + (TAG_BUTTON_WIDTH)*(i%3) + TAG_BUTTON_SPACE*(i%3);
                tagBtn_y = CONTROLS_TO_BOUNDS_SPACE + TAG_BUTTON_HEIGHT + CONTROLS_TO_BOUNDS_SPACE;
            }
            
            tagBtn.frame = CGRectMake(tagBtn_x, tagBtn_y, TAG_BUTTON_WIDTH, TAG_BUTTON_HEIGHT);
            //            [tagBtn addTarget:self action:@selector(tagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:tagBtn];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = bgColor;
        }
        return cell;
    }else{
        BestSaleTableViewCell* cell = [[BestSaleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setCollectionData:[[sections objectAtIndex:indexPath.section] objectForKey:@"tags"]];
        cell.backgroundColor = bgColor;
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return CONTROLS_TO_BOUNDS_SPACE * 3 + TAG_BUTTON_HEIGHT *2;
            break;
        case 1:
            return CONTROLS_TO_BOUNDS_SPACE * 3 + TAG_BUTTON_HEIGHT *2;
            break;
        case 2:
            return 142;
            break;
        default:
            return 0;
            break;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, SECTION_HEADER_HEIGHT)];
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, 80, 18)];
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont boldSystemFontOfSize:16];
    title.textAlignment = NSTextAlignmentCenter;
    UIImageView* titleBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, 80, 18)];
    titleBg.image = [UIImage imageNamed:@"buttonBg"];
    title.text = [[sections objectAtIndex:section] objectForKey:@"description"];
    [titleBg addSubview:title];
    [view addSubview:titleBg];
    view.backgroundColor = bgColor;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SECTION_HEADER_HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

@end
