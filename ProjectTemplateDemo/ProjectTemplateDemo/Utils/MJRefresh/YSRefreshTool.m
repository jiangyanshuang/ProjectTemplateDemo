//
//  YSRefreshTool.m
//  dumbbell
//
//  Created by JYS on 17/3/3.
//  Copyright © 2017年 insaiapp. All rights reserved.
//

#import "YSRefreshTool.h"
#import "CustomGifHeader.h"
#import "CustomAutoGifFooter.h"
@implementation YSRefreshTool
+ (void)endRefreshingWithView:(UIScrollView *)view {
    if (view.mj_header.isRefreshing) {
        [view.mj_header endRefreshing];
    }
    if (view.mj_footer.isRefreshing) {
        [view.mj_footer endRefreshing];
    }
    [view.mj_footer resetNoMoreData];
}

+ (void)noticeNoMoreWithView:(UIScrollView *)view {
    [view.mj_footer endRefreshingWithNoMoreData];
}

+ (void)beginRefreshingWithView:(UIScrollView *)view {
    if (!view.mj_header.isRefreshing) {
        [view.mj_header beginRefreshing];
    }
}

+ (void)resetNoMoreDataWithView:(UIScrollView *)view {
    [view.mj_footer resetNoMoreData];
}

+ (void)addRefreshHeaderWithView:(UIScrollView *)scrollView refreshingBlock:(void(^)(void))block {
    /** 下拉刷新动画 */
    CustomGifHeader *header = [CustomGifHeader headerWithRefreshingBlock:block];
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    scrollView.mj_header = header;
}

+ (void)addRefreshFooterWithView:(UIScrollView *)scrollView refreshingBlock:(void(^)(void))block {
    
    CustomAutoGifFooter*footer=[CustomAutoGifFooter footerWithRefreshingBlock:block];
    footer.stateLabel.hidden=YES;
//    footer.stateLabel.textColor = [UIColor lightGrayColor];
//    //设置闲置状态下不显示“点击或上拉加载更多”
//    [footer setTitle:@"敬请期待更多～" forState:MJRefreshStateNoMoreData];
//    [footer setTitle:@"我是有底线的>_<" forState:MJRefreshStateIdle];
    scrollView.mj_footer = footer;

   
}

@end
