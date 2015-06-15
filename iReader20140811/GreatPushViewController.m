//
//  GreatPushViewController.m
//  iReader20140811
//
//  Created by lcl on 11/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "GreatPushViewController.h"
#import "UtilityHeaders.h"
#import "PageRollController.h"
#import "GreatPushTableViewCell.h"
#import "GreatPushCell.h"
#import "BookInFriendReadingTableViewCell.h"
#import "refreshBtn.h"
#import "UIImage+ImageRender.h"
#import "UIView+Animation.h"
#import "GreatPushCollectionViewContainer.h"
#import "WorkDetailViewController.h"
#import "HeadlinesTodayController.h"
#import "HeartSoupViewController.h"

#define kAppHasRunBeforeKey @"appFirstTimeRun"

const static NSString* cellId = @"my cell";
@interface GreatPushViewController ()<UITableViewDataSource,UITableViewDelegate,GreatPushCellDelegate>
{
    NSArray* sections;
    NSArray* booksToPush;
    NSArray* booksInReading;
    PageRollController* pRController;
    GreatPushCollectionViewContainer* container;
}
@end

@implementation GreatPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSDictionary* book1,*book2,*book3,*book4;
    NSArray* keysForPushBook = @[@"title",@"coverName", @"category",@"desciption"];
    book1 = [NSDictionary dictionaryWithObjects:@[@"习近平出席南京青奥会开幕式并宣布青奥会开幕",
                                                  @"今日头条.png",
                                                  @"今日头条",
                                                  @"中新社南京8月16日电 (记者 朱晓颖 田雯)第二届夏季青年奥运会开幕式16日晚在南京奥林匹克体育中心体育场举行，中国国家主席习近平出席开幕式并宣布南京青奥会开幕。"]
                                        forKeys:keysForPushBook];
    book2 = [NSDictionary dictionaryWithObjects:@[@"少年巴比伦",
                                                  @"2.png",
                                                  @"学术经纬",
                                                  @"世人眼中的堕落女人萨拉，抑郁成瘾， 生活在保守的英国小镇上，大家都叫 她“法国中尉的女人”。"]
                                        forKeys:keysForPushBook];
    book3 = [NSDictionary dictionaryWithObjects:@[@"我们得多努力，才能做一个普通人",
                                                  @"心灵鸡汤.png",
                                                  @"心灵鸡汤",
                                                  @"我没有皇城根下的家，也没有留过洋的爸妈。我只能要着牙拼命学习，在千军万马中挤破头，换来一个国内普通的大学，而我还要拼命努力，才能换来一个普通的人生。"]
                                        forKeys:keysForPushBook];
    book4 = [NSDictionary dictionaryWithObjects:@[@"做衣服",
                                                  @"4.png",
                                                  @"轻松驿站",
                                                  @"世人眼中的堕落女人萨拉，抑郁成瘾， 生活在保守的英国小镇上，大家都叫 她“法国中尉的女人”。"]
                                        forKeys:keysForPushBook];
    
    
    booksToPush = [[NSArray alloc] initWithObjects:book1,book2,book3,book4,book1,book2,book3,book4,nil];
    
    
    NSArray* keysForBooksInFriendReading = @[@"username",@"thumbnail",@"bookCover"];
    NSDictionary *rbook1,*rbook2,*rbook3;
    rbook1 = [NSDictionary dictionaryWithObjects:@[@"三十六把刀",@"showgirl1.png",@"rb1.png"]
                                         forKeys:keysForBooksInFriendReading];
    rbook2 = [NSDictionary dictionaryWithObjects:@[@"无聊的人",@"showgirl2.png",@"rb2.png"]
                                         forKeys:keysForBooksInFriendReading];
    rbook3 = [NSDictionary dictionaryWithObjects:@[@"我要做学霸",@"showgirl3.png",@"rb3.png"]
                                         forKeys:keysForBooksInFriendReading];
    
    booksInReading = [[NSArray alloc] initWithObjects:rbook1,rbook2,rbook3,rbook1,rbook2,rbook3,nil];
    //
    
    sections = @[@{@"description":@"每日推荐",@"books":booksToPush},
                 @{@"description":@"友在读", @"books":booksInReading}
                 ];
    
    pRController = [[PageRollController alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    [self.tableView registerClass:[GreatPushTableViewCell class] forCellReuseIdentifier:@"GreatPushTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIView* headerView = pRController.view.subviews[0];
    [self.tableView setTableHeaderView:headerView];
    self.tableView.sectionFooterHeight = 0;//这样就没有footer了
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = bgColor;
    
    
//    //just delegate  invoke
//    container = [[GreatPushCollectionViewContainer alloc] init];
//    container.delegate = self;
}

#pragma mark - Table view data source

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [sections[0] objectForKey:@"description"];
            break;
        case 1:
            //            NSLog(@"not");
            return [sections[1] objectForKey:@"description"];
            break;
        default:
            return @"unknown";
            break;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *cellData;
    NSArray* booksData;
    if (indexPath.section == 0) {
        GreatPushTableViewCell *cell = (GreatPushTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"GreatPushCellView"];
        if (cell == nil) {
            cell = [[GreatPushTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GreatPushCellView"];
        }
        //    NSLog(@"cell frame is %@",NSStringFromCGRect(cell.frame));
        cellData = [sections objectAtIndex:indexPath.section];
        booksData = [cellData objectForKey:@"books"];
        cell.collectionViewContainer.delegate = self;
        [cell setCollectionData:booksData];
        return cell;
    }else if (indexPath.section == 1){
        BookInFriendReadingTableViewCell *cell = (BookInFriendReadingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"BookInFriendReadingTableViewCell"];
        if (cell == nil) {
            cell = [[BookInFriendReadingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BookInFriendReadingTableViewCell"];
        }
        cellData = [sections objectAtIndex:indexPath.section];
        booksData = [cellData objectForKey:@"books"];
        [cell setCollectionData:booksData];
        return cell;
    }else{
        return nil;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    //1 view 代表section view
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 80, 18)];
    titleLabel.font = [UIFont boldSystemFontOfSize:10];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    UIImageView* titleBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 80, 18)];
    titleBgImgView.image = [UIImage imageNamed:@"buttonBg"];
    
    //2 刷新按钮
    UIView* refreshBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 18)];
    UIImageView* refreshImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh"]];
    refreshImg.frame = CGRectMake(270, 1, 16, 16);
    refreshImg.tintColor = [UIColor grayColor];
    UILabel* refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(288, 1, 30, 18)];
    refreshLabel.textAlignment = NSTextAlignmentRight;
    refreshLabel.font = [UIFont systemFontOfSize:10];
    refreshLabel.textColor = [UIColor grayColor];
    refreshLabel.text = @"换一批";
    [refreshBtnView addSubview:refreshImg];
    [refreshBtnView addSubview:refreshLabel];
    
    //3.查看更多
    UIButton* moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(270, 1, 50, 18);
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    //    moreBtn.titleLabel.textColor = [UIColor grayColor];
    moreBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    //    moreBtn.titleLabel.text = @"查看更多";
    moreBtn.titleLabel.tintColor = [UIColor grayColor];
    [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    switch (section) {
        case 0:
            titleLabel.text = [[sections objectAtIndex:section] objectForKey:@"description"];
            [titleBgImgView addSubview:titleLabel];
            [view addSubview:titleBgImgView];
            [view addSubview:moreBtn];
            view.backgroundColor = bgColor;
            return view;
            break;
        case 1:
            titleLabel.text = [[sections objectAtIndex:section] objectForKey:@"description"];
            [titleBgImgView addSubview:titleLabel];
            [view addSubview:titleBgImgView];
            [view addSubview:refreshBtnView];
            view.backgroundColor = bgColor;
            return view;
            break;
        default:
            break;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SECTION_HEADER_HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 160;
            break;
        case 1:
            return 120;
            break;
        default:
            return 0;
            break;
    }
}



