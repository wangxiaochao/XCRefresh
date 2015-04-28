//
//  XCRefresh.h
//  XCDevKit
//
//  Created by 钧泰科技 on 15/4/28.
//  Copyright (c) 2015年 wxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define ANMAITON_DES    0.25

@interface XCRefreshComponent : UIView
{
    SystemSoundID _pullId;
    SystemSoundID _normalId;
    SystemSoundID _refreshingId;
    SystemSoundID _endRefreshId;
}
@property (nonatomic,assign) UIEdgeInsets scrollViewOriginalInset;
@property (nonatomic,assign) UIScrollView *scrollView;

@end
