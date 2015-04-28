//
//  XCRefresh.m
//  XCDevKit
//
//  Created by 钧泰科技 on 15/4/28.
//  Copyright (c) 2015年 wxc. All rights reserved.
//

#import "XCRefreshComponent.h"
#import "XCResourceManage.h"

@implementation XCRefreshComponent

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self.scrollView removeObserver:self forKeyPath:@"contentInset"];
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.scrollView removeObserver:self forKeyPath:@"frame"];
    [super dealloc];
}
- (id)init
{
    if (self = [self initWithFrame:CGRectZero])
    {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initView];
    }
    return self;
}

- (void)initView
{
    _pullId = [self loadId:@"pull.wav"];
    _normalId = [self loadId:@"normal.wav"];
    _refreshingId = [self loadId:@"refreshing.wav"];
    _endRefreshId = [self loadId:@"end_refreshing.wav"];
}
- (SystemSoundID)loadId:(NSString *)filename
{
    SystemSoundID ID;
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *url = [bundle URLForResource:[[XCResourceManage sharedXCResourceManage] getImagesPath:filename] withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &ID);
    return ID;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:@"contentOffset" context:nil];
    [self.superview removeObserver:self forKeyPath:@"contentInset" context:nil];
    [self.superview removeObserver:self forKeyPath:@"contentSize" context:nil];
    [self.superview removeObserver:self forKeyPath:@"frame" context:nil];
    if (newSuperview)
    {        
        [newSuperview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [newSuperview addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
        [newSuperview addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        [newSuperview addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        
        self.scrollView = (UIScrollView *)newSuperview;
    }
}
@end
