//
//  YSNetworkTool.m
//  dumbbell
//
//  Created by JYS on 17/3/8.
//  Copyright © 2017年 insaiapp. All rights reserved.
//

#import "YSNetworkTool.h"
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>
#import "AppDelegate.h"

NSString * const YTHttpUtilResponseMessage = @"msg";
NSString * const YTHttpUtilResponseCode = @"code";
NSString * const YTHttpUtilResponseData = @"data";

@implementation YSNetworkTool
/** 返回已配置过的AFHTTPSessionManager */
+ (AFHTTPSessionManager *)manager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",@"image/gif", nil];
    manager.requestSerializer.timeoutInterval = 10;
    //无条件的信任服务器上的证书
    AFSecurityPolicy *securityPolicy =  [AFSecurityPolicy defaultPolicy];
    //客户端是否信任非法证书
    securityPolicy.allowInvalidCertificates = YES;
    //是否在证书域字段中验证域名
    securityPolicy.validatesDomainName = NO;
    //允许不进行证书验证
    manager.securityPolicy = securityPolicy;
    return manager;
}

#pragma mark - POST
+ (void)post:(NSString *)url
      params:(NSDictionary *)params
    progress:(YTHttpUtilProgress)progress
     success:(YTHttpUtilSuccess)success
     failure:(YTHttpUtilFailure)failure {
    
    //请求队列管理者 单例创建形式 防止内存泄漏
    AFHTTPSessionManager *manager = [YSNetworkTool manager];
    
    [manager POST:url parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress ? progress(uploadProgress) : nil;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success ? success(task, responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure ? failure(task, error) : nil;
        
    }];
}

#pragma mark - Reachability
/** 网络状态监控 */
+ (void)startMonitorNetwork {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown://网络错误
            case AFNetworkReachabilityStatusNotReachable://没有连接网络
            {
                appDelegate.networkStatus = AppDelegateNetworkStatusDisconnect;
                if (appDelegate.networkStatusBlock) {
                    appDelegate.networkStatusBlock(AppDelegateNetworkStatusDisconnect);
                }
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi://WIFI
            case AFNetworkReachabilityStatusReachableViaWWAN://手机自带网络
            {
                appDelegate.networkStatus = AppDelegateNetworkStatusConnected;
                if (appDelegate.networkStatusBlock) {
                    appDelegate.networkStatusBlock(AppDelegateNetworkStatusConnected);
                }
                break;
            }
        }
    }];
    [reachabilityManager startMonitoring];
}
+ (void)stopMonitorNetwork {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager stopMonitoring];
}
+ (void)handleNetworkStatusWithConnected:(YTHttpUtilNetworkStatusHandler)connected
                              disconnect:(YTHttpUtilNetworkStatusHandler)disconnect {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    AppDelegateNetworkStatus networkStatus = appDelegate.networkStatus;
    switch (networkStatus) {
        case AppDelegateNetworkStatusDisconnect:
            disconnect ? disconnect() : nil;
            break;
        case AppDelegateNetworkStatusConnected:
            connected ? connected () : nil;
            break;
    }
}
+ (BOOL)connectedAndShowDisconnectInfo {
    __block BOOL isConnected;
    [[self class] handleNetworkStatusWithConnected:^{
        isConnected = YES;
    } disconnect:^{
        isConnected = NO;
        [YSAlertUtil showHUDWithInfo:@"暂无网络连接，请检查网络状态"];
    }];
    return isConnected;
}

@end
