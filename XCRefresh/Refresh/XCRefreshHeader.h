//
//  XRefreshHeadView.h
//  XCDevKit
//
//  Created by 钧泰科技 on 15/4/27.
//  Copyright (c) 2015年 wxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "XCRefreshComponent.h"

#define XCRefreshHeaderHeight 54.0

// 下拉刷新控件的状态
typedef enum {
    xcRefreshHeaderStateIdls = 1,       //空闲状态
    xcRefreshHeaderStatePulling = 2,  //松开就可以进行刷新的状态
    xcRefreshHeaderStateRefreshing, //正在刷新中的状态
    xcRefreshHeaderStateWillRefresh, //即将刷新的状态 == 不可以刷新状态 因为滑动距离还不够
    xcRefreshHeaderStateFinished     //刷新完成
} XRefreshHeaderState;

@protocol XCRefreshHeaderDelegate <NSObject>
- (void)loadRefresh:(UIScrollView *)scrollView;
@end

@class XCRefreshFooter;
@interface XCRefreshHeader : XCRefreshComponent
{
}
@property (nonatomic,assign) XRefreshHeaderState state;
@property (nonatomic,assign) XCRefreshFooter *footer;
@property (nonatomic,copy) void (^loadRefresh)(UIScrollView *scrollView);
@property (nonatomic,assign) id<XCRefreshHeaderDelegate> delegate;


+ (instancetype)createForView:(UIScrollView *)scrollView;

//空闲状态样式
- (void)refreshHeaderStateIdls;
//松开就可以刷新样式
- (void)refreshHeaderStatePulling;
//正在刷新样式
- (void)refreshHeaderStateRefreshing;
//将要可以刷新 还不能刷新样式
- (void)refreshHeaderStateWillRefresh;
//刷新完成动作
- (void)refreshHeaderStateFinished;

//前往可以刷新过程 -1 --- -54距离不停调用
- (void)toRefreshHeader;
@end
