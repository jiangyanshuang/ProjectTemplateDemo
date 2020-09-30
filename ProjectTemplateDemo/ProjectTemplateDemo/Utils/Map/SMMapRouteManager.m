//
//  SMMapRouteManager.m
//  qwlg
//
//  Created by YanShuang Jiang on 2019/12/11.
//  Copyright © 2019 WuHanOnePointOne. All rights reserved.
//

#import "SMMapRouteManager.h"

#define SOURCE_APPLICATION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/**
 路径导航类型
 
 - CQRouteNaviTypeApple: 苹果地图导航
 - CQRouteNaviTypeGaode: 高德地图导航
 - CQRouteNaviTypeBaidu: 百度地图导航
 */
typedef NS_ENUM(NSUInteger, CQRouteNaviType) {
    CQRouteNaviTypeApple,
    CQRouteNaviTypeGaode,
    CQRouteNaviTypeBaidu,
};

static NSString *_defaultOriginName = @"我的位置";
static NSString *_defaultDestinationName = @"目的地";

@implementation SMMapRouteManager

#pragma mark - 设置默认展示的目的地名称
+ (NSString *)defaultOriginName {
    return _defaultOriginName;
}

+ (NSString *)defaultDestinationName {
    return _defaultDestinationName;
}

+ (void)setDefaultOriginName:(NSString *)defaultOriginName {
    _defaultOriginName = defaultOriginName;
}

+ (void)setDefaultDestinationName:(NSString *)defaultDestinationName {
    _defaultDestinationName = defaultDestinationName;
}

#pragma mark - 跳转到地图APP导航（“坐标” or “目的地名称” or “坐标+目的地名称”）

/**
 根据坐标导航
 
 @param controller 列表展示在此controller上
 @param coordinate 目的地坐标
 */
+ (void)presentRouteNaviMenuOnController:(UIViewController *)controller withCoordinate:(CLLocationCoordinate2D)coordinate {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [self p_presentRouteNaviMenuOnController:controller fromLocation:nil fromOrigin:nil toLocation:location toDestination:nil];
}

+ (void)presentRouteNaviMenuOnController:(UIViewController *)controller withDestination:(NSString *)destination {
    [self p_presentRouteNaviMenuOnController:controller fromLocation:nil fromOrigin:nil toLocation:nil toDestination:destination];
}

+ (void)presentRouteNaviMenuOnController:(UIViewController *)controller withCoordate:(CLLocationCoordinate2D)coordinate destination:(NSString * __nullable)destination {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [self p_presentRouteNaviMenuOnController:controller fromLocation:nil fromOrigin:nil toLocation:location toDestination:destination];
}

+ (void)presentRouteNaviMenuOnController:(UIViewController *)controller fromCoordate:(CLLocationCoordinate2D)fromCoordate fromOrigin:(NSString * __nullable)fromOrigin toCoordate:(CLLocationCoordinate2D)toCoordate toDestination:(NSString * __nullable)toDestination {
    CLLocation *fromLocation = [[CLLocation alloc] initWithLatitude:fromCoordate.latitude longitude:fromCoordate.longitude];
    CLLocation *toLocation = [[CLLocation alloc] initWithLatitude:toCoordate.latitude longitude:toCoordate.longitude];
    [self p_presentRouteNaviMenuOnController:controller fromLocation:fromLocation fromOrigin:fromOrigin toLocation:toLocation toDestination:toDestination];
}

