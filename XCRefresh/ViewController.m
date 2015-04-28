//
//  ViewController.m
//  XCRefresh
//
//  Created by 钧泰科技 on 15/4/28.
//  Copyright (c) 2015年 wxc. All rights reserved.
//

#import "ViewController.h"
#import "XCRefreshScrollView+A.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    [_tableView addRefreshHeaderAddBlock:^(UIScrollView *scrollView) {
        NSLog(@"1");
    }];
    [_tableView addRefreshFooterAddBlock:^(UIScrollView *scrollView) {
        NSLog(@"2");
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.backgroundColor = [UIColor grayColor];
    btn.frame = CGRectMake(0, 222, 50, 50);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick
{
    [_tableView refreshFinished];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellI = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellI];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellI] autorelease];
    }
    cell.backgroundColor = [UIColor redColor];
    cell.textLabel.text = @"1111";
    
    return cell;
}

@end
