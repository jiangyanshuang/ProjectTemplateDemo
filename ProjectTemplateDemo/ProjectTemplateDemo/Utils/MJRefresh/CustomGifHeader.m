//
//  CustomGifHeader.m
//  qwlg
//
//  Created by YanShuang Jiang on 2019/12/10.
//  Copyright © 2019 WuHanOnePointOne. All rights reserved.
//

#import "CustomGifHeader.h"

@implementation CustomGifHeader

#pragma mark - 实现父类的方法
- (void)prepare {
    [super prepare];
    //GIF数据
    NSArray *refreshingImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:10];
    //普通状态
    [self setImages:refreshingImages forState:MJRefreshStateIdle];
    //即将刷新状态
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    //正在刷新状态
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}
- (void)placeSubviews {
    [super placeSubviews];
    //隐藏状态显示文字
    self.stateLabel.hidden = YES;
    //隐藏更新时间文字
    self.lastUpdatedTimeLabel.hidden = YES;
}

#pragma mark - 获取资源图片
- (NSArray *)getRefreshingImageArrayWithStartIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSMutableArray * imageArray = [NSMutableArray array];
    for (NSUInteger i = startIndex; i <= endIndex; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"Refresh_%lu",(unsigned long)i]];
        if (image) {
            [imageArray addObject:image];
        }
    }
    return imageArray;
}

@end
