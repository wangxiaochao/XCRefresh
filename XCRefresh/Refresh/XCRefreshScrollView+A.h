//
//  XCRefreshScrollView+A.h
//  XCDevKit
//
//  Created by 钧泰科技 on 15/4/27.
//  Copyright (c) 2015年 wxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCRefreshHeader.h"
#import "XCRefreshFooter.h"

#define PULL_MESSAGE_IMG_NAME @"loadingBackgroud.png"
#define PULL_MESSAGE_IMG_H  26
#define PULL_MESSAGE_SHOW_ANMATION_TIME 0.85
#define PULL_MESSAGE_SHOW_TIME 1                    //提示栏默认停留1秒钟后开始消失动画

@interface  UIScrollView(XCRefreshScrollView_A)
@property (nonatomic,assign,readonly) XCRefreshHeader *header;
@property (nonatomic,assign,readonly) XCRefreshFooter *footer;

//注入刷新控件 回调为block
- (void)addRefreshHeaderAddBlock:(void (^)(UIScrollView *scrollView))loading;
- (void)addRefreshFooterAddBlock:(void (^)(UIScrollView *scrollView))loading;

//注入刷新控件 回调为代理
- (void)addRefreshHeaderAddTag:(id)tag;
- (void)addRefreshFooterAddTag:(id)tag;

//注入刷新控件 回调为block
- (void)addRefreshHeaderAddBlock:(void (^)(UIScrollView *scrollView))loading header:(Class)header;
- (void)addRefreshFooterAddBlock:(void (^)(UIScrollView *scrollView))loading footer:(Class)footer;

//注入刷新控件 回调为代理
- (void)addRefreshHeaderAddTag:(id)tag header:(Class)header;
- (void)addRefreshFooterAddTag:(id)tag footer:(Class)footer;

//刷新完成
- (void)refreshFinished;

//提示消息
- (void)loadingWithMessage:(NSString *)msg toView:(UIView *)aView dure:(CGFloat)dure image:(UIImage *)image;
- (void)loadingWithMessage:(NSString *)msg toView:(UIView *)aView dure:(CGFloat)dure;
- (void)loadingWithMessage:(NSString *)msg toView:(UIView *)aView image:(UIImage *)image;
- (void)loadingWithMessage:(NSString *)msg toView:(UIView *)aView;
- (void)loadingWithMessage:(NSString *)msg dure:(CGFloat)dure image:(UIImage *)image;
- (void)loadingWithMessage:(NSString *)msg dure:(CGFloat)dure;
- (void)loadingWithMessage:(NSString *)msg image:(UIImage *)image;
- (void)loadingWithMessage:(NSString *)msg;
@end
