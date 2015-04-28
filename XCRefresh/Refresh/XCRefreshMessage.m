//
//  XCPullTableMessage.m
//  XCPullTable
//
//  Created by wxc on 14-4-28.
//  Copyright (c) 2014年 wxc. All rights reserved.
//

#import "XCRefreshMessage.h"

@implementation XCRefreshMessage
@synthesize imgage=_imgage;

- (void)dealloc
{
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [UIColor clearColor];
    
    _imgage = [[UIImageView alloc] initWithFrame:self.bounds];
    _imgage.backgroundColor = [UIColor clearColor];
    [self addSubview:_imgage];
    [_imgage release];
    
    _label = [[UILabel alloc] initWithFrame:self.bounds];
    _label.backgroundColor = [UIColor clearColor];
    _label.font = [UIFont systemFontOfSize:12];
    _label.textColor = [UIColor blackColor];
    _label.textAlignment = UITextAlignmentCenter;
    [self addSubview:_label];
    [_label release];
}
@end
