//
//  Tools.m
//  Dumbbell
//
//  Created by JYS on 16/1/19.
//  Copyright © 2016年 JYS. All rights reserved.
//

#import "YSTools.h"
#import "YSLoginC.h"
#import "YSBaseNavigationController.h"
#import "NSString+MD5.h"

@implementation YSTools
#pragma mark -
#pragma mark 倒计时
+(dispatch_source_t)DaojiShi:(UIButton*)sender block:(void(^)(void))block {
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [ sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
                if (block) {
                    block();
                }
            });
        }else{
            int seconds = timeout ;
            NSString *strTime;
            if(seconds == 60) {
                strTime = [NSString stringWithFormat:@"%.2d", seconds];
            } else {
                //int minutes = timeout / 60;
                seconds = timeout % 60;
                strTime = [NSString stringWithFormat:@"%.2d", seconds];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [sender setTitle:[NSString stringWithFormat:@"%@S",strTime] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    return _timer;
}
#pragma mark -
#pragma mark 打电话
+(void)DaDianHua:(NSString *)phone {
    NSString *callPhone = [NSString stringWithFormat:@"tel:%@",phone];
    
    /// 解决iOS10及其以上系统弹出拨号框延迟的问题
    /// 方案一
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        /// 10及其以上系统
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
        }
    } else {
        /// 10以下系统
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}
#pragma mark -
#pragma mark 验证电话号码格式的对错
+(BOOL)isRightPhoneNumberFormat:(NSString*)phone {
    //验证手机号是否是以1开头的11位数字
    NSString * MOBILE = @"^1[0-9]{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:phone] == YES) {
        return YES;
    } else {
        return NO;
    }
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,177
     12         */
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|7[7-9]|4[7]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //    NSString * G = @"^18[0-9]\\d{7,8}$";
    
    /*
     NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
     NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
     NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
     NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
     NSPredicate *regextestg  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", G];
     
     if (([regextestmobile evaluateWithObject:phone] == YES)
     || ([regextestcm evaluateWithObject:phone] == YES)
     || ([regextestct evaluateWithObject:phone] == YES)
     || ([regextestcu evaluateWithObject:phone] == YES)
     || ([regextestg evaluateWithObject:phone]) == YES) {
     return YES;
     } else {
     return NO;
     }
     */
}
//YES通过  NO不通过
+ (BOOL)isMobileGuoJi:(NSString *)mobileNumbel{
    
    NSString *aaa = @"^\\s*\\+?\\s*(\\(\\s*\\d+\\s*\\)|\\d+)(\\s*-?\\s*(\\(\\s*\\d+\\s*\\)|\\s*\\d+\\s*))*\\s*$";
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", aaa];
    if (([regextestct evaluateWithObject:mobileNumbel]
         )) {
        return YES;
    }
    return NO;
}
#pragma mark -
#pragma mark 比较时间先后
+(NSInteger)compareDate:(NSString*)date01 withDate:(NSString*)date02 {
    NSInteger ci = 0;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dt1 = [df dateFromString:date01];
    NSDate *dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {        //date02比date01大
        case NSOrderedAscending:
            ci=1;
            break;
            //date02比date01小
        case NSOrderedDescending:
            ci=0;
            break;
            //date02=date01
        case NSOrderedSame:
            ci=0;
            break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1);
            break;
    }
    return ci;
}
#pragma mark 登录提示框
+ (void)toLoginWithShowVC:(UIViewController *)vc {
    YSLoginC *loginvc = [[YSLoginC alloc]init];
    YSBaseNavigationController *nav = [[YSBaseNavigationController alloc]initWithRootViewController:loginvc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc presentViewController:nav animated:YES completion:nil];
}

