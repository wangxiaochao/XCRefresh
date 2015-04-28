//
//  VTAppResourceManage.h
//  VTX
//
//  Created by wxc on 14/11/10.
//  Copyright (c) 2014年 wxc. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "XCDefine.h"

#define VTAPP_CURRENT_RES   @"__VTAPP_CURRENT_RES__"
#define RESOURCE_CHANNGE_NOTIF @"__VT_RESOURCE_CHANNGE__"

@class XCResource;

@interface XCResourceManage : NSObject
@property (nonatomic,copy) NSString *mainBundle;         //主目录

DEFINE_SINGLETON_FOR_HEADER(XCResourceManage);

- (void)initResource;
- (XCResource *)settingResource:(NSString *)imagesPath xmlPath:(NSString *)xmlPath pageSettingPath:(NSString *)pageSettingPath cssStylePath:(NSString *)cssStylePath configPath:(NSString *)configPath;
//获取资源路径
- (NSString *)getImagesPath:(NSString *)file;
- (NSString *)getXmlPath:(NSString *)file;
- (NSString *)getPageSettingPath:(NSString *)file;
- (NSString *)getCssStylePath:(NSString *)file;
- (NSString *)getConfigPath:(NSString *)file;
//获取资源包路径
- (NSString *)getImagesPath;
- (NSString *)getXmlPath;
- (NSString *)getPageSettingPath;
- (NSString *)getCssStylePath;
- (NSString *)getConfigPath;
/////
- (UIImage *)getImage:(NSString *)image;
@end

@interface XCResource : NSObject<NSCoding>
@property (nonatomic,copy) NSString *imagesPath;         //图片资源
@property (nonatomic,copy) NSString *xmlPath;            //xml布局资源路径
@property (nonatomic,copy) NSString *pageSettingPath;    //组件/页面 装配资源
@property (nonatomic,copy) NSString *cssStylePath;       //样式资源路径
@property (nonatomic,copy) NSString *configPath;         //配置资源路径
@end