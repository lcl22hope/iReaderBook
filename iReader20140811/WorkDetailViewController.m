//
//  WorkDetailViewController.m
//  iReader20140811
//
//  Created by lcl on 19/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "WorkDetailViewController.h"
#import "WorkDetailHeaderView.h"
#import "UtilityHeaders.h"
#import "QuestionRefreshButton.h"
#import "commentViewINDetail.h"
#import "BestSaleTableViewCell.h"

@interface WorkDetailViewController ()

@end

@implementation WorkDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.workHeader;
    self.tableView.backgroundColor = bgColor;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}


#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 && indexPath.row == 0) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        UIButton* listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        listBtn.frame = CGRectMake(80, 0, 160, cell.frame.size.height);
        [listBtn setTitle:@"查看目录" forState:UIControlStateNormal];
        [listBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        listBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
        listBtn.layer.borderWidth = 1.0f;
        
        [cell.contentView addSubview:listBtn];
        cell.contentView.backgroundColor = bgColor;
        return cell;
    }else if(indexPath.section == 1){
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        commentViewINDetail* commentDetail = [[commentViewINDetail alloc] initWithFrame:cell.bounds];
        commentDetail.avator.image = [UIImage imageNamed:@"showgirl2"];
        commentDetail.name.text = @"恍惚的人";
        commentDetail.comment.text = @"惬意的暑假,在家还是看看书吧~";
        commentDetail.date.text = @"2014-09-07";
        commentDetail.likeCount.text = [NSString stringWithFormat:@"(%d)",5];
        commentDetail.commentCount.text = [NSString stringWithFormat:@"(%d)",3];
        [cell.contentView addSubview:commentDetail];
        cell.contentView.backgroundColor = bgColor;
        return cell;
    }
    else{
        BestSaleTableViewCell* cell = [[BestSaleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        if (!cell) {
            cell = [[BestSaleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        NSArray* books = @[@"b1.png",@"b2.png",@"b3.png", @"b4.png",@"b5.png",@"b6.png"];
        [cell setCollectionData:books];
        cell.contentView.backgroundColor = bgColor;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return UITableViewAutomaticDimension;
    }
    else if (indexPath.section == 1){
        return 200;
    }else if(indexPath.section == 2){
        return 150;
    }else{
        return 0;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        UILabel* comment = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        comment.text = @"热门评论";
        comment.font = [UIFont systemFontOfSize:15];
        comment.textAlignment = NSTextAlignmentLeft;
        [container addSubview:comment];
        return container;
    }else if(section == 2){
        UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        UILabel* comment = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        comment.text = @"相关推荐";
        comment.font = [UIFont systemFontOfSize:15];
        comment.textAlignment = NSTextAlignmentLeft;
        [container addSubview:comment];
        QuestionRefreshButton* qBtn = [[QuestionRefreshButton alloc]
                                       initWithFrame:CGRectMake(245, 2, 80, 20)
                                       withColor:[UIColor darkTextColor]];
        [container addSubview:qBtn];
        return container;
    }else{
        return nil;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section == 1) {
        UIView* moreComment = [[UIView alloc] initWithFrame:CGRectMake(0 , 0,tableView.frame.size.width, 40)];
        UIButton* moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn setTitle:[NSString stringWithFormat:@"更多评论(%d)",20]
                 forState:UIControlStateNormal];
        moreBtn.frame = CGRectMake(60, 0, 200, 40);
        moreBtn.layer.cornerRadius = 4;
        moreBtn.layer.masksToBounds= YES;
        moreBtn.backgroundColor = [UIColor orangeColor];
        moreComment.backgroundColor = bgColor;
        [moreComment addSubview:moreBtn];
        return moreComment;
    }else if(section == 2){
        UIView* others = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        UIButton* readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        readBtn.frame = CGRectMake(20, 0, 80, 30);
        [readBtn setBackgroundImage:[UIImage imageNamed:@"readBtn"] forState:UIControlStateNormal];
        [readBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 0)];
        readBtn.backgroundColor = [UIColor orangeColor];
        
        UIButton* addToTraceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addToTraceBtn.frame=CGRectMake(120, 0, 80, 30);
        [addToTraceBtn setBackgroundImage:[UIImage imageNamed:@"addToTraceBtn"] forState:UIControlStateNormal];
        addToTraceBtn.backgroundColor = [UIColor orangeColor];
        
        UIButton* share = [UIButton buttonWithType:UIButtonTypeCustom];
        share.frame = CGRectMake(220, 0, 80, 30);
        [share setBackgroundImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
        share.backgroundColor = [UIColor orangeColor];
        readBtn.layer.cornerRadius = 3;
        addToTraceBtn.layer.cornerRadius = 3;
        share.layer.cornerRadius = 3;
        readBtn.layer.masksToBounds = YES;
        addToTraceBtn.layer.masksToBounds = YES;
        share.layer.masksToBounds = YES;
        [others addSubview:readBtn];
        [others addSubview:addToTraceBtn];
        [others addSubview:share];
        return  others;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 1){
        return 40;
    }else if(section == 2){
        return 60;
    }else{
        return 0;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if(section == 1){
        return 20;
    }else if(section == 2){
        return 20;
    }else{
        return 0;
    }
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
@end
