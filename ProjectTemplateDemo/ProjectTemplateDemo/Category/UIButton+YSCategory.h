//
//  UIButton+YSCategory.h
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/29.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (YSCategory)

/** 普通按钮 */
+ (instancetype)creatUIButtonBackgroundImage:(NSString *__nullable)backImageName
                         selectBackImageName:(NSString *__nullable)selectBackImageName
                                   imageName:(NSString *__nullable)imageName
                             selectImageName:(NSString *__nullable)selectImageName
                            normalTitleColor:(UIColor *__nullable)normalTitleColor
                            selectTitleColor:(UIColor *__nullable)selectTitleColor
                                 normalTitle:(NSString *__nullable)normalTitle
                                 selectTitle:(NSString *__nullable)selectTitle
                                        font:(UIFont *__nullable)font;


@end

NS_ASSUME_NONNULL_END
