//
//  ZYFoldingTableView.h
//  ZY_FoldingTableViewDemo
//
//  Created by 中商国际 on 2017/11/22.
//  Copyright © 2017年 中商国际. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYFoldingSectionHeader.h"

@class ZYFoldingTableView;

@protocol ZYFoldingTableViewDelegate <NSObject>

@required
/**
 *  箭头的位置
 */
- (ZYFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(ZYFoldingTableView *)zyTableView;
/**
 *  返回section的个数
 */
- (NSInteger )numberOfSectionForYUFoldingTableView:(ZYFoldingTableView *)zyTableView;
/**
 *  cell的个数
 */
- (NSInteger )zyFoldingTableView:(ZYFoldingTableView *)zyTableView numberOfRowsInSection:(NSInteger )section;
/**
 *  header的高度
 */
- (CGFloat )zyFoldingTableView:(ZYFoldingTableView *)zyTableView heightForHeaderInSection:(NSInteger )section;
/**
 *  cell的高度
 */
- (CGFloat )zyFoldingTableView:(ZYFoldingTableView *)zyTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  header的标题
 */
- (NSString *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView titleForHeaderInSection:(NSInteger )section;
/**
 *  返回cell
 */
- (UITableViewCell *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  点击cell
 */
- (void )zyFoldingTableView:(ZYFoldingTableView *)zyTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  箭头图片
 */
- (UIImage *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView arrowImageForSection:(NSInteger )section;

// 下面是一些属性的设置

- (NSString *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView descriptionForHeaderInSection:(NSInteger )section;

- (UIColor *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView backgroundColorForHeaderInSection:(NSInteger )section;

- (UIFont *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView fontForTitleInSection:(NSInteger )section;

- (UIFont *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView fontForDescriptionInSection:(NSInteger )section;

- (UIColor *)zyFoldingTableView:(ZYFoldingTableView *)yuTableView textColorForTitleInSection:(NSInteger )section;

- (UIColor *)zyFoldingTableView:(ZYFoldingTableView *)zyTableView textColorForDescriptionInSection:(NSInteger )section;

@end



@interface ZYFoldingTableView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<ZYFoldingTableViewDelegate> foldingDelegate;

@property (nonatomic, assign) ZYFoldingSectionState foldingState;


@end
