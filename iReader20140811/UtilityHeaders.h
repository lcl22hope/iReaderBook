//
//  UtilityHeaders.h
//  iReader20140810
//
//  Created by lcl on 10/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#define BTN_WIDTH (40.0f)
#define BTN_HEIGHT (40.0f)
#define CONTROLS_TO_BOUNDS_SPACE (5.0f)

#define SECTION_HEADER_HEIGHT (20.0f)
#define bgColor ([UIColor colorWithRed:226.0/255.0 green:230.0/255.0 blue:195.0/255.0 alpha:1.0])
#define appearanceColor ([UIColor colorWithRed:66.0/255.0 green:137.0/255.0 blue:114.0/255.0 alpha:1])
#define TAG_BUTTON_SPACE (35.0)
#define TAG_BUTTON_WIDTH (60.0)
#define TAG_BUTTON_HEIGHT (30.0)


#define HUE        (arc4random() % 256 / 256.0 )
#define SATURATION ((arc4random()% 128 / 256.0 ) + 0.5)
#define BRIGHTNESS ((arc4random()% 128 / 256.0 ) + 0.5)
#define RANDOM_COLOR ([UIColor colorWithHue:HUE saturation:SATURATION brightness:BRIGHTNESS alpha:1])

#define BUDDLEGAP_X 35
#define BUDDLEGAP_Y 10
#define FONTHEIGHT 35
#define CONTRAINT_WIDTH (280)
#define DURATION 16
#define FONTSIZE (16)
#define FIREINTERVAL 2


#define kBestSaleBookCellHeight (100.0f)
#define kBestSaleBookCellWidth (60.0f)
#define kBestSaleCell_SPACE (35.0)

//for 精推
#define ROOTVIEW_WIDTH (CGRectGetWidth(self.view.frame))

#define WIDTH_CELL (100.0f)
#define RADIO_GOLD (0.618f)

#define kBookInReadingCellHeight (100.0f)
#define kBookInReadingCellWidth (100.0f)

#define IMG_WIDTH (140.0f)
#define IMG_HEIGHT (IMG_WIDTH / 1.618f)
#define VIEW_RADIUS (10.0f)
#define BOOK_CELL_WIDTH (150.0f)

#define kPushBookCellHeight (150.0f)
#define kPushBookCellWidth (150.0f)

//个人标签
#define tagFontSize         12.0f
#define tagFontType         @"Helvetica-Light"
#define tagMargin           5.0f
#define tagHeight           25.0f
#define tagCornerRadius     3.0f
#define tagCloseButton      7.0f

//头像设置
#define ORIGINAL_MAX_WIDTH 640.0f

//足迹中的button Menu Items
#define btn_padding (5.0f)
#define btn_width   (50.0f)
#define btn_hight   (20.f)