#pragma mark - private method
+ (void)p_presentRouteNaviMenuOnController:(UIViewController *)controller fromLocation:(nullable CLLocation *)fromLocation fromOrigin:(NSString * __nullable)fromOrigin toLocation:(nullable CLLocation *)toLocation toDestination:(NSString * __nullable)toDestination {
    if (!toLocation && !toDestination) {
        NSAssert(nil, @"位置和地址不能同时为空");
        return;
    }
    
    // 能否打开苹果地图
    BOOL canOpenAppleMap = NO;
    // 能否打开高德地图
    BOOL canOpenGaodeMap = NO;
    // 能否打开百度地图
    BOOL canOpenBaiduMap = NO;
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com"]]) {
        canOpenAppleMap = YES;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        canOpenGaodeMap = YES;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        canOpenBaiduMap = YES;
    }
    
    // 三种地图都木有，弹窗提示，return
    if (!canOpenAppleMap && !canOpenGaodeMap && !canOpenBaiduMap) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"你手机未安装支持的地图APP" message:@"请先下载苹果地图、高德地图或百度地图" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:confirmAction];
        [controller presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    
    
    //========== 以下是正常情况下的逻辑 ==========//
    
    // 地图列表
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"导航方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
//iPad上需要设置UIAlertController这个弹出窗口的位置信息（当使用UIAlertController的UIAlertControllerStyleActionSheet时在iPad上运行会崩溃）
//.sourceView 用来指定用来显示popover的view
//.sourceRect 用来指定popover的箭头指向哪里
    if (isPad) {
        alertVC.popoverPresentationController.sourceView = controller.view;
        alertVC.popoverPresentationController.sourceRect = CGRectMake(0, kScreenHeight/2.0, kScreenWidth, kScreenHeight/2.0);
    }
    
    //========== 使用苹果地图导航 ==========//
    if (canOpenAppleMap) {
        [alertVC addAction:[self p_actionWithNaviType:CQRouteNaviTypeApple title:@"苹果地图" fromLocation:fromLocation fromOrigin:fromOrigin toLocation:toLocation toDestination:toDestination]];
    }
    
    //========== 使用高德地图导航 ==========//
    if (canOpenGaodeMap) {
        [alertVC addAction:[self p_actionWithNaviType:CQRouteNaviTypeGaode title:@"高德地图" fromLocation:fromLocation fromOrigin:fromOrigin toLocation:toLocation toDestination:toDestination]];
    }
    
    //========== 使用百度地图导航 ==========//
    if (canOpenBaiduMap) {
        [alertVC addAction:[self p_actionWithNaviType:CQRouteNaviTypeBaidu title:@"百度地图" fromLocation:fromLocation fromOrigin:fromOrigin toLocation:toLocation toDestination:toDestination]];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:cancelAction];
    
    [controller presentViewController:alertVC animated:YES completion:nil];
    
}
+ (UIAlertAction *)p_actionWithNaviType:(CQRouteNaviType)naviType title:(NSString *)title fromLocation:(nullable CLLocation *)fromLocation fromOrigin:(NSString * __nullable)fromOrigin toLocation:(nullable CLLocation *)toLocation toDestination:(NSString * __nullable)toDestination {
    /** 默认起始地名称，若未设置，默认为”我的位置“ */
    NSString *originName = fromOrigin ?: self.defaultOriginName;
    // 目的地如果为空，展示名称默认为”目的地“
    NSString *destinationName = toDestination ?: self.defaultDestinationName;
    
    __block NSString *urlString = nil;
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        switch (naviType) {
            case CQRouteNaviTypeApple: // 苹果地图
            {
                if (fromLocation && toLocation) {
                    CLLocationCoordinate2D fromLoc = CLLocationCoordinate2DMake(fromLocation.coordinate.latitude, fromLocation.coordinate.longitude);
                    CLLocationCoordinate2D toLoc = CLLocationCoordinate2DMake(toLocation.coordinate.latitude, toLocation.coordinate.longitude);
                    MKMapItem *fromItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:fromLoc addressDictionary:nil]];
                    MKMapItem *toItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:toLoc addressDictionary:nil]];
                    fromItem.name = originName;
                    toItem.name = destinationName;
                    [MKMapItem openMapsWithItems:@[fromItem, toItem]
                                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                                   MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
                }else if (toLocation) {
                    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(toLocation.coordinate.latitude, toLocation.coordinate.longitude);
                    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
                    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:loc addressDictionary:nil]];
                    toLocation.name = destinationName;
                    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                                   MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
                } else {
                    // 没坐标，仅有目的地名称
                    urlString = [NSString stringWithFormat:@"http://maps.apple.com/?daddr=%@",destinationName];
                }
            }
                break;
                
            case CQRouteNaviTypeGaode: // 高德地图
            {
                if (fromLocation && toLocation) {
                    // 有坐标时以坐标为准
                    urlString = [NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=&did=&slat=%f&slon=%f&sname=%@&dlat=%f&dlon=%f&dname=%@&dev=0&t=0",SOURCE_APPLICATION,fromLocation.coordinate.latitude, fromLocation.coordinate.longitude, originName,toLocation.coordinate.latitude, toLocation.coordinate.longitude, destinationName];
                }else if (toLocation) {
                    // 有坐标时以坐标为准
                    urlString = [NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=&did=&dlat=%f&dlon=%f&dname=%@&dev=0&t=0",SOURCE_APPLICATION,toLocation.coordinate.latitude, toLocation.coordinate.longitude, destinationName];
                } else {
                    // 没有坐标时，以终点名称为准
                    urlString = [NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sname=%@&dname=%@&dev=0&t=0&sid=BGVIS1&did=BGVIS2",SOURCE_APPLICATION,@"我的位置",destinationName];
                }
            }
                break;
                
            case CQRouteNaviTypeBaidu: // 百度地图
            {
                if (fromLocation && toLocation) {
                    // 注：高德用的gcj02坐标系
                    urlString = [NSString stringWithFormat:@"baidumap://map/direction?origin=name:%@|latlng:%f,%f&destination=name:%@|latlng:%f,%f&coord_type=gcj02&src=%@",originName,fromLocation.coordinate.latitude,fromLocation.coordinate.longitude,destinationName, toLocation.coordinate.latitude, toLocation.coordinate.longitude, @"ios.companyName.appName"];
                }else if (toLocation) {
                    // 注：高德用的gcj02坐标系
                    urlString = [NSString stringWithFormat:@"baidumap://map/direction?destination=name:%@|latlng:%f,%f&coord_type=gcj02&src=%@",destinationName, toLocation.coordinate.latitude, toLocation.coordinate.longitude, @"ios.companyName.appName"];
                } else {
                    urlString = [NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=%@", destinationName];
                }
            }
                break;
        }
        
        // 打开地图APP
        if (urlString) {
            NSURL *targetURL = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:targetURL options:@{} completionHandler:^(BOOL success) {
                    NSLog(@"scheme调用结束");
                }];
            } else {
                // Fallback on earlier versions
                [[UIApplication sharedApplication] openURL:targetURL];
            }
        }
    }];
    
    return action;
}

@end
