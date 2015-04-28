//
//  XCRefreshFooterView.h
//  XCDevKit
//
//  Created by 钧泰科技 on 15/4/27.
//  Copyright (c) 2015年 wxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "XCRefreshComponent.h"

#define DOWN_CHECK_H 45                             //加载更多检测范围

typedef enum {
    xcRefreshFooterStateIdle = 1,   // 普通闲置状态
    xcRefreshFooterStatePulling,    //松开即可加载更多
    xcRefreshFooterStateRefreshing, // 正在刷新中的状态
    xcRefreshFooterStateWillRefresh, ////即将刷新的状态 == 不可以刷新状态 因为滑动距离还不够
    xcRefreshFooterStateNoMoreData,  // 所有数据加载完毕，没有更多的数据了
    xcRefreshFooterStateFinished    //加载完成
} XCRefreshFooterState;

@protocol XCRefreshFooterDeleagte <NSObject>
- (void)loadMore:(UIScrollView *)scrollView;
@end

@class XCRefreshHeader;

@interface XCRefreshFooter : XCRefreshComponent
{
}
@property (nonatomic,assign) XCRefreshFooterState state;
@property (nonatomic,assign) XCRefreshHeader *header;
@property (nonatomic,copy) void (^loadMore)(UIScrollView *scrollView);
@property (nonatomic,assign) id<XCRefreshFooterDeleagte> delegate;

+ (instancetype)createForView:(UIScrollView *)scrollView;

//空闲状态
- (void)refreshFooterStateIdle;
//松开即可加载更多
- (void)refreshFooterStatePulling;
//正在刷新中的状态
- (void)refreshFooterStateRefreshing;
////即将刷新的状态 == 不可以刷新状态 因为滑动距离还不够
- (void)refreshHeaderStateWillRefresh;
// 所有数据加载完毕，没有更多的数据了
- (void)refreshFooterStateNoMoreData;
//加载完成
- (void)refreshFooterStateFinished;

//前往可以刷新过程 -1 --- -54距离不停调用
- (void)toRefreshFooter;
@end
