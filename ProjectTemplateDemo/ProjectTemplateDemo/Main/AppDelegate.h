//
//  AppDelegate.h
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/28.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//
//*#####################################################
//*#                                                   #
//*#                       _oo0oo_                     #
//*#                      o8888888o                    #
//*#                      88" . "88                    #
//*#                      (| ^_^ |)                    #
//*#                      0\  =  /0                    #
//*#                    ___/`---'\___                  #
//*#                  .' \\|     |# '.                 #
//*#                 / \\|||  :  |||# \                #
//*#                / _||||| -:- |||||- \              #
//*#               |   | \\\  -  #/ |   |              #
//*#               | \_|  ''\---/''  |_/ |             #
//*#               \  .-\__  '-'  ___/-. /             #
//*#             ___'. .'  /--.--\  `. .'___           #
//*#          ."" '<  `.___\_<|>_/___.' >' "".         #
//*#         | | :  `- \`.;`\ _ /`;.`/ - ` : | |       #
//*#         \  \ `_.   \_ __\ /__ _/   .-` /  /       #
//*#     =====`-.____`.___ \_____/___.-`___.-'=====    #
//*#                       `=---='                     #
//*#     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   #
//*#                                                   #
//*#               佛祖保佑         永无BUG              #
//*#                                                   #
//*#####################################################

#import <UIKit/UIKit.h>

/** 网络是否连接 */
typedef NS_ENUM(NSUInteger, AppDelegateNetworkStatus) {
    AppDelegateNetworkStatusDisconnect = 0,    //网络未连接
    AppDelegateNetworkStatusConnected          //网络已连接
};

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, assign) AppDelegateNetworkStatus networkStatus;

@property(nonatomic, assign) void(^networkStatusBlock)(AppDelegateNetworkStatus networkStatus);

@end

