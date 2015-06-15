//
//  HeadlinesTodayController.m
//  iReader20140811
//
//  Created by lcl on 4/9/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "HeadlinesTodayController.h"
#import "UtilityHeaders.h"
#import "LikeCountView.h"
#import "commentViewINDetail.h"

@interface HeadlinesTodayController ()

@end

@implementation HeadlinesTodayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = bgColor;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark property
-(UIView*)newsHeaderView
{
    if (!_newsHeaderView) {
        _newsHeaderView = [[UIView alloc] initWithFrame:CGRectMake(20, 10, 280, 80)];
        CGFloat t_x = 10;
        CGFloat t_y = 5;
        UILabel* tilte = [[UILabel alloc] initWithFrame:CGRectMake(t_x, t_y, 260, 30)];
        tilte.text = @"习近平出席南京青奥会开幕式";
        tilte.textAlignment = NSTextAlignmentLeft;
        tilte.textColor = [UIColor whiteColor];
        tilte.font = [UIFont boldSystemFontOfSize:20];
        [_newsHeaderView addSubview:tilte];
        CGFloat f_x = CGRectGetMinX(tilte.frame);
        CGFloat f_y = CGRectGetMaxY(tilte.frame) + 10;
        UILabel* fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(f_x, f_y, 180, 20)];
        fromLabel.text = [NSString stringWithFormat:@"来自于:%@",@"中国新闻网(北京)"];
        fromLabel.textAlignment = NSTextAlignmentLeft;
        fromLabel.textColor = [UIColor whiteColor];
        fromLabel.font = [UIFont systemFontOfSize:13];
        [_newsHeaderView addSubview:fromLabel];
        CGFloat likeView_x = CGRectGetMaxX(tilte.frame)-60;
        CGFloat likeView_y = f_y;
        LikeCountView* likeView = [[LikeCountView alloc] initWithFrame:CGRectMake(likeView_x, likeView_y, 60, 20)];
        likeView.loveCount.text = [NSString stringWithFormat:@"%d次",281];
        likeView.loveCount.textColor = [UIColor whiteColor];
        [_newsHeaderView addSubview:likeView];
        _newsHeaderView.backgroundColor = [UIColor colorWithRed:66.0/255.0 green:137.0/255.0 blue:114.0/255.0 alpha:1];
    }
    return _newsHeaderView;
}

-(UIImageView*)newsImgView{
    if (!_newsImgView) {
//        CGFloat newsImgView_x = CGRectGetMinX(_newsHeaderView.frame);
//        CGFloat newsImgView_y = CGRectGetMaxY(_newsHeaderView.frame) + 10;
        _newsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 280, 185)];
        _newsImgView.image = [UIImage imageNamed:@"今日头条"];
    }
    return _newsImgView;
}

-(UITextView*)newsDetailView{
    if (!_newsDetailView) {
        _newsDetailView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 360)];
        NSError* err = nil;
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"txt"];
        NSString* content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
        if (content==nil) {
            NSLog(@"error: %@", [err description]);
            NSLog(@"Error reading %@: %@", filePath, err);
        }else{
            _newsDetailView.text = content;
        }
        _newsDetailView.font = [UIFont systemFontOfSize:15];
        _newsDetailView.textAlignment = NSTextAlignmentJustified;
//        _newsDetailView.scrollEnabled = YES;
        _newsDetailView.editable = NO;
        _newsDetailView.showsVerticalScrollIndicator = NO;
        _newsDetailView.backgroundColor = [UIColor clearColor];
    }
    return _newsDetailView;
}

-(commentViewINDetail*)commentDetail
{
    if (!_commentDetail) {
        _commentDetail = [[commentViewINDetail alloc] initWithFrame:CGRectMake(10, 10, 300, 60)];
        _commentDetail.avator.image = [UIImage imageNamed:@"showgirl2"];
        _commentDetail.name.text = @"在路上";
        _commentDetail.comment.text = @"惬意的暑假,在家还是看看书吧~";
        _commentDetail.date.text = @"2014-09-07";
        _commentDetail.likeCount.text = [NSString stringWithFormat:@"(%d)",5];
        _commentDetail.commentCount.text = [NSString stringWithFormat:@"(%d)",3];
    }
    return _commentDetail;
}

#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 && indexPath.row == 0) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        [cell.contentView addSubview:self.newsHeaderView];
        cell.contentView.backgroundColor = bgColor;
        return cell;
    }else if(indexPath.section == 1){
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        [cell.contentView addSubview:self.newsImgView];
        cell.contentView.backgroundColor = bgColor;
        return cell;
    }else if(indexPath.section == 2){
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        [cell.contentView addSubview:self.newsDetailView];
        cell.contentView.backgroundColor = bgColor;
        return cell;
    }else if(indexPath.section == 3){
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        [cell.contentView addSubview:self.commentDetail];
        cell.contentView.backgroundColor = bgColor;
        return cell;
    }else{
        return nil;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }
    else if (indexPath.section == 1){
        return 200;
    }else if(indexPath.section == 2){
        return 380;
    }else if(indexPath.section == 3){
        return 200;
    }else{
        return 0.1;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if(section == 3){
        UIView* others = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        
        UIButton* addToTraceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addToTraceBtn.frame=CGRectMake(120, 0, 80, 30);
        addToTraceBtn.center = CGPointMake(80, 30);
        [addToTraceBtn setBackgroundImage:[UIImage imageNamed:@"addToTraceBtn"] forState:UIControlStateNormal];
        addToTraceBtn.backgroundColor = [UIColor orangeColor];
        
        UIButton* share = [UIButton buttonWithType:UIButtonTypeCustom];
        share.frame = CGRectMake(220, 0, 80, 30);
        share.center = CGPointMake(240, 30);
        [share setBackgroundImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
        share.backgroundColor = [UIColor orangeColor];

        addToTraceBtn.layer.cornerRadius = 3;
        share.layer.cornerRadius = 3;

        addToTraceBtn.layer.masksToBounds = YES;
        share.layer.masksToBounds = YES;
        
        [others addSubview:addToTraceBtn];
        [others addSubview:share];
        return  others;
    }else{
        return nil;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 3){
        return 60;
    }else{
        return 0.1;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
@end
