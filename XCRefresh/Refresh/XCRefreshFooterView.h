//
//  XCRefreshFooterView.h
//  XCDevKit
//
//  Created by 钧泰科技 on 15/4/28.
//  Copyright (c) 2015年 wxc. All rights reserved.
//

#import "XCRefreshFooter.h"

#define ccMORE_BG_IMAGE_NAME @""              //加载更多背景图片
#define ccMORE_ACTIVITY_WIDTH 25          //加载更多菊花宽
#define ccMORE_ACTIVITY_HEIGHT 25         //加载更多菊花高
#define ccMORE_STATE_LABEL_HEIGHT 16      //加载更多状态文本高
#define ccMORE_STATE_LABEL_WIDTH 80       //加载更多状态文本宽
#define ccMORE_STATE_LABEL_FONT [UIFont fontWithName:@"STHeitiSC-Light" size:12] //加载更多状态文本字体
#define ccMORE_STATE_LABEL_TEXTCOLOR [UIColor blackColor]         //加载更多状态文本字体颜色
#define ccMORE_STATE_TEXT_LOADMORE @"加载更多"
#define ccMORE_STATE_TEXT_DID_LOADING @"释放加载更多"
#define ccMORE_STATE_TEXT_LOADING  @"加载中..."
#define ccMORE_STATE_TEXT_NOTMORE  @"没有更多"

@interface XCRefreshFooterView : XCRefreshFooter
{
    UIImageView *_bgImageView;
    UILabel *_stateLable;
    UIActivityIndicatorView *_activityView;
}
@property (nonatomic,retain) UILabel *stateLable;
@property (nonatomic,retain) UIActivityIndicatorView *activityView;
@property (nonatomic,retain) UIImageView *bgImageView;
@end
