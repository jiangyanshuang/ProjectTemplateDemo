//
//  YSBaseTabBarController.m
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/28.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import "YSBaseTabBarController.h"
#import "YSBaseNavigationController.h"
#import "YSOneC.h"
#import "YSTwoC.h"
#import "YSThreeC.h"

@interface YSBaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation YSBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addItems];
    [self changeItemTextColourAndFont];
    self.delegate = self;

    //设置TabBar的背景色
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    //取消tabBar的透明效果
    [UITabBar appearance].translucent = NO;
    //设置tabBar顶部线条
    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
    [self.tabBar setShadowImage:[[UIImage alloc] init]];
    
}
- (void)addItems {
    YSOneC *oneVc = [[YSOneC alloc]init];
    YSTwoC *twoVc = [[YSTwoC alloc]init];
    YSThreeC *threeVc = [[YSThreeC alloc]init];
    
    NSArray *arrVC;
    NSArray *titleArr;
    NSArray *picArr;
    NSArray *picSelectArr;
    
    arrVC = @[oneVc,twoVc,threeVc];
    titleArr = @[@"oneVc",@"twoVc",@"threeVc"];
    picArr = @[@"normal_shengmall",@"normal_shandian",@"normal_fujin"];
    picSelectArr = @[@"select_shengmall",@"select_shandian",@"select_fujin"];
    
    for (int i = 0; i < arrVC.count; i++) {
        [self addChildViewController:arrVC[i] title:titleArr[i] image:picArr[i] selectedImage:picSelectArr[i]];
    }
}
#pragma mark --添加子控制器
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    YSBaseNavigationController *baseNav = [[YSBaseNavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:baseNav];
}
#pragma mark --调整item的文字颜色和字体大小
-(void)changeItemTextColourAndFont {
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:11.0]} forState:UIControlStateNormal];

    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:11.0]} forState:UIControlStateSelected];
}
#pragma mark - UITabBarControllerDelegate
//禁止tab多次点击
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UIViewController *tbselect=tabBarController.selectedViewController;
    if([tbselect isEqual:viewController]){
        return NO;
    }
    return YES;
}

@end
