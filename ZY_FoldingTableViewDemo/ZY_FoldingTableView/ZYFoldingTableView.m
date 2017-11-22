//
//  ZYFoldingTableView.m
//  ZY_FoldingTableViewDemo
//
//  Created by 中商国际 on 2017/11/22.
//  Copyright © 2017年 中商国际. All rights reserved.
//

#import "ZYFoldingTableView.h"

@interface ZYFoldingTableView () <ZYFoldingSectionHeaderDelegate>

@property (nonatomic, strong) NSMutableArray *statusArray;

@end
@implementation ZYFoldingTableView

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}

#pragma mark - 创建数据源和代理

- (void)setupDelegateAndDataSource
{
    // 适配iOS 11
#ifdef __IPHONE_11_0
    if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
#endif
    
    self.delegate = self;
    self.dataSource = self;
    if (self.style == UITableViewStylePlain) {
        self.tableFooterView = [[UIView alloc] init];
    }
    // 添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChangeStatusBarOrientationNotification:)  name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (NSMutableArray *)statusArray
{
    if (!_statusArray) {
        _statusArray = [NSMutableArray array];
    }
    
    if (!_foldingState) {
        _foldingState = ZYFoldingSectionStateFlod;
    }
    
    if (_statusArray.count) {
        if (_statusArray.count > self.numberOfSections) {
            [_statusArray removeObjectsInRange:NSMakeRange(self.numberOfSections - 1, _statusArray.count - self.numberOfSections)];
        }else if (_statusArray.count < self.numberOfSections) {
            for (NSInteger i = self.numberOfSections - _statusArray.count; i < self.numberOfSections; i++) {
                [_statusArray addObject:[NSNumber numberWithInteger:_foldingState]];
            }
        }
    }else{
        for (NSInteger i = 0; i < self.numberOfSections; i++) {
            [_statusArray addObject:[NSNumber numberWithInteger:_foldingState]];
        }
    }
    return _statusArray;
}

- (void)onChangeStatusBarOrientationNotification:(NSNotification *)notification
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

#pragma mark - UI Configration

- (ZYFoldingSectionHeaderArrowPosition )perferedArrowPosition
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(perferedArrowPositionForYUFoldingTableView:)]) {
        return [_foldingDelegate perferedArrowPositionForYUFoldingTableView:self];
    }
    return ZYFoldingSectionHeaderArrowPositionRight;
}
- (UIColor *)backgroundColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(zyFoldingTableView:backgroundColorForHeaderInSection:)]) {
        return [_foldingDelegate zyFoldingTableView:self backgroundColorForHeaderInSection:section];
    }
    return [UIColor colorWithRed:102/255.f green:102/255.f blue:255/255.f alpha:1.f];
}
- (NSString *)titleForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(zyFoldingTableView:titleForHeaderInSection:)]) {
        return [_foldingDelegate zyFoldingTableView:self titleForHeaderInSection:section];
    }
    return [NSString string];
}
- (UIFont *)titleFontForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(zyFoldingTableView:fontForTitleInSection:)]) {
        return [_foldingDelegate zyFoldingTableView:self fontForTitleInSection:section];
    }
    return [UIFont boldSystemFontOfSize:16];
}
- (UIColor *)titleColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(zyFoldingTableView:textColorForTitleInSection:)]) {
        return [_foldingDelegate zyFoldingTableView:self textColorForTitleInSection:section];
    }
    return [UIColor whiteColor];
}
- (NSString *)descriptionForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(zyFoldingTableView:descriptionForHeaderInSection:)]) {
        return [_foldingDelegate zyFoldingTableView:self descriptionForHeaderInSection:section];
    }
    return [NSString string];
}
- (UIFont *)descriptionFontForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(zyFoldingTableView:fontForDescriptionInSection:)]) {
        return [_foldingDelegate zyFoldingTableView:self fontForDescriptionInSection:section];
    }
    return [UIFont boldSystemFontOfSize:13];
}

- (UIColor *)descriptionColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(zyFoldingTableView:textColorForDescriptionInSection:)]) {
        return [_foldingDelegate zyFoldingTableView:self textColorForDescriptionInSection:section];
    }
    return [UIColor whiteColor];
}

- (UIImage *)arrowImageForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(zyFoldingTableView:arrowImageForSection:)]) {
        return [_foldingDelegate zyFoldingTableView:self arrowImageForSection:section];
    }
    return [UIImage imageNamed:@"Arrow"];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(numberOfSectionForYUFoldingTableView:)]) {
        return [_foldingDelegate numberOfSectionForYUFoldingTableView:self];
    }else{
        return self.numberOfSections;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (((NSNumber *)self.statusArray[section]).integerValue == ZYFoldingSectionStateShow) {
        if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(zyFoldingTableView:numberOfRowsInSection:)]) {
            return [_foldingDelegate zyFoldingTableView:self numberOfRowsInSection:section];
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(zyFoldingTableView:heightForHeaderInSection:)]) {
        return [_foldingDelegate zyFoldingTableView:self heightForHeaderInSection:section];
    }else{
        return self.sectionHeaderHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(zyFoldingTableView:heightForRowAtIndexPath:)]) {
        return [_foldingDelegate zyFoldingTableView:self heightForRowAtIndexPath:indexPath];
    }else{
        return self.rowHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.style == UITableViewStylePlain) {
        return 0;
    }else{
        return 0.001;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZYFoldingSectionHeader *sectionHeaderView = [[ZYFoldingSectionHeader alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [self tableView:self heightForHeaderInSection:section])  tag:section];
    
    [sectionHeaderView setupWithBackgroundColor:[self backgroundColorForSection:section]
                                    titleString:[self titleForSection:section]
                                     titleColor:[self titleColorForSection:section]
                                      titleFont:[self titleFontForSection:section]
                              descriptionString:[self descriptionForSection:section]
                               descriptionColor:[self descriptionColorForSection:section]
                                descriptionFont:[self descriptionFontForSection:section]
                                     arrowImage:[self arrowImageForSection:section]
                                  arrowPosition:[self perferedArrowPosition]
                                   sectionState:((NSNumber *)self.statusArray[section]).integerValue];
    
    sectionHeaderView.tapDelegate = self;
    
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(zyFoldingTableView:cellForRowAtIndexPath:)]) {
        return [_foldingDelegate zyFoldingTableView:self cellForRowAtIndexPath:indexPath];
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCellIndentifier"];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(zyFoldingTableView:didSelectRowAtIndexPath:)]) {
        [_foldingDelegate zyFoldingTableView:self didSelectRowAtIndexPath:indexPath];
    }
}


#pragma mark - YUFoldingSectionHeaderDelegate

- (void)zyFoldingSectionHeaderTappedAtIndex:(NSInteger)index
{
    BOOL currentIsOpen = ((NSNumber *)self.statusArray[index]).boolValue;
    
    [self.statusArray replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:!currentIsOpen]];
    
    NSInteger numberOfRow = [_foldingDelegate zyFoldingTableView:self numberOfRowsInSection:index];
    NSMutableArray *rowArray = [NSMutableArray array];
    if (numberOfRow) {
        for (NSInteger i = 0; i < numberOfRow; i++) {
            [rowArray addObject:[NSIndexPath indexPathForRow:i inSection:index]];
        }
    }
    if (rowArray.count) {
        if (currentIsOpen) {
            [self deleteRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationTop];
        }else{
            [self insertRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationTop];
        }
    }
}


@end
