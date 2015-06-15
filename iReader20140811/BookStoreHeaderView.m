//
//  BookStoreHeaderView.m
//  TestBookStore
//
//  Created by lcl on 3/9/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "BookStoreHeaderView.h"
#import "UtilityHeaders.h"

@interface BookStoreHeaderView()
@property (nonatomic,strong) NSArray* tags;
@end

@implementation BookStoreHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tags = [NSArray arrayWithObjects:@"宅斗",@"金庸",@"女强",@"你若安好",@"发家致富",@"莫言",@"桐华",@"我是歌手",@"家田喜事",@"韩寒",@"郭敬明",@"朱自清",@"但丁",@"白居易",@"井上彦雄",@"村上村树",@"陆游",@"李白",@"三岛由纪夫",@"东野圭吾",@"卡耐基",@"三体",@"计算机",@"旅游",@"历史",@"宫斗",@"权谋",@"职场",@"那年夏天",nil];
        [self addSubview:self.searchBar];
        [self addSubview:self.traceSearchBtn];
        [self addSubview:self.cloudTagsView];
        
    }
    return self;
}


-(UISearchBar*)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        CGFloat searchBarWidth = CGRectGetWidth(self.frame) - CONTROLS_TO_BOUNDS_SPACE * 3 - BTN_WIDTH*1;
        _searchBar.frame = CGRectMake(CONTROLS_TO_BOUNDS_SPACE, 0, searchBarWidth, BTN_HEIGHT);
    }
    return _searchBar;
}


-(UIButton*)traceSearchBtn{
    if (!_traceSearchBtn) {
        _traceSearchBtn = [[UIButton alloc] init];
        CGFloat traceBtn_x = CGRectGetMaxX(_searchBar.frame) + CONTROLS_TO_BOUNDS_SPACE;
        CGFloat traceBtn_y = CGRectGetMinY(_searchBar.frame);
        _traceSearchBtn.frame = CGRectMake(traceBtn_x, traceBtn_y, BTN_WIDTH, BTN_HEIGHT);
        [_traceSearchBtn setImage:[UIImage imageNamed:@"footprint"] forState:UIControlStateNormal];
        _traceSearchBtn.backgroundColor = [UIColor colorWithRed:23.0/255.0 green:50.0/255.0 blue:77.0/255.0 alpha:1.0];
    }
    return _traceSearchBtn;
}

-(CloudTagsView*)cloudTagsView{
    if (!_cloudTagsView) {
        CGFloat cloudTagsView_x = CGRectGetMinX(_searchBar.frame);
        CGFloat cloudTagsView_y = CGRectGetMaxY(_searchBar.frame) + CONTROLS_TO_BOUNDS_SPACE;
        CGFloat cloudTagsView_w = CGRectGetWidth([[UIScreen mainScreen] bounds]) - CONTROLS_TO_BOUNDS_SPACE*2;
        CGFloat cloudTagsView_h = 160;
        _cloudTagsView = [[CloudTagsView alloc] initWithFrame:CGRectMake(cloudTagsView_x, cloudTagsView_y, cloudTagsView_w, cloudTagsView_h)];
        [_cloudTagsView reloadData:self.tags];
    }
    return _cloudTagsView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
