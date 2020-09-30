//
//  CustomAutoGifFooter.m
//  qwlg
//
//  Created by YanShuang Jiang on 2019/12/10.
//  Copyright © 2019 WuHanOnePointOne. All rights reserved.
//

#import "CustomAutoGifFooter.h"

@implementation CustomAutoGifFooter

#pragma mark - 实现父类的方法
- (void)prepare {
    [super prepare];
    //GIF数据
//    NSArray * idleImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:9];
    NSArray * refreshingImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:9];
    //普通状态
//    [self setImages:idleImages forState:MJRefreshStateIdle];
    //即将刷新状态
//    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    //正在刷新状态
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}
- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.gifView.constraints.count) return;
    
    self.gifView.frame = self.bounds;
    if (self.isRefreshingTitleHidden) {
        self.gifView.contentMode = UIViewContentModeCenter;
    } else {
        self.gifView.contentMode = UIViewContentModeCenter;
        self.gifView.mj_w=self.mj_w;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
     NSArray * refreshingImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:8];
    // 根据状态做事情
    if (state == MJRefreshStateRefreshing) {
        NSArray *images = refreshingImages;
        if (images.count == 0) return;
        [self.gifView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = 0.5;
            [self.gifView startAnimating];
        }
    } else if (state == MJRefreshStateNoMoreData) {
        self.gifView.hidden = NO;
        [self.gifView stopAnimating];
        self.gifView.image=[UIImage imageNamed:@"noMoreImage"];
    } else if (state == MJRefreshStateIdle) {
           self.gifView.hidden = YES;
           [self.gifView stopAnimating];
       }
}

#pragma mark - 获取资源图片
- (NSArray *)getRefreshingImageArrayWithStartIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSMutableArray * imageArray = [NSMutableArray array];
    for (NSUInteger i = startIndex; i <= endIndex; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"Bottom-load__000%zd",i]];
        if (image) {
            [imageArray addObject:image];
        }
    }
    return imageArray;
}

@end
