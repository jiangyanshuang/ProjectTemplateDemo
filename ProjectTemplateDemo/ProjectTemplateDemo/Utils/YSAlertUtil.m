//
//  YSAlertUtil.m
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/29.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import "YSAlertUtil.h"
#import <MBProgressHUD.h>

#define keyWindow [UIApplication sharedApplication].keyWindow

@implementation YSAlertUtil

/** 显示带title的ProgressHUD，2s后自动消失 */
+ (void)showHUDWithInfo:(NSString *)info {
    [[self class] hideHUD];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];

    hud.mode = MBProgressHUDModeText;
    
    hud.removeFromSuperViewOnHide = YES;

    hud.labelFont = [UIFont systemFontOfSize:kSize(15)];

    hud.labelText = info;
        
    [hud hide:YES afterDelay:2.0];
    
}

/** 显示带指示器的ProgressHUD */
+ (void)showHUDWithIndicator {
    [[self class] hideHUD];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    
    hud.removeFromSuperViewOnHide = YES;
    
}

/** 显示带指示器和title的ProgressHUD */
+ (void)showHUDWithIndicatorAndInfo:(NSString *)info {
    [[self class] hideHUD];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    
    hud.removeFromSuperViewOnHide = YES;

    hud.labelFont = [UIFont systemFontOfSize:kSize(15)];

    hud.labelText = info;
    
}

/** 隐藏 */
+ (void)hideHUD {

    [MBProgressHUD hideAllHUDsForView:keyWindow animated:YES];
    
}

@end
