//
//  UIColor+YSCategory.h
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/29.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (YSCategory)

+ (UIColor *)colorWithHex:(unsigned long)col;

+ (UIColor *)hexColorWithString:(NSString *)string;

+ (UIColor *)hexColorWithString:(NSString *)string alpha:(float) alpha;

@end

NS_ASSUME_NONNULL_END