#pragma mark 功能暂未开通提示框
#pragma mark 判断时间是几天前几月前几年前
+ (NSString *)jitianqian:(NSString *)str {
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    //timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚测评过"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"测于%d分钟前",(int)temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"测于%d小时前",(int)temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"测于%d天前",(int)temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"测于%d月前",(int)temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"测于%d年前",(int)temp];
    }
    return  result;
}
#pragma mark 弹簧效果
+ (void)tanhuangxiaoguoWithBtn:(UIButton *)btn {
    NSArray * scale = [self  btnAnimationValues:@2 toValue:@1 usingSpringWithDamping:5 initialSpringVelocity:30 duration:1];
    if (scale != nil) {
        CAKeyframeAnimation * keya = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        keya.duration = 1.f;
        NSMutableArray * muarray = [[NSMutableArray alloc] initWithCapacity:scale.count];
        for (int i=0; i<scale.count; i++)
        {
            float s = [scale[i] floatValue];
            //NSValue * value =  [NSValue valueWithCGAffineTransform:CGAffineTransformMakeScale(s, s)];
            NSValue * value =  [NSValue valueWithCATransform3D:CATransform3DMakeScale(s, s, s)];
            [muarray addObject:value];
        }
        keya.values = muarray;
        [btn.layer addAnimation:keya forKey:nil];
    }
}
+ (NSMutableArray *) btnAnimationValues:(id)fromValue toValue:(id)toValue usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity duration:(CGFloat)duration {
    static NSMutableArray *values = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSInteger numOfPoints  = duration * 60;
        values = [NSMutableArray arrayWithCapacity:numOfPoints];
        for (NSInteger i = 0; i < numOfPoints; i++) {
            [values addObject:@(0.0)];
        }
        CGFloat d_value = [toValue floatValue] - [fromValue floatValue];
        for (NSInteger point = 0; point <numOfPoints;point++)
        {
            CGFloat x = (CGFloat)point / (CGFloat)numOfPoints;
            
            CGFloat value = [toValue floatValue] - d_value * (pow(M_E, -damping * x) * cos(velocity * x)); //1 y = 1-e^{-5x} * cos(30x)
            values[point] = @(value);
        }
    });
    return values;
}
#pragma mark 判断两个日期是不是同一天
//判断两个日期是不是同一天
+ (BOOL)isCurrentDay:(NSDate *)aDate {
    if (aDate==nil) return NO;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:aDate];
    NSDate *otherDate = [cal dateFromComponents:components];
    if([today isEqualToDate:otherDate]){
        return YES;
    }
    return NO;
}
//比较两个日期相差几天
+ (NSInteger)getDifferenceByDate:(NSDate *)date {
    //获得当前时间
    NSDate *now = [NSDate date];
    /*
     //实例化一个NSDateFormatter对象
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     //设定时间格式
     [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     NSDate *oldDate = [dateFormatter dateFromString:date];
     */
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date  toDate:now  options:0];
    return [comps day];
}
//比较两个日期的先后
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    //NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    //([currentDate compare:date8]==NSOrderedDescending [currentDate compare:date23]==NSOrderedAscending)(8:00-23:00)
    if (result == NSOrderedDescending) {//左边的操作对象大于右边的对象。
        //NSLog(@"Date1  is in the future");前边日期超过了后边日期
        return 1;
    }
    else if (result == NSOrderedAscending){//左边的操作对象小于右边的对象。
        //NSLog(@"Date1 is in the past");前边日期未超过后边日期
        return -1;
    }
    //NSLog(@"Both dates are the same");前边日期与后边日期相同
    return 0;
}
#pragma mark 判断对象是否为空
+ (BOOL)dx_isNullOrNilWithObject:(id)object {
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}
#pragma mark 解析字符串
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
+ (NSArray *)stringToJSON:(NSString *)jsonStr {
    if (jsonStr) {id tmp = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];if (tmp) {if ([tmp isKindOfClass:[NSArray class]]) {return tmp;} else if([tmp isKindOfClass:[NSString class]] || [tmp isKindOfClass:[NSDictionary class]]) {return [NSArray arrayWithObject:tmp];} else {return nil;}} else {return nil;}} else {return nil;}
}

