//
//  Tools.h
//  Dumbbell
//
//  Created by JYS on 16/1/19.
//  Copyright © 2016年 JYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSTools : NSObject
#pragma mark 验证电话号码格式的对错
+(BOOL)isRightPhoneNumberFormat:(NSString*)phone;
+(BOOL)isMobileGuoJi:(NSString *)mobileNumbel;
#pragma mark 倒计时
+(dispatch_source_t)DaojiShi:(UIButton*)sender block:(void(^)(void))block;
#pragma mark 打电话
+(void)DaDianHua:(NSString *)phone;
#pragma mark 登录回到弹出页
+ (void)toLoginWithShowVC:(UIViewController *)vc;
#pragma mark 功能暂未开通提示框
#pragma mark 判断时间是几天前几月前几年前
+ (NSString *)jitianqian:(NSString *)str;
#pragma mark 弹簧效果
+ (void)tanhuangxiaoguoWithBtn:(UIButton *)btn;
#pragma mark 判断两个日期是不是同一天
+ (BOOL)isCurrentDay:(NSDate *)aDate;
#pragma mark 比较两个日期相差几天
+ (NSInteger)getDifferenceByDate:(NSDate *)date;
#pragma mark 比较两个日期的先后
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
#pragma mark 判断对象是否为空
+ (BOOL)dx_isNullOrNilWithObject:(id)object;
#pragma mark 解析字符串
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)stringToJSON:(NSString *)jsonStr;
#pragma mark 产生随机字符串
+ (NSString *)getRandomStr;
#pragma mark 是否为纯数字
+ (BOOL)isNum:(NSString *)checkedNumString;
#pragma mark - 传入秒得到 xx:xx:xx
+ (NSString *)getMMSSFromSS:(NSString *)totalTime;
#pragma mark - 获取当前时间的十四位时间戳
+ (NSString *)getFourteenTimestr;
#pragma mark - 大端与小端互转
+ (NSData *)p_dataTransfromBigOrSmall:(NSData *)data;
#pragma mark - data转十六进制字符串
+ (NSString*)p_dataChangeToString:(NSData*)data;
#pragma mark - 十六进制字符串转data
+ (NSMutableData*)p_HexStringToData:(NSString*)str;
#pragma mark - 获取设备识别码deviceNo
+ (NSString*)getDeviceNo;
#pragma mark - 计算字符串长度
+ (CGSize)sizeWithText:(NSString *)text Font:(UIFont *)font maxWidth:(CGFloat)maxWidth;
#pragma mark - 设置滑动视图不自动调整内容偏移量
+ (void)setupDontAutoAdjustContentInsets:(UIScrollView *)scrollView forController:(UIViewController *)vc isAuto:(BOOL)isAuto;
#pragma mark - 设置富文本
+ (NSMutableAttributedString*)addTextColor:(NSString*)str WithKeyword:(NSString*)keyword Font:(UIFont *)font Color:(UIColor*)color;
#pragma mark - 字符串类型转换
+ (NSString*)getNumStrby:(NSString *)str;
#pragma mark - 根据月份获取该月第一天和最后一天
+(NSMutableDictionary *)getMonthBeginAndEndWith:(NSString *)dateStr;
#pragma mark - 根据数字得到周
+(NSString*)getweekNum:(NSString*)source;
#pragma mark - 时间格式转换
+(NSString*)gettimeStr:(NSString*)time oldformate:(NSString*)oldformate newformate:(NSString*)newformate;
#pragma mark - 时间戳变为格式时间
+ (NSString *)convertStrToTime:(NSString *)timeStr;
#pragma mark - View 生成 UIImage
+ (UIImage *)getImageFromView:(UIView *)view;
#pragma mark - 判断是否有 UIImage
+ (BOOL)isHasImage:(UIImage *)image;
#pragma mark - 根据url获取网络图片
+ (UIImage *) getImageFromURL:(NSString *)fileURL;
#pragma mark - 压缩图片
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
#pragma mark - 输入框过滤表情符号的两种方法
+ (BOOL)stringContainsEmoji:(NSString *)string;
#pragma mark - 判断是不是九宫格
-(BOOL)isNineKeyBoard:(NSString *)string;
#pragma mark - 调用这个方法前，必须先注册对应通知 监听键盘frame， 记得移除
/** 系统的通知名 都是固定的 */
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
/** 移除 */
//[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
+ (void)jiaNakeyboardWillChangeFrameWithBottonView:(UIView *)bottonV  Notification:(NSNotification *)notification;
#pragma mark - Lab首行缩进
+ (NSAttributedString *)setLabelIndent:(CGFloat)indent size:(float)size text:(NSString *)text font:(UIFont *)font;
#pragma mark - 价格小数位富文本特定字符改变
+ (NSMutableAttributedString *)creatNSMutableAttributedStringWithString:(NSString *)string TextColor:(UIColor *)textColor TextFont:(CGFloat)textFont IsBold:(BOOL)isBold;
#pragma mark - 控件设置单个或多个圆角
+ (void)viewBeizerRect:(CGRect)rect view:(UIView *)view corner:(UIRectCorner)corner cornerRadii:(CGSize)radii;
#pragma mark - 请求网络时间戳
+ (void)getInternetDateWithSuccess:(void(^)(NSTimeInterval timeInterval))success Failure:(void(^)(NSError *error))failure;
#pragma mark - 返回重复字符的location
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText;
#pragma mark - 字体加粗 + 行间距
+ (NSMutableAttributedString *)getKeywordBold:(NSString *)keyword CompleteStr:(NSString *)completeStr FontSize:(CGFloat)fontSizes LineSpacing:(CGFloat)lineSpacing;
+(NSInteger)getNowTimeTimestamp;
#pragma mark - 位移动画效果
+(void)addToShoppingCartWithGoodsImage:(UIImage *)goodsImage startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint completion:(void (^)(BOOL))completion;
#pragma mark - 通过文字内容自适应宽度
+ (CGSize)getButtonWidthWith:(UILabel *)lab Str:(NSString *)str;
#pragma mark - 记录选中商品
+(void)archiveCartId:(NSString *)cartId;
#pragma mark - 判断用户是否允许接收通知
+ (BOOL)isUserNotificationEnable;
#pragma mark - 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改  iOS版本 >=8.0 处理逻辑
+ (void)goToAppSystemSetting;
#pragma mark - 将传入的View生成图片
+ (UIImage *)makeImageWithView:(UIView *)view;

@end
