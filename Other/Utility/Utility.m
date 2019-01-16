#import "Utility.h"
@implementation Utility
#pragma mark - 文件路径相关
+(NSString *)documentPath:(NSString *)filename
{
    NSString *result=nil;
    NSArray *folders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsFolder = [folders objectAtIndex:0];
    result = [documentsFolder stringByAppendingPathComponent:filename];
    return result;
}
+(NSString *)documentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return documentsDirectory;
}
#pragma mark - 设备判断
+(BOOL)isIphone5{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone
        && [UIScreen mainScreen].bounds.size.height == 568)
    {
        return YES;
    }
    return NO;
}
#pragma mark - 判断手机型号
+ (NSString *)getCurrentDeviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceModel isEqualToString:@"iPhone1,1"]) return @"iPhone 1G";
    if ([deviceModel isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([deviceModel isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([deviceModel isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"]) return @"Verizon iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([deviceModel isEqualToString:@"iPhone9,1"] || [deviceModel isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"] || [deviceModel isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"] || [deviceModel isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([deviceModel isEqualToString:@"iPhone10,2"] || [deviceModel isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"] || [deviceModel isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,1"])    return @"iPhone XS (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone11,2"])    return @"iPhone XS (GSM)";
    if ([deviceModel isEqualToString:@"iPhone11,4"])    return @"iPhone XS Max (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone11,5"])    return @"iPhone XS Max (GSM, Dual Sim, China)";
    if ([deviceModel isEqualToString:@"iPhone11,6"])    return @"iPhone XS Max (GSM)";
    if ([deviceModel isEqualToString:@"iPhone11,8"])    return @"iPhone XR (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone11,9"])    return @"iPhone XR (GSM)";
    if ([deviceModel isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    if ([deviceModel isEqualToString:@"iPod7,1"]) return @"iPod Touch 6";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,11"])      return @"iPad (5th Gen)";
    if ([deviceModel isEqualToString:@"iPad6,12"])      return @"iPad (5th Gen)";
    if ([deviceModel isEqualToString:@"iPad7,1"])       return @"iPad Pro 12.9 (2nd Gen)";
    if ([deviceModel isEqualToString:@"iPad7,2"])       return @"iPad Pro 12.9 (2nd Gen)";
    if ([deviceModel isEqualToString:@"iPad7,3"])       return @"iPad Pro 10.5";
    if ([deviceModel isEqualToString:@"iPad7,4"])       return @"iPad Pro 10.5";
    if ([deviceModel isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2G";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3 (2013)";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])   return @"Apple TV 4";
    if ([deviceModel isEqualToString:@"AppleTV6,2"])   return @"Apple TV 4K";
    if ([deviceModel isEqualToString:@"Watch1,1"])     return @"Apple Watch (1st generation) (38mm)";
    if ([deviceModel isEqualToString:@"Watch1,2"])     return @"Apple Watch (1st generation) (42mm)";
    if ([deviceModel isEqualToString:@"Watch2,6"])     return @"Apple Watch Series 1 (38mm)";
    if ([deviceModel isEqualToString:@"Watch2,7"])     return @"Apple Watch Series 1 (42mm)";
    if ([deviceModel isEqualToString:@"Watch2,3"])     return @"Apple Watch Series 2 (38mm)";
    if ([deviceModel isEqualToString:@"Watch2,4"])     return @"Apple Watch Series 2 (42mm)";
    if ([deviceModel isEqualToString:@"Watch3,1"])     return @"Apple Watch Series 3 (38mm Cellular)";
    if ([deviceModel isEqualToString:@"Watch3,2"])     return @"Apple Watch Series 3 (42mm Cellular)";
    if ([deviceModel isEqualToString:@"Watch3,3"])     return @"Apple Watch Series 3 (38mm)";
    if ([deviceModel isEqualToString:@"Watch3,4"])     return @"Apple Watch Series 3 (42mm)";
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceModel;
}
+ (NSString *)getCurrentDeviceModelDetail
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}
#pragma mark - 时间相关
static NSDateFormatter *s_format = nil;
+ (NSDateFormatter *)getDateFormatter
{
    if (s_format == nil) {
        s_format = [[NSDateFormatter alloc] init];
        [s_format setDateFormat:@"yyyy-MM-dd"];
    }
    return s_format;
}
static NSDateFormatter *s_fullFormat = nil;
+ (NSDateFormatter *)getFullDateFormatter
{
    if (s_fullFormat == nil) {
        s_fullFormat = [[NSDateFormatter alloc] init];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [s_fullFormat setTimeZone:timeZone];
        [s_fullFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return s_fullFormat;
}
+(NSString *)getCurrentDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}
+(NSDate *)getCurrentLocalDate{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}
+ (NSString*)getCurrentTimeString
{
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    return [dateformat stringFromDate:[NSDate date]];
}
+(NSString *)dateStringFromMstime:(long long)msTime{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:msTime/1000.0];
    NSDateFormatter * df = [self getFullDateFormatter];
    return [df stringFromDate:date];
}
+(NSString *)updateDateStringFromMstime:(long long)msTime{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:msTime/1000.0];
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyy.MM.dd HH:mm"];
    return [dateformat stringFromDate:date];
}
+(NSString *)timeStringFromMstime:(long long)msTime{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:msTime/1000.0];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSDateFormatter *df=[[NSDateFormatter  alloc]init];
    [df setTimeZone:timeZone];
    [df setDateFormat:@"HH:mm"];
    return [df stringFromDate:date];
}
+(long long)getMsTimeFromDate:(NSDate *)datetime
{
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    long long totalMilliseconds = interval*1000;
    return totalMilliseconds;
}
+ (NSString *)stringFromMstimeInterval:(NSString *)msInterVal{
    NSTimeInterval subDate = [msInterVal integerValue]/1000;
    NSString *res = nil;
    if (subDate / 3600 <= 1) {
        res = [NSString stringWithFormat:@"%f", subDate / 60];
        res = [res substringToIndex:res.length - 7];
        if (subDate < 60) {
            res = [NSString stringWithFormat:NSLocalizedString(@"刚刚", @""), res];
        }
        else{
            res = [NSString stringWithFormat:NSLocalizedString(@"%@分钟前", @""), res];
        }
    }
    else if (subDate / 3600 > 1 && subDate / 86400 <= 1) {
        res = [NSString stringWithFormat:@"%f", subDate / 3600];
        res = [res substringToIndex:res.length - 7];
        res = [NSString stringWithFormat:NSLocalizedString(@"%@小时前", @""), res];
    }
    else if (subDate / 86400 > 1) {
        res = [NSString stringWithFormat:@"%f", subDate / 86400];
        res = [res substringToIndex:res.length - 7];
        res = [NSString stringWithFormat:NSLocalizedString(@"%@天前", @""), res];
    }
    return [res length] ? res : @" ";
}
#pragma mark - 计算theBeforeDate到theLaterDate的时间间隔
+ (NSString *)intervalSinceTime:(NSDate *)theBeforeDate andTime:(NSDate *)theLaterDate {
    if (theBeforeDate == nil || theLaterDate == nil) {
        return @"";
    }
    NSDateFormatter * dateFormatter_ymd = [[NSDateFormatter alloc]init];
    [dateFormatter_ymd setDateFormat:@"yyyy-MM-dd"];
    NSString * ymdOfBeforeDate = [dateFormatter_ymd stringFromDate:theBeforeDate];
    NSString * ymdOfLaterDate = [dateFormatter_ymd stringFromDate:theLaterDate];
    NSTimeInterval beforeDate = [theBeforeDate timeIntervalSince1970];
    NSTimeInterval laterDate = [theLaterDate timeIntervalSince1970];
    NSString *res = nil;
    if ([ymdOfBeforeDate isEqualToString:ymdOfLaterDate] && (laterDate>beforeDate)) {
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"HH:mm"];
        res = [dateFormatter stringFromDate:theBeforeDate];
    }else{
        res = [self getWeekFromDate:theBeforeDate];
    }
    return [res length] ? res : @" ";
}
#pragma mark - 根据日期得到是星期几
+(NSString *)getWeekFromDate:(NSDate *)tDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:tDate];
    NSInteger week = [comps weekday];
    NSString * strWeek = @"";
    switch (week) {
        case 1:
            strWeek = @"星期日";
            break;
        case 2:
            strWeek = @"星期一";
            break;
        case 3:
            strWeek = @"星期二";
            break;
        case 4:
            strWeek = @"星期三";
            break;
        case 5:
            strWeek = @"星期四";
            break;
        case 6:
            strWeek = @"星期五";
            break;
        case 7:
            strWeek = @"星期六";
            break;
        default:
            break;
    }
    return strWeek;
}
+ (NSString*)getTimeStr:(long) createdAt
{
    NSString *timestamp;
    time_t now;
    time(&now);
    int distance = (int)difftime(now, createdAt);
    if (distance < 0) distance = 0;
    if (distance < 60) {
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "second ago" : "seconds ago"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "minute ago" : "minutes ago"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "hour ago" : "hours ago"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "day ago" : "days ago"];
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "week ago" : "weeks ago"];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        timestamp = [dateFormatter stringFromDate:date];
    }
    return timestamp;
}
+(NSDateComponents*) getComponent:(long long)time
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    return component;
}
+(NSString*) getTimeStrStyle1:(long long)time
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    NSInteger year=[component year];
    NSInteger month=[component month];
    NSInteger day=[component day];
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    NSInteger t_year=[component year];
    NSString*string=nil;
    long long now=[today timeIntervalSince1970];
    long distance=now-time;
    if(distance<60)
        string=@"刚刚";
    else if(distance<60*60)
        string=[NSString stringWithFormat:@"%ld 分钟前",distance/60];
    else if(distance<60*60*24)
        string=[NSString stringWithFormat:@"%ld 小时前",distance/60/60];
    else if(distance<60*60*24*7)
        string=[NSString stringWithFormat:@"%ld 天前",distance/60/60/24];
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%ld月%ld日",month,day];
    else
        string=[NSString stringWithFormat:@"%ld年%ld月%ld日",year,month,day];
    return string;
}
+(NSString*) getTimeStrStyle2:(long long)time
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    NSInteger year=[component year];
    NSInteger month=[component month];
    NSInteger day=[component day];
    NSInteger hour=[component hour];
    NSInteger minute=[component minute];
    NSInteger week=[component weekOfMonth];
    NSInteger weekday=[component weekday];
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    NSInteger t_year=[component year];
    NSInteger t_month=[component month];
    NSInteger t_day=[component day];
    NSInteger t_week=[component weekOfMonth];
    NSString*string=nil;
    if(year==t_year&&month==t_month&&day==t_day)
    {
        if(hour<6&&hour>=0)
            string=[NSString stringWithFormat:@"凌晨 %ld:%02ld",hour,minute];
        else if(hour>=6&&hour<12)
            string=[NSString stringWithFormat:@"上午 %ld:%02ld",hour,minute];
        else if(hour>=12&&hour<18)
            string=[NSString stringWithFormat:@"下午 %ld:%02ld",hour,minute];
        else
            string=[NSString stringWithFormat:@"晚上 %ld:%02ld",hour,minute];
    }
    else if(year==t_year&&week==t_week)
    {
        NSString * daystr=nil;
        switch (weekday) {
            case 1:
                daystr=@"日";
                break;
            case 2:
                daystr=@"一";
                break;
            case 3:
                daystr=@"二";
                break;
            case 4:
                daystr=@"三";
                break;
            case 5:
                daystr=@"四";
                break;
            case 6:
                daystr=@"五";
                break;
            case 7:
                daystr=@"六";
                break;
            default:
                break;
        }
        string=[NSString stringWithFormat:@"周%@ %ld:%02ld",daystr,hour,minute];
    }
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%ld-%ld %ld:%02ld",month,day,hour,minute];
    else
        string=[NSString stringWithFormat:@"%ld-%ld-%ld %ld:%02ld",year,month,day,hour,minute];
    return string;
}
#pragma mark - 网络相关
+ (BOOL)connectedToNetwork{
    struct sockaddr_storage zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);
    zeroAddress.ss_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags)
    {
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable&&!needsConnection) ? YES : NO;
}
+ (BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address
{
    if (!IPAddress || ![IPAddress length]) return NO;
    memset((char *) address, sizeof(struct sockaddr_in), 0);
    address->sin_family = AF_INET;
    address->sin_len = sizeof(struct sockaddr_in);
    int conversionResult = inet_aton([IPAddress UTF8String], &address->sin_addr);
    if (conversionResult == 0) {
        NSAssert1(conversionResult != 1, @"Failed to convert the IP address string into a sockaddr_in: %@", IPAddress);
        return NO;
    }
    return YES;
}
+ (NSString *) getIPAddressForHost: (NSString *) theHost
{
    theHost=[theHost substringFromIndex:7];
    struct hostent *host = gethostbyname([theHost UTF8String]);
    if (!host) {herror("resolv"); return NULL; }
    struct in_addr **list = (struct in_addr **)host->h_addr_list;
    NSString *addressString = [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
    return addressString;
}
+ (BOOL) hostAvailable: (NSString *) theHost
{
    NSString *addressString = [self getIPAddressForHost:theHost];
    if (!addressString)
    {
        printf("Error recovering IP address from host name\n");
        return NO;
    }
    struct sockaddr_in address;
    BOOL gotAddress = [self addressFromString:addressString address:&address];
    if (!gotAddress)
    {
        printf("Error recovering sockaddr address from %s\n", [addressString UTF8String]);
        return NO;
    }
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&address);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags =SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    return isReachable ? YES : NO;;
}
#pragma mark - 信息验证
+(BOOL)validateEmail:(NSString*)email
{
    if((0 != [email rangeOfString:@"@"].length) &&
       (0 != [email rangeOfString:@"."].length))
    {
        NSCharacterSet* tmpInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tmpInvalidMutableCharSet = [tmpInvalidCharSet mutableCopy];
        [tmpInvalidMutableCharSet removeCharactersInString:@"_-"];
        NSRange range1 = [email rangeOfString:@"@"
                                      options:NSCaseInsensitiveSearch];
        NSString* userNameString = [email substringToIndex:range1.location];
        NSArray* userNameArray   = [userNameString componentsSeparatedByString:@"."];
        for(NSString* string in userNameArray)
        {
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                return NO;
        }
        NSString *domainString = [email substringFromIndex:range1.location+1];
        NSArray *domainArray   = [domainString componentsSeparatedByString:@"."];
        for(NSString *string in domainArray)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        return YES;
    }
    else {
        return NO;
    }
}
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+(BOOL)isValidateString:(NSString *)myString
{
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
    NSRange userNameRange = [myString rangeOfCharacterFromSet:nameCharacters];
    if (userNameRange.location != NSNotFound) {
        return FALSE;
    }else{
        return TRUE;
    }
}
+(BOOL)isValidateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
#pragma mark - 图片操作相关
+(NSArray*)SeparateImage:(UIImage*)image ByX:(int)x andY:(int)y cacheQuality:(float)quality
{
    if (x<1) {
        NSLog(@"非法的 x!");
        return nil;
    }else if (y<1) {
        NSLog(@"非法的 y!");
        return nil;
    }
    quality = (quality<0)?0:quality;
    quality=(quality>1)?1:quality;
    if (![image isKindOfClass:[UIImage class]]) {
        NSLog(@"illegal image format!");
        return nil;
    }
    float _xstep=image.size.width*1.0/y;
    float _ystep=image.size.height*1.0/x;
    NSMutableArray *_mutableArray=[[NSMutableArray alloc]initWithCapacity:1];
    NSString*prefixName=@"imageSlice";
    for (int i=0; i<x; i++)
    {
        for (int j=0; j<y; j++)
        {
            CGRect rect=CGRectMake(_xstep*j, _ystep*i, _xstep, _ystep);
            CGImageRef imageRef=CGImageCreateWithImageInRect([image CGImage],rect);
            UIImage* elementImage=[UIImage imageWithCGImage:imageRef];
            NSString*_imageString=[NSString stringWithFormat:@"%@_%d_%d.jpg",prefixName,i,j];
            NSString*_imagePath=[NSTemporaryDirectory() stringByAppendingPathComponent:_imageString];
            NSData* _imageData=UIImageJPEGRepresentation(elementImage, quality);
            [_imageData writeToFile:_imagePath atomically:NO];
            [_mutableArray addObject:_imagePath];
        }
    }
    NSArray*_retArray=_mutableArray;
    return _retArray;
}
#pragma mark - save image to document path
+(BOOL)writeImage:(UIImage*)image toFileAtPath:(NSString*)aPath
{
    if ((image == nil) || (aPath == nil) || ([aPath isEqualToString:@""]))
        return NO;
    @try
    {
        NSData *imageData = nil;
        NSString *ext = [aPath pathExtension];
        if ([ext isEqualToString:@"png"])
        {
            imageData = UIImagePNGRepresentation(image);
        }
        else
        {
            imageData = UIImageJPEGRepresentation(image, 0);
        }
        if ((imageData == nil) || ([imageData length] <= 0))
            return NO;
        [imageData writeToFile:aPath atomically:YES];
        return YES;
    }
    @catch (NSException *e)
    {
        NSLog(@"create thumbnail exception.");
    }
    return NO;
}
+(BOOL)writeImagetoFilePath:(NSString *)filePath andImageName:(NSString *)imageName andImage:(UIImage *)image{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString  *imagefilepath = filePath;
    if ((image == nil) || (filePath == nil) || ([filePath isEqualToString:@""]))
        return NO;
    if([fm fileExistsAtPath:imagefilepath] == false)
    {
        [fm createDirectoryAtPath:imagefilepath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSError * error = nil;
    NSData *imageData = nil;
    NSString *ext = [imageName pathExtension];
    if ([ext isEqualToString:@"png"])
    {
        imageData = UIImagePNGRepresentation(image);
    }
    else
    {
        imageData = UIImageJPEGRepresentation(image, 0);
    }
    if ((imageData == nil) || ([imageData length] <= 0))
        return NO;
    [imageData writeToFile:[imagefilepath stringByAppendingPathComponent:imageName] options:NSDataWritingAtomic error:&error];
    if (error) {
        NSLog(@"%@",[error description]);
        return NO;
    }else{
        return YES;
    }
}
+(BOOL)deleteFileAtPath:(NSString *)filePath{
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:filePath error:&error];
    if (error) {
        NSLog(@"%@",[error description]);
        return NO;
    }else{
        return YES;
    }
}
+(BOOL)writeFileToPath:(NSString *)filePath andFileName:(NSString *)fileName andFileData:(NSData *)fileData{
    if (fileData == nil) {
        return NO;
    }
    NSFileManager * fileManager = [NSFileManager defaultManager];
    debugLog(@"filePath %@",filePath);
    NSError * error = nil;
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    NSString * fileFullPath = [filePath stringByAppendingPathComponent:fileName];
    debugLog(@"fileFullPath:%@",fileFullPath);
    if (error) {
        debugLog(@"create path error:%@",[error description]);
        return NO;
    }else{
        error = nil;
        [fileData writeToFile:fileFullPath options:NSDataWritingAtomic error:&error];
        if (error) {
            debugLog(@"write file error:%@",[error description]);
            return NO;
        }else{
            debugLog(@"succ write date to text.txt");
        }
    }
    return YES;
}
+(NSString *)calculateAgeByBirthday:(NSString *)birthday{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:birthday];
    NSTimeInterval dateDiff = [destDate timeIntervalSinceNow];
    NSString * age =  [NSString stringWithFormat:@"%d",abs((int)dateDiff/(60*60*24)/365)];
    return age;
}
#pragma mark -　Message Records Method
#pragma mark - 头像存放路径
+(NSString *)avatarImagesPath{
    NSString * retPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"avatarImages/"];
    return retPath;
}
#pragma mark - 占位图片
+ (UIImage *)placeHolderImage80x80{
    UIImage * placeholderimg = LOADIMAGE(@"placeholder_image_80x80", @"png");
    return placeholderimg;
}
+ (NSString *)mainPageAdImagePath{
    return [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"MainPageAdImage.png"];
}
#pragma mark - Label内容自适应
+(CGRect)autoSizeLabelFrameWithMaxWidth:(float)maxWidth andMaxHeight:(float)maxHeight andContentString:(NSString *)contentString andLabelObj:(UILabel *)label{
    CGSize expectedLabelSize = [self getTextWidthWithWraperMaxWidth:maxWidth andMaxHeight:maxHeight andContentString:contentString andWraperFont:label.font andWraperLineBreakMode:label.lineBreakMode];
    CGRect newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.size.width = expectedLabelSize.width;
    return newFrame;
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
+(CGSize)getTextWidthWithWraperMaxWidth:(float)maxWidth andMaxHeight:(float)maxHeight andContentString:(NSString *)contentString andWraperFont:(UIFont *)font andWraperLineBreakMode:(NSLineBreakMode)lineBreakMode{
#else
+(CGSize)getTextWidthWithWraperMaxWidth:(float)maxWidth andMaxHeight:(float)maxHeight andContentString:(NSString *)contentString andWraperFont:(UIFont *)font andWraperLineBreakMode:(UILineBreakMode)lineBreakMode{
#endif
    CGSize maximumLabelSize = CGSizeMake(maxWidth, maxHeight);
    CGSize expectedLabelSize = [contentString sizeWithFont:font constrainedToSize:maximumLabelSize lineBreakMode:lineBreakMode];
    return CGSizeMake(expectedLabelSize.width, expectedLabelSize.height);
}
#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];  
}
#pragma mark - GPS相关
+(BOOL)isLocationInGuilin:(CLLocationCoordinate2D)coordinate{
    if (coordinate.longitude>=110.0746473 &&
        coordinate.longitude<= 110.3747533 &&
        coordinate.latitude >= 25.137095 &&
        coordinate.latitude <= 25.45071) {
        return YES;
    }else{
        return NO;
    }
}
@end