#pragma mark 产生随机字符串
+ (NSString *)getRandomStr {
    static int kNumber = 16;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    [resultStr appendString:[NSString stringWithFormat:@"%.f",[[NSDate date] timeIntervalSince1970]*1000*1000]];
    resultStr = [resultStr MD5];
    return resultStr;
}
#pragma mark 是否为纯数字
+ (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}
#pragma mark - 传入秒得到 xx:xx:xx
+ (NSString *)getMMSSFromSS:(NSString *)totalTime {
    NSInteger seconds = [totalTime integerValue];
    //format of hour
    //    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    //NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
    return format_time;
}
#pragma mark - 获取当前时间的十四位时间戳
+ (NSString *)getFourteenTimestr {
    NSDate *date = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMddHHmmss";
    NSString *timeStr = [fmt stringFromDate:date];
    return timeStr;
}
#pragma mark - 大端与小端互转
+ (NSData *)p_dataTransfromBigOrSmall:(NSData *)data {
    NSString *tmpStr = [self p_dataChangeToString:data];
    NSMutableArray *tmpArra = [NSMutableArray array];
    for (int i = 0 ;i<data.length*2 ;i+=2)
    {
        NSString *str = [tmpStr substringWithRange:NSMakeRange(i, 2)];
        [tmpArra addObject:str];
    }
    NSArray *lastArray = [[tmpArra reverseObjectEnumerator] allObjects];
    NSMutableString *lastStr = [NSMutableString string];
    for (NSString *str in lastArray)
    {
        [lastStr appendString:str];
    }
    NSData *lastData = [self p_HexStringToData:lastStr];
    return lastData;
}
#pragma mark - data转十六进制字符串
+ (NSString*)p_dataChangeToString:(NSData*)data {
    NSString * string = [NSString stringWithFormat:@"%@",data];
    string = [string stringByReplacingOccurrencesOfString:@"<" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@">" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}
#pragma mark - 十六进制字符串转data
+ (NSMutableData*)p_HexStringToData:(NSString*)str {
    NSString *command = str;
    command = [command stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableData *commandToSend= [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [command length]/2; i++) {
        byte_chars[0] = [command characterAtIndex:i*2];
        byte_chars[1] = [command characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [commandToSend appendBytes:&whole_byte length:1];
    }
    return commandToSend;
}
#pragma mark - 获取设备识别码deviceNo
+ (NSString*)getDeviceNo {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString *deviceNo = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return deviceNo;
}
#pragma mark - 计算字符串长度
+ (CGSize)sizeWithText:(NSString *)text Font:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    // 获取文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    // 文本最大宽度
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    // NSStringDrawingUsesLineFragmentOrigin -> 从头开始
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
#pragma mark - 设置滑动视图不自动调整内容偏移量
+ (void)setupDontAutoAdjustContentInsets:(UIScrollView *)scrollView forController:(UIViewController *)vc isAuto:(BOOL)isAuto {
    if (@available(iOS 11.0, *)) {
        if (isAuto) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        }else{
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }else {
        if (vc) vc.automaticallyAdjustsScrollViewInsets = isAuto;
    }
}

#pragma mark - 字符串类型转换
+ (NSString*)getNumStrby:(NSString *)str {
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", [str doubleValue]];
    NSDecimalNumber * decNumber   = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}


#pragma mark - 设置富文本
+ (NSMutableAttributedString*)addTextColor:(NSString*)str WithKeyword:(NSString*)keyword Font:(UIFont *)font Color:(UIColor*)color {
    if (str.length>0) {
        NSRange range1=[str rangeOfString:keyword];
        if (range1.location == NSNotFound) {
            return nil;
        }
        NSMutableAttributedString * aAttributedString1 = [[NSMutableAttributedString alloc] initWithString:str];
        [aAttributedString1 addAttribute:NSFontAttributeName value:font range:range1];
        [aAttributedString1 addAttribute:NSForegroundColorAttributeName value:color range:range1];
        return aAttributedString1;
    }
    return nil;
}
#pragma mark - 根据月份获取该月第一天和最后一天
+(NSMutableDictionary *)getMonthBeginAndEndWith:(NSString *)dateStr{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return dic;
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    [dic setObject:beginString forKey:@"begin"];
    [dic setObject:endString forKey:@"end"];
    return dic;
}
#pragma mark - 根据数字得到周
+(NSString*)getweekNum:(NSString*)source{
    NSString*weekdayIndex;
    if ([source isEqualToString:@"1"]) {
        weekdayIndex = @"周一";
    }else if ([source isEqualToString:@"2"]){
        weekdayIndex = @"周二";
    }else if ([source isEqualToString:@"3"]){
        weekdayIndex = @"周三";
    }else if ([source isEqualToString:@"4"]){
        weekdayIndex = @"周四";
    }else if ([source isEqualToString:@"5"]){
        weekdayIndex =@"周五";
    }else if ([source isEqualToString:@"6"]){
        weekdayIndex = @"周六";
    }else if ([source isEqualToString:@"7"]){
        weekdayIndex = @"周日";
    }else{
        weekdayIndex = @"";
    }
    return weekdayIndex;
}
#pragma mark - 时间格式转换
+(NSString *)gettimeStr:(NSString *)time oldformate:(NSString *)oldformate newformate:(NSString *)newformate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //24小时制：yyyy-MM-dd HH:mm:ss  12小时制：yyyy-MM-dd hh:mm:ss
    dateFormatter.dateFormat = oldformate;
    NSDate *date = [dateFormatter dateFromString:time];
    
    NSDateFormatter *NdateFormatter = [[NSDateFormatter alloc] init];
    NdateFormatter.dateFormat = newformate;
    NSString *dateString = [NdateFormatter stringFromDate:date];
    return dateString;
}
#pragma mark - 时间戳变为格式时间
+ (NSString *)convertStrToTime:(NSString *)timeStr {
    //    long long time=[timeStr longLongValue];
    //    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    long long time=[timeStr longLongValue] / 1000;
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    
    NSString*timeString=[formatter stringFromDate:date];
    
    return timeString;
}

#pragma mark - View 生成 UIImage
+ (UIImage *)getImageFromView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);//原图
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


#pragma mark - 判断是否有 UIImage
+ (BOOL)isHasImage:(UIImage *)image {
    
    CGImageRef cgref = [image CGImage];
    CIImage * cim = [image CIImage];
    
    if (cim == nil && cgref == NULL)
    {
        
        NSLog(@"imageView has no image");
        return NO;
    } else {
        NSLog(@"imageView has a image");
        return YES;
    }
    
    
}

#pragma mark -根据url获取网络图片
+ (UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
}
#pragma mark -压缩图片
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength
{
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}


/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
#pragma mark - 判断是不是九宫格
-(BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}



#pragma mark - 输入框过滤表情符号的两种方法
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    NSUInteger len = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if (len < 3) { // 大于2个字符需要验证Emoji(有些Emoji仅三个字符)
        return NO;
    }
    
    // 仅考虑字节长度为3的字符,大于此范围的全部做Emoji处理
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    Byte *bts = (Byte *)[data bytes];
    Byte bt;
    short v;
    for (NSUInteger i = 0; i < len; i++) {
        bt = bts[i];
        
        if ((bt | 0x7F) == 0x7F) { // 0xxxxxxx ASIIC编码
            continue;
        }
        if ((bt | 0x1F) == 0xDF) { // 110xxxxx 两个字节的字符
            i += 1;
            continue;
        }
        if ((bt | 0x0F) == 0xEF) { // 1110xxxx 三个字节的字符(重点过滤项目)
            // 计算Unicode下标
            v = bt & 0x0F;
            v = v << 6;
            v |= bts[i + 1] & 0x3F;
            v = v << 6;
            v |= bts[i + 2] & 0x3F;
            
            // NSLog(@"%02X%02X", (Byte)(v >> 8), (Byte)(v & 0xFF));
            
            if ([self emojiInSoftBankUnicode:v] || [self emojiInUnicode:v]) {
                return YES;
            }
            
            i += 2;
            continue;
        }
        if ((bt | 0x3F) == 0xBF) { // 10xxxxxx 10开头,为数据字节,直接过滤
            continue;
        }
        
        return YES; // 不是以上情况的字符全部超过三个字节,做Emoji处理
    }
    return NO;
}

