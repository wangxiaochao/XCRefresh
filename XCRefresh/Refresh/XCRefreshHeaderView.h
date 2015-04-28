//
//  XCRefreshHeaderView.h
//  XCDevKit
//
//  Created by 钧泰科技 on 15/4/27.
//  Copyright (c) 2015年 wxc. All rights reserved.
//

#import "XCRefreshHeader.h"

#define ccPULL_BG_IMAGE @""
#define ccPULL_ARROW_IMAGE  @"arrow1@2x.png"
#define ccPULL_ARROW_W  18
#define ccPULL_ARROW_H  18
#define ccPULL_ACTIVITY_W   25
#define ccPULL_ACTIVITY_H   25

#define ccLABEL_TEXT1   @"下拉可以刷新"
#define ccLABEL_TEXT2   @"松开即可刷新"
#define ccLABEL_TEXT3   @"正在刷新..."

@interface XCRefreshHeaderView : XCRefreshHeader
{
    UIImageView     *_bgImageView;
    UIImageView     *_arrowImageView;
    UILabel         *_label;
    UIActivityIndicatorView *_activityView;
}
@end
