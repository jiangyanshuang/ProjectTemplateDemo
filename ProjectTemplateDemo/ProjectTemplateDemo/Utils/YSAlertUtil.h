//
//  YSAlertUtil.h
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/29.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSAlertUtil : NSObject
/** 显示带title的ProgressHUD，2s后自动消失 */
+ (void)showHUDWithInfo:(NSString *)info;

/** 显示带指示器的ProgressHUD */
+ (void)showHUDWithIndicator;

/** 显示带指示器和title的ProgressHUD */
+ (void)showHUDWithIndicatorAndInfo:(NSString *)info;

/** 隐藏 */
+ (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
