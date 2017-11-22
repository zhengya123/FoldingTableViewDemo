//
//  ZYTestViewController.m
//  ZY_FoldingTableViewDemo
//
//  Created by 中商国际 on 2017/11/22.
//  Copyright © 2017年 中商国际. All rights reserved.
//

#import "ZYTestViewController.h"


@interface ZYTestViewController () <ZYFoldingTableViewDelegate>

@property (nonatomic, weak) ZYFoldingTableView *foldingTableView;
@property (nonatomic, strong) NSMutableArray * dataArr;


@end

@implementation ZYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建tableView
    [self setupFoldingTableView];
    [self.dataArr addObjectsFromArray:@[
                                        @{@"sectionName":@"第1组",@"detailArr":@[
                                                  @{@"title":@"row1-1"},
                                                  @{@"title":@"row1-2"}
                                                  ]},
                                        @{@"sectionName":@"第2组",@"detailArr":@[
                                                  @{@"title":@"row2-1"},
                                                  @{@"title":@"row2-2"},
                                                  @{@"title":@"row2-3"}
                                                  ]},
                                        @{@"sectionName":@"第3组",@"detailArr":@[
                                                  @{@"title":@"row3-1"},
                                                  @{@"title":@"row3-2"},
                                                  @{@"title":@"row3-3"},
                                                  @{@"title":@"row3-4"}
                                                  ]},
                                        @{@"sectionName":@"第4组",@"detailArr":@[
                                                  @{@"title":@"row4-1"},
                                                  @{@"title":@"row4-2"},
                                                  @{@"title":@"row4-3"},
                                                  @{@"title":@"row4-4"},
                                                  @{@"title":@"row4-5"}
                                                  ]},
                                        @{@"sectionName":@"第5组",@"detailArr":@[
                                                  @{@"title":@"row5-1"},
                                                  @{@"title":@"row5-2"},
                                                  @{@"title":@"row5-3"},
                                                  @{@"title":@"row5-4"},
                                                  @{@"title":@"row5-5"},
                                                  @{@"title":@"row5-6"},
                                                  ]},
                                        @{@"sectionName":@"第6组",@"detailArr":@[
                                                  @{@"title":@"row6-1"},
                                                  @{@"title":@"row6-2"},
                                                  @{@"title":@"row6-3"},
                                                  @{@"title":@"row6-4"},
                                                  @{@"title":@"row6-5"},
                                                  @{@"title":@"row6-6"},
                                                  @{@"title":@"row6-7"},
                                                  @{@"title":@"row6-8"}
                                                  ]}
                                        ]];
    [self.foldingTableView reloadData];
}

// 创建tableView
- (void)setupFoldingTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZYFoldingTableView *foldingTableView = [[ZYFoldingTableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    _foldingTableView = foldingTableView;
    
    [self.view addSubview:foldingTableView];
    foldingTableView.foldingDelegate = self;
    
    if (self.arrowPosition) {
        foldingTableView.foldingState = ZYFoldingSectionStateShow;
    }
}

#pragma mark - YUFoldingTableViewDelegate / required（必须实现的代理）
// 返回箭头的位置
- (ZYFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(ZYFoldingTableView *)zyTableView
{
    // 没有赋值，默认箭头在左
    return self.arrowPosition ? :ZYFoldingSectionHeaderArrowPositionRight;
}
- (NSInteger )numberOfSectionForYUFoldingTableView:(ZYFoldingTableView *)zyTableView
{
    return self.dataArr.count;
}
- (NSInteger )zyFoldingTableView:(ZYFoldingTableView *)zyTableView numberOfRowsInSection:(NSInteger )section
{
    NSArray * ar = [self.dataArr[section] objectForKey:@"detailArr"];
    return ar.count;
}
- (CGFloat )zyFoldingTableView:(ZYFoldingTableView *)zyTableView heightForHeaderInSection:(NSInteger )section
{
    return 50;
}
- (CGFloat )zyFoldingTableView:(ZYFoldingTableView *)zyTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSString *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%@",[self.dataArr[section] objectForKey:@"sectionName"]];
}
- (UITableViewCell *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [zyTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.dataArr[indexPath.section] objectForKey:@"detailArr"][indexPath.row] objectForKey:@"title"]];
    
    return cell;
}
- (void )zyFoldingTableView:(ZYFoldingTableView *)zyTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [zyTableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击了== %@",[NSString stringWithFormat:@"%@",[[self.dataArr[indexPath.section] objectForKey:@"detailArr"][indexPath.row] objectForKey:@"title"]]);
}

#pragma mark - YUFoldingTableViewDelegate / optional （可选择实现的）

- (NSString *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView descriptionForHeaderInSection:(NSInteger )section
{
    return @"";
}
- (UIColor *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView backgroundColorForHeaderInSection:(NSInteger)section{
    //return [UIColor purpleColor];
    return [UIColor colorWithRed:102/255.f green:102/255.f blue:255/255.f alpha:1.f];
    
}
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
@end
