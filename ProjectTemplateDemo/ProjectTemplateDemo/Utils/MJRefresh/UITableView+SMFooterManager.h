//
//  UITableView+SMFooterManager.h
//  qwlg
//
//  Created by gemma on 2020/6/2.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SMFooterManager)
/**是否开启<数据不满一页的话就自动隐藏下面的mj_footer>功能*/
@property(nonatomic, assign) BOOL autoHideMjFooter;
@end

NS_ASSUME_NONNULL_END
