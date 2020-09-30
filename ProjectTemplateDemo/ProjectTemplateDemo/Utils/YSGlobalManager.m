//
//  YSGlobalManager.m
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/29.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import "YSGlobalManager.h"

@implementation YSGlobalManager

+ (YSGlobalManager *)shareManager {
    static YSGlobalManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[YSGlobalManager alloc]init];
    });
    return manager;
}

- (BOOL)isOrNoLogin {
    if (kAccount) {
        //登陆过
        return YES;
    }else{
        //未登录
        return NO;
    }
}

@end
