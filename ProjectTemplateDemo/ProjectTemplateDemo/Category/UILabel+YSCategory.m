//
//  UILabel+YSCategory.m
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/29.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import "UILabel+YSCategory.h"

@implementation UILabel (YSCategory)
+ (instancetype)creatUILabelFont:(UIFont *)font
                       textColor:(UIColor *)textColor
                   textAlignment:(NSTextAlignment)textAlignment
                   numberOfLines:(NSInteger)numberOfLines {
    
    /** 创建 label */
    UILabel * label = [[UILabel alloc] init];
    
    /** 文字字号 */
    label.font = font;

    /** 文字颜色 */
    label.textColor = textColor;
    
    /** 文字 位置 */
    label.textAlignment = textAlignment;
    
    /** 文字换行 */
    label.numberOfLines = numberOfLines;
    
    return label;
}

/** UILabel的高度和宽度自适应 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
    
}

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
    
}


+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    if (label.text == nil || [label.text isEqualToString:@""]) {
        return;
    }
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

@end
