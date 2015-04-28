//
//  VTAppResourceManage.m
//  VTX
//
//  Created by wxc on 14/11/10.
//  Copyright (c) 2014年 wxc. All rights reserved.
//

#import "XCResourceManage.h"

@interface XCResourceManage ()
{
    XCResource *_appResource;
}
@end

@implementation XCResourceManage
- (void)dealloc
{
    [_appResource release];
    [_mainBundle release];
    [super dealloc];
}

DEFINE_SINGLETON_FOR_CLASS(XCResourceManage);

- (id)init
{
    if (self = [super init])
    {
        self.mainBundle = [[NSBundle mainBundle] bundlePath];
    }
    return self;
}

- (void)initResource
{
    _appResource = [[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:VTAPP_CURRENT_RES]] retain];
    if (_appResource == nil)
    {
        _appResource = [[XCResource alloc] init];
        _appResource.pageSettingPath = @"/Pages.bundle";
        _appResource.cssStylePath = @"/CSS.bundle";
        _appResource.imagesPath = @"/Images.bundle";
        _appResource.configPath = @"/Config.bundle";
        _appResource.xmlPath = @"/XML.bundle";
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:_appResource] forKey:VTAPP_CURRENT_RES];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (XCResource *)settingResource:(NSString *)imagesPath xmlPath:(NSString *)xmlPath pageSettingPath:(NSString *)pageSettingPath cssStylePath:(NSString *)cssStylePath configPath:(NSString *)configPath
{
    if (imagesPath)
        _appResource.imagesPath = imagesPath;

    if (xmlPath)
        _appResource.xmlPath = xmlPath;
    
    if (pageSettingPath)
        _appResource.pageSettingPath = pageSettingPath;
    
    if (cssStylePath)
        _appResource.cssStylePath = cssStylePath;
    
    if (configPath)
        _appResource.configPath = configPath;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:_appResource] forKey:VTAPP_CURRENT_RES];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return _appResource;
}

- (NSString *)getImagesPath:(NSString *)file
{
    return [self.mainBundle stringByAppendingFormat:@"%@/%@",_appResource.imagesPath,file];
}
- (NSString *)getXmlPath:(NSString *)file
{
    return [self.mainBundle stringByAppendingFormat:@"%@/%@",_appResource.xmlPath,file];
}
- (NSString *)getPageSettingPath:(NSString *)file
{
    return [self.mainBundle stringByAppendingFormat:@"%@/%@",_appResource.pageSettingPath,file];
}
- (NSString *)getCssStylePath:(NSString *)file
{
    return [self.mainBundle stringByAppendingFormat:@"%@/%@",_appResource.cssStylePath,file];
}
- (NSString *)getConfigPath:(NSString *)file
{
    return [self.mainBundle stringByAppendingFormat:@"%@/%@",_appResource.configPath,file];
}

//获取资源包路径
- (NSString *)getImagesPath
{
    return [self.mainBundle stringByAppendingFormat:@"%@",_appResource.imagesPath];
}
- (NSString *)getXmlPath
{
    return [self.mainBundle stringByAppendingFormat:@"%@",_appResource.xmlPath];
}
- (NSString *)getPageSettingPath
{
    return [self.mainBundle stringByAppendingFormat:@"%@",_appResource.pageSettingPath];
}
- (NSString *)getCssStylePath
{
    return [self.mainBundle stringByAppendingFormat:@"%@",_appResource.cssStylePath];
}
- (NSString *)getConfigPath
{
    return [self.mainBundle stringByAppendingFormat:@"%@",_appResource.configPath];
}

- (UIImage *)getImage:(NSString *)image
{
    return [UIImage imageWithContentsOfFile:[self getImagesPath:image]];
}
@end



@implementation XCResource
- (void)dealloc
{
    [_imagesPath release];
    [_xmlPath release];
    [_pageSettingPath release];
    [_cssStylePath release];
    [_configPath release];
    [super dealloc];
}


//将对象编码(即:序列化)
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_imagesPath==nil?@"":_imagesPath forKey:@"imagesPath"];
    [aCoder encodeObject:_xmlPath==nil?@"":_xmlPath forKey:@"xmlPath"];
    [aCoder encodeObject:_pageSettingPath==nil?@"":_pageSettingPath forKey:@"pageSettingPath"];
    [aCoder encodeObject:_cssStylePath==nil?@"":_cssStylePath forKey:@"cssStylePath"];
    [aCoder encodeObject:_configPath==nil?@"":_configPath forKey:@"configPath"];
}

//将对象解码(反序列化)
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init])
    {
        self.imagesPath =[aDecoder decodeObjectForKey:@"imagesPath"];
        self.xmlPath = [aDecoder decodeObjectForKey:@"xmlPath"];
        self.pageSettingPath =[aDecoder decodeObjectForKey:@"pageSettingPath"];
        self.cssStylePath =[aDecoder decodeObjectForKey:@"cssStylePath"];
        self.configPath = [aDecoder decodeObjectForKey:@"configPath"];
    }
    return (self);
    
}
@end


