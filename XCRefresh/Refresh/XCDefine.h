//
//  XCDefine.h
//  XCDevKit
//
//  Created by 钧泰科技 on 15/4/17.
//  Copyright (c) 2015年 wxc. All rights reserved.
//

#define DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[super alloc] init]; \
}); \
return shared##className; \
}

#define IOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0 ? YES:NO)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0 ? YES:NO)
#define IOS6 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 6.0 ? YES:NO)
#define IOS5 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 5.0 ? YES:NO)
#define IOS4 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 4.0 ? YES:NO)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
