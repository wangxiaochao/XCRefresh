//
//  XCRefreshFooterView.m
//  XCDevKit
//
//  Created by 钧泰科技 on 15/4/27.
//  Copyright (c) 2015年 wxc. All rights reserved.
//

#import "XCRefreshFooter.h"
#import "XCResourceManage.h"
#import "XCRefreshHeader.h"

@implementation XCRefreshFooter

+ (instancetype)createForView:(UIScrollView *)scrollView
{
    XCRefreshFooter *view = [[self alloc] initWithFrame:CGRectMake(0, scrollView.contentSize.height < scrollView.frame.size.height?scrollView.frame.size.height:scrollView.contentSize.height, scrollView.frame.size.width, DOWN_CHECK_H)];
    view.scrollView = scrollView;
    return view;
}
- (void)dealloc
{
    [_loadMore release];
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
    if ([keyPath isEqualToString:@"contentSize"] || [keyPath isEqualToString:@"frame"])
    {
        CGFloat f = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
        
        self.frame = CGRectMake(0, self.scrollView.contentSize.height < f?f:self.scrollView.contentSize.height, self.scrollView.frame.size.width, DOWN_CHECK_H);
    }
    
    if (self.state == xcRefreshFooterStateNoMoreData)
    {
        return;
    }
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden || self.state == xcRefreshFooterStateRefreshing || self.header.state == xcRefreshHeaderStateRefreshing) return;
    
    // 根据contentOffset调整state
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self adjustStateWithContentOffset];
    }
}

- (void)adjustStateWithContentOffset
{
    CGFloat offsetY = self.scrollView.contentOffset.y;
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.bottom;

    CGFloat f = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    
    CGFloat a = offsetY + self.scrollView.frame.size.height + happenOffsetY;
    // 如果是向上滚动到看不见头部控件，直接返回
    if (a <= self.scrollView.contentSize.height)
    {
        return;
    }
    
    if (self.scrollView.isDragging == YES)
    {
        if (self.scrollView.contentSize.height <= f)   //行数过少
        {
            if (offsetY + self.scrollViewOriginalInset.top > 0 && offsetY + self.scrollViewOriginalInset.top < DOWN_CHECK_H)
            {
                if (self.state != xcRefreshFooterStateWillRefresh)
                {
                    self.state = xcRefreshFooterStateWillRefresh;   //即将刷新 前往可以刷新的过程
                }
                [self toRefreshFooter];
            }
        }
        else
        {
            if (a > self.scrollView.contentSize.height && a < self.scrollView.contentSize.height + DOWN_CHECK_H)
            {
                if (self.state != xcRefreshFooterStateWillRefresh)
                {
                    self.state = xcRefreshFooterStateWillRefresh;   //即将刷新 前往可以刷新的过程
                }
                [self toRefreshFooter];
            }
        }
        
        if (self.state != xcRefreshFooterStatePulling && self.state == xcRefreshFooterStateWillRefresh)
        {
            self.state = xcRefreshFooterStatePulling;       //松开即可加载更多了
        }

    }
    else
    {
        if (self.state == xcRefreshFooterStatePulling && self.state != xcRefreshFooterStateRefreshing)
        {
            self.state = xcRefreshFooterStateRefreshing;            //加载更多
        }
    }
        
}

- (void)setState:(XCRefreshFooterState)state
{
    _state = state;
    switch (_state)
    {
        case xcRefreshFooterStateIdle:
            [self refreshFooterStateIdle];
            break;
        case xcRefreshFooterStatePulling:
            [self refreshFooterStatePulling];
            break;
        case xcRefreshFooterStateRefreshing:
            [self refreshFooterStateRefreshing];
            break;
        case xcRefreshFooterStateWillRefresh:
            [self refreshHeaderStateWillRefresh];
            break;
        case xcRefreshFooterStateNoMoreData:
            [self refreshFooterStateNoMoreData];
            break;
        case xcRefreshFooterStateFinished:
            [self refreshFooterStateFinished];
            break;
        default:
            break;
    }
}


//空闲状态
- (void)refreshFooterStateIdle
{
}
//松开即可加载更多
- (void)refreshFooterStatePulling
{
    
}
//正在刷新中的状态
- (void)refreshFooterStateRefreshing
{
    if (_loadMore)
    {
        _loadMore(self.scrollView);
    }
    if ([_delegate respondsToSelector:@selector(loadMore:)])
    {
        [_delegate loadMore:self.scrollView];
    }
    
    CGFloat f = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    if (self.scrollView.contentSize.height < f)
    {
        f = f;
    }
    else
        f = self.scrollViewOriginalInset.bottom+DOWN_CHECK_H;
    
    [UIView animateWithDuration:ANMAITON_DES animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollViewOriginalInset.top, self.scrollViewOriginalInset.left, f, self.scrollViewOriginalInset.right);
    }];
}
////即将刷新的状态 == 不可以刷新状态 因为滑动距离还不够
- (void)refreshHeaderStateWillRefresh
{
    NSLog(@"--- 还不能加载更多");
}
// 所有数据加载完毕，没有更多的数据了
- (void)refreshFooterStateNoMoreData
{
    
}
//加载完成
- (void)refreshFooterStateFinished
{
    [UIView animateWithDuration:ANMAITON_DES animations:^{
        self.scrollView.contentInset = self.scrollViewOriginalInset;
    } completion:^(BOOL com){
        self.state = xcRefreshFooterStateIdle;  //空闲状态
    }];
}

//前往可以刷新过程 -1 --- -54距离不停调用
- (void)toRefreshFooter
{
    
}

@end