+ (BOOL)emojiInSoftBankUnicode:(short)code
{
    return ((code >> 8) >= 0xE0 && (code >> 8) <= 0xE5 && (Byte)(code & 0xFF) < 0x60);
}
+ (BOOL)emojiInUnicode:(short)code
{
    if (code == 0x0023
        || code == 0x002A
        || (code >= 0x0030 && code <= 0x0039)
        || code == 0x00A9
        || code == 0x00AE
        || code == 0x203C
        || code == 0x2049
        || code == 0x2122
        || code == 0x2139
        || (code >= 0x2194 && code <= 0x2199)
        || code == 0x21A9 || code == 0x21AA
        || code == 0x231A || code == 0x231B
        || code == 0x2328
        || code == 0x23CF
        || (code >= 0x23E9 && code <= 0x23F3)
        || (code >= 0x23F8 && code <= 0x23FA)
        || code == 0x24C2
        || code == 0x25AA || code == 0x25AB
        || code == 0x25B6
        || code == 0x25C0
        || (code >= 0x25FB && code <= 0x25FE)
        || (code >= 0x2600 && code <= 0x2604)
        || code == 0x260E
        || code == 0x2611
        || code == 0x2614 || code == 0x2615
        || code == 0x2618
        || code == 0x261D
        || code == 0x2620
        || code == 0x2622 || code == 0x2623
        || code == 0x2626
        || code == 0x262A
        || code == 0x262E || code == 0x262F
        || (code >= 0x2638 && code <= 0x263A)
        || (code >= 0x2648 && code <= 0x2653)
        || code == 0x2660
        || code == 0x2663
        || code == 0x2665 || code == 0x2666
        || code == 0x2668
        || code == 0x267B
        || code == 0x267F
        || (code >= 0x2692 && code <= 0x2694)
        || code == 0x2696 || code == 0x2697
        || code == 0x2699
        || code == 0x269B || code == 0x269C
        || code == 0x26A0 || code == 0x26A1
        || code == 0x26AA || code == 0x26AB
        || code == 0x26B0 || code == 0x26B1
        || code == 0x26BD || code == 0x26BE
        || code == 0x26C4 || code == 0x26C5
        || code == 0x26C8
        || code == 0x26CE
        || code == 0x26CF
        || code == 0x26D1
        || code == 0x26D3 || code == 0x26D4
        || code == 0x26E9 || code == 0x26EA
        || (code >= 0x26F0 && code <= 0x26F5)
        || (code >= 0x26F7 && code <= 0x26FA)
        || code == 0x26FD
        || code == 0x2702
        || code == 0x2705
        || (code >= 0x2708 && code <= 0x270D)
        || code == 0x270F
        || code == 0x2712
        || code == 0x2714
        || code == 0x2716
        || code == 0x271D
        || code == 0x2721
        || code == 0x2728
        || code == 0x2733 || code == 0x2734
        || code == 0x2744
        || code == 0x2747
        || code == 0x274C
        || code == 0x274E
        || (code >= 0x2753 && code <= 0x2755)
        || code == 0x2757
        || code == 0x2763 || code == 0x2764
        || (code >= 0x2795 && code <= 0x2797)
        || code == 0x27A1
        || code == 0x27B0
        || code == 0x27BF
        || code == 0x2934 || code == 0x2935
        || (code >= 0x2B05 && code <= 0x2B07)
        || code == 0x2B1B || code == 0x2B1C
        || code == 0x2B50
        || code == 0x2B55
        || code == 0x3030
        || code == 0x303D
        || code == 0x3297
        || code == 0x3299
        // 第二段
        || code == 0x23F0) {
        return YES;
    }
    return NO;
}

