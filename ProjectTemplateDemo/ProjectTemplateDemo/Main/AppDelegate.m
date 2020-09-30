//
//  AppDelegate.m
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/28.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import "AppDelegate.h"
#import <SDImageCache.h>
#import "YSBaseTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //开始监听网络状态
    [YSNetworkTool startMonitorNetwork];

    YSBaseTabBarController * vc = [[YSBaseTabBarController alloc] init];
    self.window.rootViewController = vc;
    
    
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    NSLog(@"==========收到内存警告了=============");
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
