//
//  BookStoreHeaderView.h
//  TestBookStore
//
//  Created by lcl on 3/9/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CloudTagsView.h"

@interface BookStoreHeaderView : UIView
//搜索
@property (nonatomic,strong) UISearchBar* searchBar;
@property (nonatomic,strong) UIButton* traceSearchBtn;
//标签云
@property (nonatomic,strong) CloudTagsView* cloudTagsView;
@end
