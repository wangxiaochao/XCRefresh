//
//  XRefreshHeadView.m
//  XCDevKit
//
//  Created by 钧泰科技 on 15/4/27.
//  Copyright (c) 2015年 wxc. All rights reserved.
//

#import "XCRefreshHeader.h"
#import "XCResourceManage.h"
#import "XCRefreshFooter.h"

@implementation XCRefreshHeader

+ (instancetype)createForView:(UIScrollView *)scrollView
{
    XCRefreshHeader *view = [[self alloc] initWithFrame:CGRectMake(0, -XCRefreshHeaderHeight, scrollView.frame.size.width, XCRefreshHeaderHeight)];
    view.scrollView = scrollView;
    return view;
}

- (void)dealloc
{
    [_loadRefresh release];
    [super dealloc];
}

#pragma mark KVO属性监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentInset"])
    {
        if (self.state == 0)
        {
            self.scrollViewOriginalInset = self.scrollView.contentInset;
        }
    }
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden || self.state == xcRefreshHeaderStateRefreshing || self.footer.state == xcRefreshFooterStateRefreshing) return;
    
    // 根据contentOffset调整state
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self adjustStateWithContentOffset];
    }
}
- (void)adjustStateWithContentOffset
{
    CGFloat offsetY = self.scrollView.contentOffset.y;
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    if (offsetY >= happenOffsetY) return;
    
    CGFloat normal2pullingOffsetY = happenOffsetY + -XCRefreshHeaderHeight;
    
    if (self.scrollView.isDragging == YES)
    {
        if (offsetY < happenOffsetY && offsetY > normal2pullingOffsetY)
        {
            if (self.state != xcRefreshHeaderStateWillRefresh)
            {
                self.state = xcRefreshHeaderStateWillRefresh;   //即将刷新 前往可以刷新的过程
            }
            [self toRefreshHeader];
        }
        else                                //可以刷新了
        {
            if (self.state != xcRefreshHeaderStatePulling && self.state == xcRefreshHeaderStateWillRefresh)
            {
                self.state = xcRefreshHeaderStatePulling;   //松开就可以刷新了
            }
        }
    }
    else
    {
        if (self.state == xcRefreshHeaderStatePulling && self.state != xcRefreshHeaderStateRefreshing)
        {
            self.state = xcRefreshHeaderStateRefreshing;
        }
    }
    
    
}

- (void)setState:(XRefreshHeaderState)state
{
    _state = state;
    
    switch (_state) {
        case xcRefreshHeaderStateIdls:
            [self refreshHeaderStateIdls];
            break;
        case xcRefreshHeaderStatePulling:
            [self refreshHeaderStatePulling];
            break;
        case xcRefreshHeaderStateRefreshing:
            [self refreshHeaderStateRefreshing];
            break;
        case xcRefreshHeaderStateWillRefresh:
            [self refreshHeaderStateWillRefresh];
            break;
        case xcRefreshHeaderStateFinished:
            [self refreshHeaderStateFinished];
            break;
        default:
            break;
    }
}

//空闲状态样式
- (void)refreshHeaderStateIdls
{
    
}
//松开就可以刷新样式
- (void)refreshHeaderStatePulling
{
    AudioServicesPlaySystemSound(_pullId);
    
    NSLog(@"--- 松开就刷新");
}
//正在刷新样式
- (void)refreshHeaderStateRefreshing
{
    AudioServicesPlaySystemSound(_refreshingId);
    
    if (_loadRefresh)
    {
        _loadRefresh(self.scrollView);
    }
    if ([_delegate respondsToSelector:@selector(loadRefresh:)])
    {
        [_delegate loadRefresh:self.scrollView];
    }
    
    [UIView animateWithDuration:ANMAITON_DES animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollViewOriginalInset.top + XCRefreshHeaderHeight, self.scrollViewOriginalInset.left, self.scrollViewOriginalInset.bottom, self.scrollViewOriginalInset.right);
    }];
}
//将要可以刷新 还不能刷新样式
- (void)refreshHeaderStateWillRefresh
{
    NSLog(@"--- 还不能刷新");
}
//刷新完成动作
- (void)refreshHeaderStateFinished
{
    AudioServicesPlaySystemSound(_endRefreshId);
    
    [UIView animateWithDuration:ANMAITON_DES animations:^{
        self.scrollView.contentInset = self.scrollViewOriginalInset;
    } completion:^(BOOL com){
        self.state = xcRefreshHeaderStateIdls;  //空闲状态
    }];
}



- (void)toRefreshHeader
{
}
@end
