//
//  ViewController.m
//  ZY_FoldingTableViewDemo
//
//  Created by 中商国际 on 2017/11/22.
//  Copyright © 2017年 中商国际. All rights reserved.
//

#import "ViewController.h"
#import "ZYFoldingTableView.h"
#import "ZYTestViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) ZYFoldingSectionHeaderArrowPosition arrowPosition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"demo演示";
    // 创建tableView
    [self setupTableView];
}

// 创建tableView
- (void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView = [[ZYFoldingTableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    _tableView = tableView;
    tableView.rowHeight = 50;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = [NSString stringWithFormat:@"test %ld (%@)",indexPath.row + 1, indexPath.row ? @"默认展开" : @"默认关闭"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYTestViewController *testVc = [[ZYTestViewController alloc] init];
    testVc.arrowPosition = indexPath.row;
    [self.navigationController pushViewController:testVc animated:YES];
}


@end