#pragma mark - #pragma mark - 调用这个方法前，必须先注册对应通知 监听键盘frame， 记得移除
/** 系统的通知名 都是固定的 */
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
/** 移除 */
//[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
+ (void)jiaNakeyboardWillChangeFrameWithBottonView:(UIView *)bottonV Notification:(NSNotification *)notification {
    // 键盘的frame
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey]  CGRectValue];
    // 键盘变化的动画时间
    CGFloat keyboardAnimationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 距离坐标点的目标y值
    CGFloat keyboardY = CGRectGetMinY(keyboardRect);
    
    [UIView animateWithDuration:keyboardAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        
        // 修改 控制器的View 的y即可
        CGRect viewFrame = bottonV.frame;
        CGFloat endY = keyboardY - viewFrame.size.height;
        if (keyboardY == kScreenHeight) {
            //键盘目标y值是屏幕的高 说明是收起设置操作view的y值 为初始y值
            NSLog(@"收起键盘");
            
            // 修改给控制器的View
            viewFrame.origin.y = endY - kSafeAreaBottomHeight - kSafeAreaTopHeight;
            
        } else {
            //弹出键盘 操作view的之前的y值 减去键盘的高度，就是要达到的y值，此处可以有多种计算方式
            NSLog(@"弹出键盘");
            
            // 修改给控制器的View
            viewFrame.origin.y = endY - kSafeAreaTopHeight;
            
        }
        
        bottonV.frame = viewFrame;
    } completion:^(BOOL finished) {
        
    }];
    
    
}
#pragma mark - Lab首行缩进
+ (NSAttributedString *)setLabelIndent:(CGFloat)indent size:(float)size text:(NSString *)text font:(UIFont *)font {
    if ([YSTools dx_isNullOrNilWithObject:text]) {
        text = @"该商品暂无标题";
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.firstLineHeadIndent = indent * size + 10;//文字个数乘以字体大小
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributeDic;
    if ([YSTools dx_isNullOrNilWithObject:font]) {
        attributeDic = @{NSParagraphStyleAttributeName : paragraphStyle};
    }else{
        attributeDic = @{NSParagraphStyleAttributeName : paragraphStyle,NSFontAttributeName:font};
    }
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text] attributes:attributeDic];
    return attrText;
}


