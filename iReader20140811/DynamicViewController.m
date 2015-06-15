//
//  DynamicViewController.m
//  iReader20140811
//
//  Created by lcl on 11/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "DynamicViewController.h"
#import "CLAlbumTableViewCell.h"
#import "UtilityHeaders.h"
#import "CLAlbum.h"
#import "XHMacro.h"
#import "CLPathCover.h"
#import "CLPhotographyHelper.h"


@interface DynamicViewController()
/**
 *  视觉差的TableViewHeaderView
 */
@property (nonatomic, strong) CLPathCover *albumHeaderContainerViewPathCover;

@property (nonatomic, strong) CLPhotographyHelper *photographyHelper;

@end

@implementation DynamicViewController

#pragma mark - life Cycle
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.albumHeaderContainerViewPathCover;
    [self configuraTableViewNormalSeparatorInset];
    [self loadDataSource];
    self.view.backgroundColor = bgColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.albumHeaderContainerViewPathCover = nil;
}

#pragma mark- UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_albumHeaderContainerViewPathCover scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_albumHeaderContainerViewPathCover scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_albumHeaderContainerViewPathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_albumHeaderContainerViewPathCover scrollViewWillBeginDragging:scrollView];
}

#pragma mark - Properties
-(CLPathCover*)albumHeaderContainerViewPathCover
{
    if (!_albumHeaderContainerViewPathCover) {
        CGRect albumHeaderFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200);
        _albumHeaderContainerViewPathCover = [[CLPathCover alloc] initWithFrame:albumHeaderFrame];
        [_albumHeaderContainerViewPathCover setBackgroundImage:[UIImage imageNamed:@"AlbumHeaderBackgrounImage"]];
        [_albumHeaderContainerViewPathCover setAvatarImage:[UIImage imageNamed:@"showgirl2"]];
        NSDictionary* infoDic = [NSDictionary dictionaryWithObjectsAndKeys:@"在路上",CLUserNameKey,nil];
        [_albumHeaderContainerViewPathCover setInfo:infoDic];
        _albumHeaderContainerViewPathCover.isZoomingEffect = NO;//默认为no,yes地话没有视差效果
        WEAKSELF
        [_albumHeaderContainerViewPathCover setHandleRefreshEvent:^{
            [weakSelf loadDataSource];
        }];
        [_albumHeaderContainerViewPathCover setHandleTapBackgroundImageEvent:^{
            [weakSelf.photographyHelper showOnPickerViewControllerSourceType:UIImagePickerControllerSourceTypePhotoLibrary onViewController:weakSelf compled:^(UIImage *image, NSDictionary *editingInfo) {
                if (image) {
                    [weakSelf.albumHeaderContainerViewPathCover setBackgroundImage:image];
                } else {
                    if (!editingInfo)
                        return ;
                    [weakSelf.albumHeaderContainerViewPathCover setBackgroundImage:[editingInfo valueForKey:UIImagePickerControllerOriginalImage]];
                }
            }];
        }];
    }
    return _albumHeaderContainerViewPathCover;
}


-(CLPhotographyHelper*)photographyHelper{
    if (!_photographyHelper) {
        _photographyHelper = [[CLPhotographyHelper alloc] init];
    }
    return _photographyHelper;
}

#pragma mark - DataSource
-(void)loadDataSource{
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *dataSource = [self getAlbumConfigureArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.albumHeaderContainerViewPathCover stopRefresh];
            weakSelf.dataSource = dataSource;
            [weakSelf.tableView reloadData];
        });
    });
}

- (NSMutableArray *)getAlbumConfigureArray {
    NSMutableArray *albumConfigureArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 60; i ++) {
        CLAlbum *currnetAlbum = [[CLAlbum alloc] init];
        currnetAlbum.userName = @"在路上";
        currnetAlbum.profileAvatorUrlString = @"showgirl2.png";
        currnetAlbum.albumShareContent = @"要么读书，要么旅行，身体和心灵总要有一个在路上";
        
        currnetAlbum.timestamp = [NSDate date];
        [albumConfigureArray addObject:currnetAlbum];
    }
    
    return albumConfigureArray;
}

#pragma mark - UITableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"albumTableViewCellIdentifier";
    
    CLAlbumTableViewCell *albumTableViewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!albumTableViewCell) {
        albumTableViewCell = [[CLAlbumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row < self.dataSource.count) {
        albumTableViewCell.currentAlbum = self.dataSource[indexPath.row];
    }
    
    return albumTableViewCell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CLAlbumTableViewCell calculateCellHeightWithAlbum:self.dataSource[indexPath.row]];
}




@end
