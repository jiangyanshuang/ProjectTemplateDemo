//
//  YSBaseNavigationController.m
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/28.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import "YSBaseNavigationController.h"

@interface YSBaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation YSBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏导航返回字体
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"small_back"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"small_back"]];

}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if(self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES ;
    }
    [super pushViewController:viewController animated:YES];
}

@end