#pragma mark - 价格小数位富文本特定字符改变
+ (NSMutableAttributedString *)creatNSMutableAttributedStringWithString:(NSString *)string TextColor:(UIColor *)textColor TextFont:(CGFloat)textFont IsBold:(BOOL)isBold {
    
    if ([YSTools dx_isNullOrNilWithObject:string]) {
        
        return nil;
    }
    
    if ([string rangeOfString:@"."].location != NSNotFound) {
        
        /** 匹配.得到的下标 */
        NSRange range1 = [string rangeOfString:@"."];
        
        /** 得到小数 从第n为开始直到最后（包含第n位） */
        NSString * string2 = [string substringFromIndex:range1.location + 1];
        
        /** 富文本 */
        NSMutableAttributedString *attrDescribeStr = [[NSMutableAttributedString alloc] initWithString:string];
        
        /** 获取最后两个字符的range */
        NSRange range2 = NSMakeRange(range1.location + 1, string2.length);
        
        
        
        /** 设置文字颜色 */
        [attrDescribeStr addAttribute:NSForegroundColorAttributeName
         
                                value:textColor range:range2];
        /** 设置字号 */
        [attrDescribeStr addAttribute:NSFontAttributeName
                                value:[UIFont systemFontOfSize:textFont] range:range2];
        
        if (isBold) {/** 字体加粗 */
            
            /** 设置粗体  */
            UIFont * boldFont = [UIFont boldSystemFontOfSize:textFont];
            [attrDescribeStr addAttribute:NSFontAttributeName value:boldFont range:range2];//设置Text这四个字母的字体为粗体
            
        }
        
        return attrDescribeStr;
        
    }
    
    return nil;
    
}


