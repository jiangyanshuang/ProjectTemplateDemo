//
//  YSGlobalManager.h
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/29.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSGlobalManager : NSObject
+ (YSGlobalManager *)shareManager;
- (BOOL)isOrNoLogin;

@end

NS_ASSUME_NONNULL_END