#pragma mark - GreatPushCellDelegate
-(void)didShowWorkDetailViewController:(GreatPushCell *)cell
{
    if ([cell.category.text isEqualToString:@"今日头条"]) {
        // to do
        HeadlinesTodayController* headlinesTodayController = [[HeadlinesTodayController alloc] init];
        headlinesTodayController.title = @"今日头条";
        [self.navigationController pushViewController:headlinesTodayController animated:YES];
    }else if([cell.category.text isEqualToString:@"学术经纬"]){
        WorkDetailViewController* detailController = [[WorkDetailViewController alloc] init];
        detailController.title = @"作品详情";
        detailController.workHeader = [[WorkDetailHeaderView alloc] initWithFrame:CGRectMake(0,0,320,200)];
        
        //    detailController.workHeader.backgroundColor = [UIColor greenColor];
        
        detailController.workHeader.bookTitle.text
        = [detailController.workHeader.bookTitle.text stringByAppendingString:cell.head.text];
        
        detailController.workHeader.bookCover.image = cell.faceCover.image;
        
        detailController.workHeader.price.text
        = [detailController.workHeader.price.text stringByAppendingString: @"¥40"];
        
        detailController.workHeader.author.text
        = [detailController.workHeader.author.text stringByAppendingString: @"路内"];
        
        detailController.workHeader.size.text
        = [detailController.workHeader.size.text stringByAppendingString: @"1.2M"];
        
        detailController.workHeader.loveCountView.loveCount.text = @"502次";
        
        detailController.workHeader.bookDetail.text = cell.detail.text;
        
        [self.navigationController pushViewController:detailController animated:YES];
    }else if([cell.category.text isEqualToString:@"心灵鸡汤"]){
        HeartSoupViewController* heartSoupVC = [[HeartSoupViewController alloc] init];
        heartSoupVC.title = @"心灵鸡汤";
        [self.navigationController pushViewController:heartSoupVC animated:YES];
    }else{
        
    }
}


@end
