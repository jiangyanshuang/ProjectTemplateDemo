//
//  YSConstString.h
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/28.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#ifndef YSConstString_h
#define YSConstString_h

/** RGB颜色 */
#define YSColor(r, g, b, a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
/** RGB颜色 */
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/** 通用背景色 */
#define kCommonBGColor      YSColor(246, 246, 246, 1.0)
/** 当前屏幕 */
#define kScreen            [UIScreen mainScreen].bounds
/** 当前屏幕宽度 */
#define kScreenWidth       [UIScreen mainScreen].bounds.size.width
/** 当前屏幕高度 */
#define kScreenHeight      [UIScreen mainScreen].bounds.size.height
/** 获取安全区域 */
#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})
/** 获取顶部安全区域 */
#define kSafeAreaTopHeight    ((kScreenHeight == 812.0 || kScreenHeight == 896.0) ? 44 : 20)
/** 获取底部安全区域 */
#define kSafeAreaBottomHeight  ((kScreenHeight == 812.0 || kScreenHeight == 896.0) ? 34 : 0)
/** app状态栏高度 */
#define kAppViewStatusBarH [UIApplication sharedApplication].statusBarFrame.size.height
/** 循环引用弱化self变量 */
#define WeakSelf __weak typeof(self) weakSelf = self;
/** 主WINDOW */
//Tips:应用程序的keyWindow 有时（alertView弹出时）并不是我们想要的window
//#define kWindow            [UIApplication sharedApplication].keyWindow
//Tips：代码耦合度较高
//#define kWindow            [UIApplication sharedApplication].delegate.window
//Tips：Perfect
#define kWindow            [[UIApplication sharedApplication].windows objectAtIndex:0]
/** 获取版本 */
#define kVerison           [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** 获取应用名称 */
#define kAppName           [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
/** 轻量级数据存储 */
#define kDefaults          [NSUserDefaults standardUserDefaults]
/** 用户信息 */
#define kAccount           [YSAccountTool account]
/** 是否登录 */
#define kIsLogin           [[GlobalManager globalManagerShare]isOrNoLogin]
/** 每页条数 */
#define kPageSize          10

/** 参数是当下的控制器适配iOS11 一下的TableView分割线和动画效果适配 */
#define AdjustsTableView(view) if (@available(iOS 11.0, *)) {view.estimatedSectionHeaderHeight = 0;view.estimatedSectionFooterHeight = 0;}

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhoneX|iPhoneXs|IsiPhone11Pro
#define kiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr|iPhone11
#define kiPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max|iPhone11ProMax
#define kiPhoneXS_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断刘海屏
#define kIsiPhoneXSerious ({\
BOOL isiPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
UIWindow *window = [UIApplication sharedApplication].delegate.window;\
if (window.safeAreaInsets.bottom > 0.0) {\
isiPhoneX = YES;\
}\
}\
isiPhoneX;\
})

/** 基于375px（6/6s）做适配 **/
#define kSize(a)                (a*kScreenWidth/375.0)
#define kHigth(a)               (a*((kiPhoneX==YES || kiPhoneXR ==YES || kiPhoneXS== YES || kiPhoneXS_Max== YES) ? 667.0/667.0 : kScreenHeight/667.0))

#ifdef DEBUG
#define YSLog(...) NSLog(__VA_ARGS__)
#else
#define YSLog(...)
#endif

#endif /* YSConstString_h */
