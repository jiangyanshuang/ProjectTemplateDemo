//
//  UIButton+YSCategory.m
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/29.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import "UIButton+YSCategory.h"

@implementation UIButton (YSCategory)

/** 普通按钮 */
+ (instancetype)creatUIButtonBackgroundImage:(NSString *__nullable)backImageName
                         selectBackImageName:(NSString *__nullable)selectBackImageName
                                   imageName:(NSString *__nullable)imageName
                             selectImageName:(NSString *__nullable)selectImageName
                            normalTitleColor:(UIColor *__nullable)normalTitleColor
                            selectTitleColor:(UIColor *__nullable)selectTitleColor
                                 normalTitle:(NSString *__nullable)normalTitle
                                 selectTitle:(NSString *__nullable)selectTitle
                                        font:(UIFont *__nullable)font {
    
    /** 创建普通按钮 */
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectBackImageName] forState:UIControlStateSelected];
   
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
    
    [button setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [button setTitleColor:selectTitleColor forState:UIControlStateSelected];
    
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setTitle:selectTitle forState:UIControlStateSelected];

    [button.titleLabel setFont:font];
    
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    /** 去掉按钮高亮效果 */
    button.adjustsImageWhenHighlighted = NO;
    
    return button;
}

@end