#pragma mark - 控件设置单个或多个圆角
+ (void)viewBeizerRect:(CGRect)rect view:(UIView *)view corner:(UIRectCorner)corner cornerRadii:(CGSize)radii {
    UIBezierPath *maskPath= [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame =view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    
}

#pragma mark --请求网络时间戳

+ (void)getInternetDateWithSuccess:(void(^)(NSTimeInterval timeInterval))success Failure:(void(^)(NSError *error))failure {
    //1.创建URL
    NSString *urlString = @"http://m.baidu.com";
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //2.创建request请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:5];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPMethod:@"GET"];
    //3.创建URLSession对象
    NSURLSession *session = [NSURLSession sharedSession];
    //4.设置数据返回回调的block
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil && response != nil) {
            //这么做的原因是简体中文下的手机不能识别“MMM”，只能识别“MM”
            NSArray *monthEnglishArray = @[@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sept",@"Sep",@"Oct",@"Nov",@"Dec"];
            NSArray *monthNumArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"09",@"10",@"11",@"12"];
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSDictionary *allHeaderFields = [httpResponse allHeaderFields];
            NSString *dateStr = [allHeaderFields objectForKey:@"Date"];
            dateStr = [dateStr substringFromIndex:5];
            dateStr = [dateStr substringToIndex:[dateStr length]-4];
            dateStr = [dateStr stringByAppendingString:@" +0000"];
            //当前语言是中文的话，识别不了英文缩写
            for (NSInteger i = 0 ; i < monthEnglishArray.count ; i++) {
                NSString *monthEngStr = monthEnglishArray[i];
                NSString *monthNumStr = monthNumArray[i];
                dateStr = [dateStr stringByReplacingOccurrencesOfString:monthEngStr withString:monthNumStr];
            }
            NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
            [dMatter setDateFormat:@"dd MM yyyy HH:mm:ss Z"];
            NSDate *netDate = [dMatter dateFromString:dateStr];
            NSTimeInterval timeInterval = [netDate timeIntervalSince1970];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(timeInterval);});
        } else{
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);});}}];//5、执行网络请求
    
    [task resume];
    
}


#pragma mark - 返回重复字符的location
/**
 *  返回重复字符的location
 *
 *  @param text     初始化的字符串
 *  @param findText 查找的字符
 *
 *  @return 返回重复字符的location
 */
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText
{
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:20];
    if (findText == nil && [findText isEqualToString:@""]) {
        return nil;
    }
    NSRange rang = [text rangeOfString:findText];
    if (rang.location != NSNotFound && rang.length != 0) {
        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];
        NSRange rang1 = {0,0};
        NSInteger location = 0;
        NSInteger length = 0;
        for (int i = 0;; i++)
        {
            if (0 == i) {
                location = rang.location + rang.length;
                length = text.length - rang.location - rang.length;
                rang1 = NSMakeRange(location, length);
            }else
            {
                location = rang1.location + rang1.length;
                length = text.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            if (rang1.location == NSNotFound && rang1.length == 0) {
                break;
            }else
                [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
        }
        return arrayRanges;
    }
    return nil;
}



