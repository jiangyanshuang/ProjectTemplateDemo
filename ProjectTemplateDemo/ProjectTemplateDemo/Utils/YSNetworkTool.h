//
//  YSNetworkTool.h
//  dumbbell
//
//  Created by JYS on 17/3/8.
//  Copyright © 2017年 insaiapp. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const YTHttpUtilResponseMessage;
FOUNDATION_EXPORT NSString * const YTHttpUtilResponseCode;
FOUNDATION_EXPORT NSString * const YTHttpUtilResponseData;

/** 请求成功block typedef */
typedef void (^YTHttpUtilSuccess)(NSURLSessionDataTask * task,id responseObject);
/** 请求失败block typedef */
typedef void (^YTHttpUtilFailure)(NSURLSessionDataTask * task, NSError * error);
/** 上传或者下载的进度block typedef */
typedef void (^YTHttpUtilProgress)(NSProgress *progress);
typedef void(^YTHttpUtilNetworkStatusHandler)(void);

/** 封装AFNetWorking的网络请求工具类 */
@interface YSNetworkTool : NSObject

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
    progress:(YTHttpUtilProgress)progress
     success:(YTHttpUtilSuccess)success
     failure:(YTHttpUtilFailure)failure;

/** 开始监听网络状态 */
+ (void)startMonitorNetwork;

/** 停止网络监控 */
+ (void)stopMonitorNetwork;

/** 处理有网络连接和无网络连接 */
+ (void)handleNetworkStatusWithConnected:(YTHttpUtilNetworkStatusHandler)connected
                              disconnect:(YTHttpUtilNetworkStatusHandler)disconnect;
/** 显示无网络信息 */
+ (BOOL)connectedAndShowDisconnectInfo;

@end
