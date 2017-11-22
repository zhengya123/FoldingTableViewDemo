//
//  ZYFoldingSectionHeader.h
//  ZY_FoldingTableViewDemo
//
//  Created by 中商国际 on 2017/11/22.
//  Copyright © 2017年 中商国际. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZYFoldingSectionState) {
    
    ZYFoldingSectionStateFlod, // 折叠
    ZYFoldingSectionStateShow, // 打开
};

// 箭头的位置
typedef NS_ENUM(NSUInteger, ZYFoldingSectionHeaderArrowPosition) {
    
    ZYFoldingSectionHeaderArrowPositionLeft,
    ZYFoldingSectionHeaderArrowPositionRight,
};

@protocol ZYFoldingSectionHeaderDelegate <NSObject>

- (void)zyFoldingSectionHeaderTappedAtIndex:(NSInteger)index;

@end


@interface ZYFoldingSectionHeader : UIView

@property (nonatomic, weak) id <ZYFoldingSectionHeaderDelegate> tapDelegate;

- (instancetype)initWithFrame:(CGRect)frame tag:(NSInteger)tag;

- (void)setupWithBackgroundColor:(UIColor *)backgroundColor
                     titleString:(NSString *)titleString
                      titleColor:(UIColor *)titleColor
                       titleFont:(UIFont *)titleFont
               descriptionString:(NSString *)descriptionString
                descriptionColor:(UIColor *)descriptionColor
                 descriptionFont:(UIFont *)descriptionFont
                      arrowImage:(UIImage *)arrowImage
                   arrowPosition:(ZYFoldingSectionHeaderArrowPosition)arrowPosition
                    sectionState:(ZYFoldingSectionState)sectionState;

@end

