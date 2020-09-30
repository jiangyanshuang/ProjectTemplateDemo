//
//  YSBaseModel.h
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/28.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSBaseModel : NSObject<NSCoding>
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