#pragma mark - 字体加粗 + 行间距
+ (NSMutableAttributedString *)getKeywordBold:(NSString *)keyword CompleteStr:(NSString *)completeStr FontSize:(CGFloat)fontSizes LineSpacing:(CGFloat)lineSpacing {
    
    NSString * string = completeStr;
    CGFloat fontSize = fontSizes;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    NSUInteger length = [string length];
    //设置字体
    UIFont *baseFont = [UIFont systemFontOfSize:fontSize];
    [attrString addAttribute:NSFontAttributeName value:baseFont range:NSMakeRange(0, length)];//设置所有的字体
    UIFont * boldFont = [UIFont boldSystemFontOfSize:fontSize];
    [attrString addAttribute:NSFontAttributeName value:boldFont range:[string rangeOfString:keyword]];//设置Text这四个字母的字体为粗体
    /** 行间距 */
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    
    
    return attrString;
    
}

//获取当前时间的时间戳(以秒为单位)
+(NSInteger)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    return (long)[datenow timeIntervalSince1970];
    
}
#pragma mark - 位移动画效果
+(void)addToShoppingCartWithGoodsImage:(UIImage *)goodsImage startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint completion:(void (^)(BOOL))completion{
    
    //------- 创建shapeLayer -------//
    CAShapeLayer *animationLayer = [[CAShapeLayer alloc] init];
    animationLayer.frame = CGRectMake(startPoint.x - 20, startPoint.y - 20, 40, 40);
    animationLayer.contents = (id)goodsImage.CGImage;
    
    // 获取window的最顶层视图控制器
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    UIViewController *parentVC = rootVC;
    while ((parentVC = rootVC.presentedViewController) != nil ) {
        rootVC = parentVC;
    }
    while ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = [(UINavigationController *)rootVC topViewController];
    }
    
    // 添加layer到顶层视图控制器上
    [rootVC.view.layer addSublayer:animationLayer];
    
    
    //------- 创建移动轨迹 -------//
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:startPoint];
    [movePath addQuadCurveToPoint:endPoint controlPoint:CGPointMake(200,100)];
    // 轨迹动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGFloat durationTime = 1; // 动画时间1秒
    pathAnimation.duration = durationTime;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.path = movePath.CGPath;
    
    
    //------- 创建缩小动画 -------//
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.5];
    scaleAnimation.duration = 1.0;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    
    // 添加轨迹动画
    [animationLayer addAnimation:pathAnimation forKey:nil];
    // 添加缩小动画
    [animationLayer addAnimation:scaleAnimation forKey:nil];
    
    
    //------- 动画结束后执行 -------//
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [animationLayer removeFromSuperlayer];
        completion(YES);
    });
}

#pragma mark - 通过文字内容自适应宽度
+ (CGSize)getButtonWidthWith:(UILabel *)lab Str:(NSString *)str {
    
    CGSize titleSize = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:lab.font.fontName size:lab.font.pointSize]}];
    
    return titleSize;
}
#pragma mark - 记录选中商品
+ (void)archiveCartId:(NSString *)cartId{
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path =[docPath stringByAppendingPathComponent:@"data.archiver"];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSMutableArray*idAry=[NSMutableArray array];
    idAry=[NSMutableArray arrayWithArray:array];
    [idAry addObject:cartId];
    NSArray*selectAry=[idAry copy];
    BOOL flag1 = [NSKeyedArchiver archiveRootObject:selectAry toFile:path];
    if (flag1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"beginRefreshingTableView" object:nil userInfo:nil];
    }
    
}
#pragma mark - 判断用户是否允许接收通知
+ (BOOL)isUserNotificationEnable {
    BOOL isEnable = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) { // iOS版本 >=8.0 处理逻辑
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
    } else { // iOS版本 <8.0 处理逻辑
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        isEnable = (UIRemoteNotificationTypeNone == type) ? NO : YES;
    }
    return isEnable;
}

#pragma mark - 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改  iOS版本 >=8.0 处理逻辑
+ (void)goToAppSystemSetting {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            if (@available(iOS 10.0, *)) {
                [application openURL:url options:@{} completionHandler:nil];
            } else {
                // Fallback on earlier versions
            }
        } else {
            [application openURL:url];
        }
    }
}
#pragma mark - 将传入的View生成图片
+ (UIImage *)makeImageWithView:(UIView *)view{
    CGSize s = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

