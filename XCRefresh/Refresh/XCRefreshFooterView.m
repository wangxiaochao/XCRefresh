//
//  XCRefreshFooterView.m
//  XCDevKit
//
//  Created by 钧泰科技 on 15/4/28.
//  Copyright (c) 2015年 wxc. All rights reserved.
//

#import "XCRefreshFooterView.h"
#import "XCResourceManage.h"

@implementation XCRefreshFooterView
- (void)initView
{
    self.backgroundColor = [UIColor redColor];
    
    _bgImageView = [[UIImageView alloc] initWithImage:[[XCResourceManage sharedXCResourceManage] getImage:ccMORE_BG_IMAGE_NAME]];
    _bgImageView.frame = self.bounds;
    _bgImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bgImageView];
    [_bgImageView release];
    
    _stateLable = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-ccMORE_STATE_LABEL_WIDTH/2, 15, ccMORE_STATE_LABEL_WIDTH, ccMORE_STATE_LABEL_HEIGHT)];
    _stateLable.backgroundColor = [UIColor clearColor];
    _stateLable.textColor = ccMORE_STATE_LABEL_TEXTCOLOR;
    _stateLable.font = ccMORE_STATE_LABEL_FONT;
    _stateLable.text = ccMORE_STATE_TEXT_LOADMORE;
    _stateLable.textAlignment = UITextAlignmentCenter;
    [self addSubview:_stateLable];
    [_stateLable release];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.frame = CGRectMake(_stateLable.frame.origin.x-ccMORE_ACTIVITY_WIDTH-5, 10, ccMORE_ACTIVITY_WIDTH, ccMORE_ACTIVITY_HEIGHT);
    _activityView.hidden = YES;
    [self addSubview:_activityView];
    [_activityView release];
}

- (void)layoutSubviews
{
    _bgImageView.frame = self.bounds;
    _stateLable.frame = CGRectMake(self.frame.size.width/2-ccMORE_STATE_LABEL_WIDTH/2, 15, ccMORE_STATE_LABEL_WIDTH, ccMORE_STATE_LABEL_HEIGHT);
    _activityView.frame = CGRectMake(_stateLable.frame.origin.x-ccMORE_ACTIVITY_WIDTH-5, 10, ccMORE_ACTIVITY_WIDTH, ccMORE_ACTIVITY_HEIGHT);
}


//空闲状态
- (void)refreshFooterStateIdle
{
    [super refreshFooterStateIdle];
    
    [_activityView stopAnimating];
    _activityView.hidden = YES;
    _stateLable.text = ccMORE_STATE_TEXT_LOADMORE;
}
//松开即可加载更多
- (void)refreshFooterStatePulling
{
    [super refreshFooterStatePulling];
    
    [_activityView stopAnimating];
    _activityView.hidden = YES;
    _stateLable.text = ccMORE_STATE_TEXT_DID_LOADING;
}
//正在刷新中的状态
- (void)refreshFooterStateRefreshing
{
    [super refreshFooterStateRefreshing];
    _activityView.hidden = NO;
    [_activityView startAnimating];
    _stateLable.text = ccMORE_STATE_TEXT_LOADING;
}
////即将刷新的状态 == 不可以刷新状态 因为滑动距离还不够
- (void)refreshHeaderStateWillRefresh
{
    [super refreshHeaderStateWillRefresh];
    
    _stateLable.text = ccMORE_STATE_TEXT_LOADMORE;
}
// 所有数据加载完毕，没有更多的数据了
- (void)refreshFooterStateNoMoreData
{
    [super refreshFooterStateNoMoreData];
    
    [_activityView stopAnimating];
    _activityView.hidden = YES;
    _stateLable.text = ccMORE_STATE_TEXT_LOADMORE;
}
//加载完成
- (void)refreshFooterStateFinished
{
    [super refreshFooterStateFinished];
    
    _activityView.hidden = NO;
    [_activityView startAnimating];
    _stateLable.text = ccMORE_STATE_TEXT_LOADING;
}

//前往可以刷新过程 -1 --- -54距离不停调用
- (void)toRefreshFooter
{
    [super toRefreshFooter];
}
@end
