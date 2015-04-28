//
//  XCRefreshScrollView+A.m
//  XCDevKit
//
//  Created by 钧泰科技 on 15/4/27.
//  Copyright (c) 2015年 wxc. All rights reserved.
//

#import "XCRefreshScrollView+A.h"
#import <objc/runtime.h>
#import "XCRefreshHeaderView.h"
#import "XCRefreshFooterView.h"
#import "XCRefreshMessage.h"
#import "XCResourceManage.h"

@implementation UIScrollView (XCRefreshScrollView_A)

static char headerKey;
- (void)setHeader:(XCRefreshHeader *)header
{
    if (header != self.header) {
        [self.header removeFromSuperview];
        
        [self willChangeValueForKey:@"header"];
        objc_setAssociatedObject(self, &headerKey,
                                 header,
                                 OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"header"];
        
        [self addSubview:header];
    }
}

- (XCRefreshHeader *)header
{
    return objc_getAssociatedObject(self, &headerKey);
}

static char footerKey;
- (void)setFooter:(XCRefreshFooter *)footer
{
    if (footer != self.footer) {
        [self.footer removeFromSuperview];
        
        [self willChangeValueForKey:@"footer"];
        objc_setAssociatedObject(self, &footerKey,
                                 footer,
                                 OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"footer"];
        
        [self addSubview:footer];
    }
}

- (XCRefreshFooter *)footer
{
    return objc_getAssociatedObject(self, &footerKey);
}


- (void)addRefreshHeaderAddBlock:(void (^)(UIScrollView *))loading
{
    [self addRefreshHeaderAddBlock:loading header:[XCRefreshHeaderView class]];
}
- (void)addRefreshFooterAddBlock:(void (^)(UIScrollView *))loading
{
    [self addRefreshFooterAddBlock:loading footer:[XCRefreshFooterView class]];
}

- (void)addRefreshHeaderAddTag:(id)tag
{
    [self addRefreshHeaderAddTag:tag header:[XCRefreshHeaderView class]];
}
- (void)addRefreshFooterAddTag:(id)tag
{
    [self addRefreshFooterAddTag:self footer:[XCRefreshFooterView class]];
}


//注入刷新控件 回调为block
- (void)addRefreshHeaderAddBlock:(void (^)(UIScrollView *scrollView))loading header:(Class)header
{
    if (![header isSubclassOfClass:[XCRefreshHeader class]])
    {
        NSAssert(NO, @"传入刷新控件类型不对!");
    }
    
    XCRefreshHeader *headerView = [header createForView:self];
    self.header = headerView;
    headerView.loadRefresh = loading;
    [headerView release];
    
    headerView.footer = [self footer];
    [self footer].header = headerView;
}
- (void)addRefreshFooterAddBlock:(void (^)(UIScrollView *scrollView))loading footer:(Class)footer
{
    if (![footer isSubclassOfClass:[XCRefreshFooter class]])
    {
        NSAssert(NO, @"传入刷新控件类型不对!");
    }
    
    XCRefreshFooter *footerView = [footer createForView:self];
    self.footer = footerView;
    footerView.loadMore = loading;
    [footerView release];
    
    footerView.header = [self header];
    [self header].footer = footerView;
}

//注入刷新控件 回调为代理
- (void)addRefreshHeaderAddTag:(id)tag header:(Class)header
{
    if (![header isSubclassOfClass:[XCRefreshHeader class]])
    {
        NSAssert(NO, @"传入刷新控件类型不对!");
    }
    
    XCRefreshHeader *headerView = [header createForView:self];
    self.header = headerView;
    headerView.delegate = tag;
    [headerView release];
    
    headerView.footer = [self footer];
    [self footer].header = headerView;
}
- (void)addRefreshFooterAddTag:(id)tag footer:(Class)footer
{
    if (![footer isSubclassOfClass:[XCRefreshFooter class]])
    {
        NSAssert(NO, @"传入刷新控件类型不对!");
    }
    
    XCRefreshFooter *footerView = [footer createForView:self];
    self.footer = footerView;
    footerView.delegate = tag;
    [footerView release];
    
    footerView.header = [self header];
    [self header].footer = footerView;
}


- (void)refreshFinished
{
    [self header].state = xcRefreshHeaderStateFinished;
    [self footer].state = xcRefreshFooterStateFinished;
}


- (void)loadingWithMessage:(NSString *)msg toView:(UIView *)aView dure:(CGFloat)dure image:(UIImage *)image
{
    [self initWithMessage:msg toView:aView drue:dure image:image];
}
- (void)loadingWithMessage:(NSString *)msg toView:(UIView *)aView dure:(CGFloat)dure
{
    [self initWithMessage:msg toView:aView drue:dure image:[[XCResourceManage sharedXCResourceManage] getImage:PULL_MESSAGE_IMG_NAME]];
}
- (void)loadingWithMessage:(NSString *)msg toView:(UIView *)aView image:(UIImage *)image
{
    [self initWithMessage:msg toView:aView drue:PULL_MESSAGE_SHOW_TIME image:image];
}
- (void)loadingWithMessage:(NSString *)msg toView:(UIView *)aView
{
    [self initWithMessage:msg toView:aView drue:PULL_MESSAGE_SHOW_TIME image:[[XCResourceManage sharedXCResourceManage] getImage:PULL_MESSAGE_IMG_NAME]];
}
- (void)loadingWithMessage:(NSString *)msg dure:(CGFloat)dure image:(UIImage *)image
{
    [self initWithMessage:msg toView:self drue:dure image:image];
}
- (void)loadingWithMessage:(NSString *)msg dure:(CGFloat)dure
{
    [self initWithMessage:msg toView:self drue:dure image:[[XCResourceManage sharedXCResourceManage] getImage:PULL_MESSAGE_IMG_NAME]];
}
- (void)loadingWithMessage:(NSString *)msg image:(UIImage *)image
{
    [self initWithMessage:msg toView:self drue:PULL_MESSAGE_SHOW_TIME image:image];
}
- (void)loadingWithMessage:(NSString *)msg
{
    [self initWithMessage:msg toView:self drue:PULL_MESSAGE_SHOW_TIME image:[[XCResourceManage sharedXCResourceManage] getImage:PULL_MESSAGE_IMG_NAME]];
}

- (void)initWithMessage:(NSString *)msg toView:(UIView *)toView drue:(CGFloat)drue image:(UIImage *)image
{
    XCRefreshMessage *messgae = [[XCRefreshMessage alloc] initWithFrame:CGRectMake(0, -(PULL_MESSAGE_IMG_H), toView.frame.size.width, PULL_MESSAGE_IMG_H)];
    messgae.imgage.image = image;
    messgae.label.text = msg;
    [toView addSubview:messgae];
    [messgae release];
    
    [UIView animateWithDuration:PULL_MESSAGE_SHOW_ANMATION_TIME animations:^{
        messgae.frame = CGRectMake(0, 0, messgae.frame.size.width, messgae.frame.size.height);
    }completion:^(BOOL finfished){
        [self performSelector:@selector(removeMessgaeView:) withObject:messgae afterDelay:drue];
    }];
}
- (void)removeMessgaeView:(UIView *)obj
{
    [UIView animateWithDuration:PULL_MESSAGE_SHOW_ANMATION_TIME animations:^{
        obj.frame = CGRectMake(0, -obj.frame.size.height, obj.frame.size.width, obj.frame.size.height);
    }completion:^(BOOL finfished){
        [obj removeFromSuperview];
    }];
}
@end











