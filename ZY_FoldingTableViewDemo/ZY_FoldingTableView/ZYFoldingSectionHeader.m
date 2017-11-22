//
//  ZYFoldingSectionHeader.m
//  ZY_FoldingTableViewDemo
//
//  Created by 中商国际 on 2017/11/22.
//  Copyright © 2017年 中商国际. All rights reserved.
//

#import "ZYFoldingSectionHeader.h"
#define ZYFoldingSepertorLineWidth       0.3f
#define ZYFoldingMargin                  8.0f
#define ZYFoldingIconSize                24.0f


@interface ZYFoldingSectionHeader ()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *descriptionLabel;
@property (nonatomic, strong) UIImageView  *arrowImageView;
@property (nonatomic, strong) CAShapeLayer  *sepertorLine;
@property (nonatomic, assign) ZYFoldingSectionHeaderArrowPosition  arrowPosition;
@property (nonatomic, assign) ZYFoldingSectionState  sectionState;
@property (nonatomic, strong) UITapGestureRecognizer  *tapGesture;

@end


@implementation ZYFoldingSectionHeader

- (instancetype)initWithFrame:(CGRect)frame tag:(NSInteger)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = tag;
        [self setupSubviewsWithArrowPosition:ZYFoldingSectionHeaderArrowPositionRight];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupSubviewsWithArrowPosition:ZYFoldingSectionHeaderArrowPositionRight];
    
}

- (void)setupWithBackgroundColor:(UIColor *)backgroundColor
                     titleString:(NSString *)titleString
                      titleColor:(UIColor *)titleColor
                       titleFont:(UIFont *)titleFont
               descriptionString:(NSString *)descriptionString
                descriptionColor:(UIColor *)descriptionColor
                 descriptionFont:(UIFont *)descriptionFont
                      arrowImage:(UIImage *)arrowImage
                   arrowPosition:(ZYFoldingSectionHeaderArrowPosition)arrowPosition
                    sectionState:(ZYFoldingSectionState)sectionState
{
    
    [self setBackgroundColor:backgroundColor];
    
    [self setupSubviewsWithArrowPosition:arrowPosition];
    
    self.titleLabel.text = titleString;
    self.titleLabel.textColor = titleColor;
    self.titleLabel.font = titleFont;
    
    self.descriptionLabel.text = descriptionString;
    self.descriptionLabel.textColor = descriptionColor;
    self.descriptionLabel.font = descriptionFont;
    
    self.arrowImageView.image = arrowImage;
    self.arrowPosition = arrowPosition;
    self.sectionState = sectionState;
    
    if (sectionState == ZYFoldingSectionStateShow) {
        if (self.arrowPosition == ZYFoldingSectionHeaderArrowPositionRight) {
            self.arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        }else{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        }
    } else {
        if (self.arrowPosition == ZYFoldingSectionHeaderArrowPositionRight) {
            _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        }else{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
        }
    }
    
}
- (void)setupSubviewsWithArrowPosition:(ZYFoldingSectionHeaderArrowPosition)arrowPosition
{
    CGFloat labelWidth = (self.frame.size.width - ZYFoldingMargin*2 - ZYFoldingIconSize)/2;
    CGFloat labelHeight = self.frame.size.height;
    CGRect arrowRect = CGRectMake(0, (self.frame.size.height - ZYFoldingIconSize)/2, ZYFoldingIconSize, ZYFoldingIconSize);
    CGRect titleRect = CGRectMake(ZYFoldingMargin + ZYFoldingIconSize, 0, labelWidth, labelHeight);
    CGRect descriptionRect = CGRectMake(ZYFoldingMargin + ZYFoldingIconSize + labelWidth,  0, labelWidth, labelHeight);
    if (arrowPosition == ZYFoldingSectionHeaderArrowPositionRight) {
        arrowRect.origin.x = ZYFoldingMargin*2 + labelWidth*2;
        titleRect.origin.x = ZYFoldingMargin;
        descriptionRect.origin.x = ZYFoldingMargin + labelWidth;
    }
    
    [self.titleLabel setFrame:titleRect];
    [self.descriptionLabel setFrame:descriptionRect];
    [self.arrowImageView setFrame:arrowRect];
    [self.sepertorLine setPath:[self getSepertorPath].CGPath];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.arrowImageView];
    [self addGestureRecognizer:self.tapGesture];
    [self.layer addSublayer:self.sepertorLine];
    
}

- (void)shouldExpand:(BOOL)shouldExpand
{
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         if (shouldExpand) {
                             if (self.arrowPosition == ZYFoldingSectionHeaderArrowPositionRight) {
                                 self.arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
                             }else{
                                 self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
                             }
                         } else {
                             if (self.arrowPosition == ZYFoldingSectionHeaderArrowPositionRight) {
                                 _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
                             }else{
                                 self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
                             }
                         }
                     } completion:^(BOOL finished) {
                         if (finished == YES) {
                             self.sepertorLine.hidden = shouldExpand;
                         }
                     }];
}


- (void)onTapped:(UITapGestureRecognizer *)gesture
{
    [self shouldExpand:![NSNumber numberWithInteger:self.sectionState].boolValue];
    if (_tapDelegate && [_tapDelegate respondsToSelector:@selector(zyFoldingSectionHeaderTappedAtIndex:)]) {
        self.sectionState = [NSNumber numberWithBool:(![NSNumber numberWithInteger:self.sectionState].boolValue)].integerValue;
        [_tapDelegate zyFoldingSectionHeaderTappedAtIndex:self.tag];
    }
}

// MARK: -----------------------  getter

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _descriptionLabel.backgroundColor = [UIColor clearColor];
        _descriptionLabel.textAlignment = NSTextAlignmentRight;
    }
    return _descriptionLabel;
}
- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _arrowImageView.backgroundColor = [UIColor clearColor];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImageView;
}
- (CAShapeLayer *)sepertorLine
{
    if (!_sepertorLine) {
        _sepertorLine = [CAShapeLayer layer];
        _sepertorLine.strokeColor = [UIColor whiteColor].CGColor;
        _sepertorLine.lineWidth = ZYFoldingSepertorLineWidth;
    }
    return _sepertorLine;
}

- (UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapped:)];
    }
    return _tapGesture;
}

- (UIBezierPath *)getSepertorPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.frame.size.height - ZYFoldingSepertorLineWidth)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - ZYFoldingSepertorLineWidth)];
    return path;
}
@end
