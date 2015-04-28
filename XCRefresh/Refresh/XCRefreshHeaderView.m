//
//  XCRefreshHeaderView.m
//  XCDevKit
//
//  Created by 钧泰科技 on 15/4/27.
//  Copyright (c) 2015年 wxc. All rights reserved.
//

#import "XCRefreshHeaderView.h"
#import "XCResourceManage.h"

@implementation XCRefreshHeaderView

- (void)initView
{
    self.backgroundColor = [UIColor whiteColor];
    
    _bgImageView = [[UIImageView alloc] initWithImage:[[XCResourceManage sharedXCResourceManage] getImage:ccPULL_BG_IMAGE]];
    _bgImageView.frame = self.bounds;
    _bgImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bgImageView];
    [_bgImageView release];
    
    _arrowImageView = [[UIImageView alloc] initWithImage:[[XCResourceManage sharedXCResourceManage] getImage:ccPULL_ARROW_IMAGE]];
    _arrowImageView.bounds = CGRectMake(0, 0, ccPULL_ARROW_W, ccPULL_ARROW_H);
    _arrowImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - (ccPULL_ARROW_H/2+25));
    _arrowImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_arrowImageView];
    [_arrowImageView release];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.bounds = CGRectMake(0, 0, ccPULL_ACTIVITY_W, ccPULL_ACTIVITY_H);
    _activityView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - (ccPULL_ACTIVITY_H/2+25));
    _activityView.hidden = YES;
    [self addSubview:_activityView];
    [_activityView release];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 25, self.frame.size.width, 20)];
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
    _label.textAlignment = UITextAlignmentCenter;
    _label.text = ccLABEL_TEXT1;
    _label.font = [UIFont systemFontOfSize:12];
    [self addSubview:_label];
    [_label release];
}

- (void)layoutSubviews
{
    _bgImageView.frame = self.bounds;
    _arrowImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - (ccPULL_ARROW_H/2+25));
    _activityView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - (ccPULL_ACTIVITY_H/2+25));
    _label.frame = CGRectMake(0, self.frame.size.height - 25, self.frame.size.width, 20);
}

//空闲状态样式
- (void)refreshHeaderStateIdls
{
    _label.text = ccLABEL_TEXT1;
    _arrowImageView.hidden = NO;
    _arrowImageView.transform = CGAffineTransformIdentity;
    _activityView.hidden = YES;
    [_activityView stopAnimating];
}
- (void)refreshHeaderStatePulling
{
    [super refreshHeaderStatePulling];
    
    _label.text = ccLABEL_TEXT2;
    [UIView animateWithDuration:0.25 animations:^{
        _arrowImageView.transform = CGAffineTransformMakeRotation(-180*M_PI/180);
    }];
}
- (void)refreshHeaderStateRefreshing
{
    [super refreshHeaderStateRefreshing];
    
    _label.text = ccLABEL_TEXT3;
    _arrowImageView.hidden = YES;
    _activityView.hidden = NO;
    [_activityView startAnimating];
}
- (void)refreshHeaderStateWillRefresh
{
    [super refreshHeaderStateWillRefresh];
    _label.text = ccLABEL_TEXT1;
    [UIView animateWithDuration:0.25 animations:^{
        _arrowImageView.transform = CGAffineTransformIdentity;
    }];
}
- (void)refreshHeaderStateFinished
{
    [super refreshHeaderStateFinished];
}
@end
