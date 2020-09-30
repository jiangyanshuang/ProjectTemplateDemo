//
//  YSAccount.h
//  dumbbell
//
//  Created by JYS on 17/3/5.
//  Copyright © 2017年 insaiapp. All rights reserved.
//

#import "YSBaseModel.h"

@interface YSAccount : YSBaseModel <NSCoding>
/**
 用户ID
 */
@property (nonatomic, copy)           NSString *identifier;
/**
 电话号码
 */
@property (nonatomic, copy)           NSString *phone;
/**
 昵称
 */
@property (nonatomic, copy)           NSString *nikename;
/**
 头像
 */
@property (nonatomic, copy)           NSString *avatar;
/**
 性别 1：男  2：女
 */
@property (nonatomic, copy)           NSString *sex;

@end
