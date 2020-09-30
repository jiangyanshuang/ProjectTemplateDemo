//
//  UILabel+YSCategory.h
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/29.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (YSCategory)
+ (instancetype)creatUILabelFont:(UIFont *)font
                       textColor:(UIColor *)textColor
                   textAlignment:(NSTextAlignment)textAlignment
                   numberOfLines:(NSInteger)numberOfLines;

/** UILabel的高度和宽度自适应 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

/** UILabel的高度和宽度自适应 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end

NS_ASSUME_NONNULL_END
