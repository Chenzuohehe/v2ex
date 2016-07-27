//
//  CommonUtil.m
//  wedding
//
//  Created by duanjycc on 14/11/14.
//  Copyright (c) 2014年 daoshun. All rights reserved.
//

#import "CommonUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "UIImageView+WebCache.h"
#import "Consts.h"
#import "HTMLParser.h"

//#import "UserInfo.h"

static CommonUtil *defaultUtil = nil;

@interface CommonUtil() {
    AppDelegate *appDelegate;
}


@end

@implementation CommonUtil

- (instancetype)init
{
    self = [super init];
    if (self) {
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    
    return self;
}

+ (instancetype)currentUtil
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultUtil = [[CommonUtil alloc] init];
    });
    
    return defaultUtil;
}

+ (NSString *)stringForID:(id)objectid {
    if ([CommonUtil isEmpty:objectid]) {
        return @"";
    }
    
    if ([objectid isKindOfClass:[NSString class]]) {
        return objectid;
    }
    
    if ([objectid isKindOfClass:[NSNumber class]]) {
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        return [numberFormatter stringFromNumber:objectid];
    } else {
        return [NSString stringWithFormat:@"%@", objectid];
    }
}

// 判断空字符串
+ (BOOL)isEmpty:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string description] isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSString class]] && [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  去除左右空格
 *
 *  @param str 需要去除左右空格的字符串
 *
 *  @return 去除左右空格之后的字符串
 */
+ (NSString *)trimStr:(NSString *)str{
    if ([self isEmpty:str]){
        return str;
    }
    
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return str;
}

/**
 *  判断数组是否为空
 *
 *  @param array 判断的数组
 *
 *  @return YES：为空， NO：不为空
 */
+ (BOOL)isNullEmpty:(NSArray *)array{
    
    if (array == nil) {
        return YES;
    }
    
    if (array == NULL){
        return YES;
    }
    
    if ([array isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([array isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    return NO;
    
}


/**
 *  判断数组是否为空
 *
 *  @param array 判断的数组
 *
 *  @return YES：为空， NO：不为空
 */
+ (BOOL)arrayIsEmpty:(NSArray *)array{
    
    if (array == nil) {
        return YES;
    }
    
    if (array == NULL){
        return YES;
    }
    
    if ([array isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([array isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([array isKindOfClass:[NSArray class]] && array.count > 0) {
        return NO;
    }
    
    return YES;
    
}

+ (NSString *)stringWithUrl:(NSString *)url Dic:(NSDictionary *)dict{
    
    NSMutableString * urlString = [NSMutableString string];
    [urlString appendString:REQUEST_HOST];
    [urlString appendString:url];
    NSArray * dictKey = [dict allKeys];
    for (int i = 0; i<[dict count]; i++) {
        
        NSString * key = dictKey[i];
        NSString * value = dict[key];
        
        if (i == 0) {
            [urlString appendString:[NSString stringWithFormat:@"?%@=%@",key,value]];
        }else{
            [urlString appendString:[NSString stringWithFormat:@"&%@=%@",key,value]];
        }
    }
    
    return urlString;
}

/**
 *  判断该字典是否为空
 *
 *  @param dict 判断的字典
 *
 *  @return NO：不为空 YES：为空
 */
+ (BOOL)dictIsEmpty:(NSDictionary *)dict{
    if (dict == nil) {
        return YES;
    }
    
    if (dict == NULL){
        return YES;
    }
    
    if ([dict isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([dict isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([dict isKindOfClass:[NSDictionary class]] && dict.count > 0) {
        return NO;
    }
    
    return YES;
}

//NSUserDefaults
+ (id)getObjectFromUD:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)saveObjectToUD:(id)value key:(NSString *)key {
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutaDic = [value mutableCopy];
        NSArray *allkeys = mutaDic.allKeys;
        for (int i=0; i<[allkeys count]; i++) {
            NSString *key = [allkeys objectAtIndex:i];
            
            NSString *value = [mutaDic objectForKey:key];
            if ([CommonUtil isEmpty:value]) {
                [mutaDic setObject:@"" forKey:key];
            }
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:mutaDic forKey:key];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)deleteObjectFromUD:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//MD5加密
+ (NSString *)md5:(NSString *)password {
    const char *original_str = [password UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

/**
 *  验证邮箱
 *
 *  @param email 邮箱
 *
 *  @return YES 格式正确 NO 格式错误
 */
+(BOOL)checkEmailForm:(NSString*)email{

    
    NSString * emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate * emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:email];

}

/**
 *  checkPhonenum
 *
 *  @param phone 手机号码
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkPhonenum:(NSString *)phone {
    if ([phone hasPrefix:@"+86"]) {
        phone = [phone substringFromIndex:3];
    }
    //手机号以1开头，11位数字
    NSString *phoneRegex = @"^[1][3-8][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

/**
 *  判断电话号码格式
 *
 *  @param cellPhone 电话号码
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkCellPhone:(NSString *)cellPhone{
    //手机号以1开头，11位数字
    NSString *phoneRegex = @"\\d{3}-\\d{8}|\\d{4}-\\d{7,8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:cellPhone];
}

/**
 *  判断是否是数字,最多两个小数点
 *
 *  @param num 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkNum:(NSString *)num{
    //数字
    NSString *regex = @"^[0-9]\\d*|^[1-9]\\d*\\.\\d{0,2}|0\\.\\d{0,2}$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [numTest evaluateWithObject:num];
}

/**
 *  判断是否只是数字
 *
 *  @param num 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkOnlyNum:(NSString *)num{
    //数字
    NSString *regex = @"^(0|[1-9][0-9]*)$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [numTest evaluateWithObject:num];
}

/**
 *  判断是否是数字和字母
 *
 *  @param string 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkNumAndLetter:(NSString *)string{
    
    //数字 和字母
    NSString *regex = [NSString stringWithFormat:@"^[a-zA-Z0-9]{%lu}$",(unsigned long)string.length];
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [numTest evaluateWithObject:string];
}


/**
 *  不能输入特殊字符，可以输入字母，中文，[]【】(){}《》.,?_><!:;''""，、。？；/ & ：“”‘’！
 *
 *  @param content 内容
 *
 *  @return YES:格式正确 NO：格式错误 
 */
+ (BOOL)checkContent:(NSString *)content{
    NSString *regex = [NSString stringWithFormat:@"^[a-zA-Z0-9.\u4e00-\u9fa5\\[\\]【】(){}《》.,?_><!:;''""，@、/。\\+？；&：\\-\\－“”‘’！\\w\\s%@]{%lu}$",  @"\\%", (unsigned long)content.length];
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [numTest evaluateWithObject:content];
}

/**
 *  只能输入中文 字母 数字 空格
 *
 *  @param content 内容
 *
 *  @return YES:格式正确  NO:格式错误
 */
+ (BOOL)checkString:(NSString *)content{
    NSString *regex = [NSString stringWithFormat:@"^[a-zA-Z0-9\u4e00-\u9fa5()（）\\s]{%lu}$", (unsigned long)content.length];
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [numTest evaluateWithObject:content];
}


/**
 *  判断是否含有表情
 *
 *  @param string 传入的字符串
 *
 *  @return YES:含有字符串 NO:不含有字符串
 */
+(BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


/**
 *  校验密码复杂度
 *
 *  @param pwd 密码
 *
 *  @return YES 正确 NO 错误
 */
+ (BOOL)checkPwd:(NSString *)pwd{
    
    //6-20位，英文，数字或符号
    NSString *regex = @"((?=.*\\d)(?=.*\\D)|(?=.*[a-zA-Z])(?=.*[^a-zA-Z]))^.{6,20}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [test evaluateWithObject:pwd];
    
}

/**
 *  校验款号复杂度
 *
 *  @param number 款号
 *
 *  @return YES 正确 NO 错误
 */
+ (BOOL)checkNumber:(NSString *)number{
    
    //是否包含中文
//    NSString *regex = @"[\u4e00-\u9fa5]$";
//    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//    if ([test evaluateWithObject:number]) {
//        //包含中文
//        return NO;
//    }
    
    //字母、数字、下划线和短横
    NSString *regex = [NSString stringWithFormat:@"^[a-zA-Z0-9_-]{%lu}$", (unsigned long)number.length];
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [test evaluateWithObject:number];
    
}

/**
 *  校验email复杂度
 *
 *  @param email 邮件
 *
 *  @return YES 正确 NO 错误
 */
+ (BOOL)checkEmail:(NSString *)email{
    NSString *regex = @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [test evaluateWithObject:email];
}

//获得设备型号
+ (NSString *)getCurrentDeviceModel {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    //NSString *platform = [NSString stringWithUTF8String:machine];二者等效
    free(machine);
    
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
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6S";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6S Plus";
    
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


/**
 *  去除emoji表情
 *
 *  @param text 内容
 *
 *  @return
 */
+ (NSString *)disableEmoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}
/****************** UIView方法 ******************/

/**
 *  添加页面边框，圆角属性
 *
 *  @param view         添加属性的view
 *  @param borderWidth  边框宽度
 *  @param borderColor  边框颜色
 *  @param cornerRadius 圆角
 */
+ (void)addViewAttr:(id)view borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;{
    
    if (view == nil){
        return;
    }
    
    UIView *attrView = (UIView *)view;
    
    if (borderWidth > 0){
        attrView.layer.borderWidth = borderWidth;
        attrView.layer.borderColor = borderColor.CGColor;
    }
    
    if (cornerRadius > 0) {
        attrView.layer.cornerRadius = cornerRadius;
    }
    
    if (borderWidth > 0 || cornerRadius > 0) {
        attrView.layer.masksToBounds = YES;
    }
    
}

/**
 *  给view添加圆角
 *
 *  @param view       需要添加圆角的view
 *  @param radius     圆角度数
 *  @param rectCorner 给哪几个角添加 UIRectCornerTopLeft，UIRectCornerTopRight，UIRectCornerBottomLeft，UIRectCornerBottomRight，UIRectCornerAllCorners
 *  @param lineColor  线的颜色
 */
+ (void)addViewCornerRadius:(UIView *)view cornerRadius:(CGFloat)radius
                 rectCorner:(UIRectCorner)rectCorner lineColor:(UIColor *)lineColor{
    
//    UIRectCorner rec = UIRectCornerBottomLeft | UIRectCornerBottomRight ;
    //颜色
    [lineColor set]; //设置线条颜色
    
    CGRect frame = view.bounds;
    frame.size.width += 2;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:rectCorner cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    maskLayer.lineWidth = 1;
    view.layer.mask = maskLayer;
}


/**
 *  给view添加阴影
 *
 *  @param view          需要处理的view
 *  @param shadowOffset  阴影偏移量, (CGSizeMake(4,4))x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
 *  @param shadowOpacity 阴影透明度
 *  @param shadowColor   阴影颜色
 *  @param shadowRadius  阴影半径
 */
+ (void)addViewShadow:(UIView *)view shadowOffset:(CGSize)shadowOffset
                 shadowOpacity:(CGFloat)shadowOpacity shadowColor:(UIColor *)shadowColor
         shadowRadius:(CGFloat)shadowRadius{
    
    view.layer.shadowColor = shadowColor.CGColor;//shadowColor阴影颜色
    view.layer.shadowOffset = shadowOffset;//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowOpacity = shadowOpacity;//阴影透明度，默认0
    view.layer.shadowRadius = shadowRadius;//阴影半径，默认3
    view.layer.masksToBounds = NO;
}

///****************** 关于时间方法 ******************/
//
//// Date 转换 NSString (默认格式：自定义)
//+ (NSString *)getStringForDate:(NSDate *)date format:(NSString *)format {
//    if (format == nil) format = @"yyyy-MM-dd HH:mm:ss";
//    
//    //实例化一个NSDateFormatter对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:format];
//    //用[NSDate date]可以获取系统当前时间
//    NSString *currentDateStr = [dateFormatter stringFromDate:date];
//    
//    return currentDateStr;
//}
//
//// NSString 转换 Date (默认格式：自定义)
//+ (NSDate *)getDateForString:(NSString *)string format:(NSString *)format; {
//    if (format == nil) format = @"yyyy-MM-dd HH:mm:ss";
//    
//    //实例化一个NSDateFormatter对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:format];
//    
//    return [dateFormatter dateFromString:string];
//}
//
//


// 根据文字，字号及固定宽(固定高)来计算高(宽) 需要计算什么，什么传值“0”
+ (CGSize)sizeWithString:(NSString *)text
                fontSize:(CGFloat)fontsize
               sizewidth:(CGFloat)width
              sizeheight:(CGFloat)height
{
    
    // 用何种字体显示
    UIFont *font = [UIFont systemFontOfSize:fontsize];
    
    CGSize expectedLabelSize = CGSizeZero;
    
    if ([self isEmpty:text]) {
         return expectedLabelSize;
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.alignment=NSTextAlignmentLeft;
        
        NSAttributedString *attributeText=[[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle}];
        CGSize labelsize = [attributeText boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        expectedLabelSize = CGSizeMake(ceilf(labelsize.width),ceilf(labelsize.height));
    } else {
        expectedLabelSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, height) lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    // 计算出显示完内容的最小尺寸
    
    return expectedLabelSize;
}


// 窗口弹出动画
+ (void)shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.75;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [aView.layer addAnimation:animation forKey:nil];
}

/**
 *  数组随机排序
 *
 *  @param array 需要排序的数组
 *
 *  @return 排序好的数组
 */
+ (NSMutableArray *) randomizedArrayWithArray:(NSArray *)array {
    
    NSMutableArray *results = [[NSMutableArray alloc]initWithArray:array];
    
    NSInteger i = results.count;
    
    while(--i > 0) {
        
        int j = rand() % (i+1);
        
        [results exchangeObjectAtIndex:i withObjectAtIndex:j];
        
    }
    
    return results;
    
}

/****************** 关于图像方法 <S> ******************/

//图片方向处理
+ (UIImage *)fixOrientation:(UIImage *)srcImg {
    if (srcImg.imageOrientation == UIImageOrientationUp) return srcImg;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (srcImg.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (srcImg.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, srcImg.size.width, srcImg.size.height,
                                             CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                             CGImageGetColorSpace(srcImg.CGImage),
                                             CGImageGetBitmapInfo(srcImg.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (srcImg.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.height,srcImg.size.width), srcImg.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.width,srcImg.size.height), srcImg.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return [CommonUtil scaleImage:img minLength:600];
}


+ (UIImage *)scaleImage:(UIImage *)image minLength:(float)length
{
    if (image.size.width <= length || image.size.height <= length) {
        return image;
    }
    
    CGFloat scaleSize = MAX(length/image.size.width, length/image.size.height);
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

/****************** 关于颜色方法 <S> ******************/

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}


/****************** 关于数字加减乘除方法 <S> ******************/
/**
 *  加法
 *
 *  @param number 数字
 *  @param addNum 被加的数字
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumAdd:(NSDecimalNumber *)number addNum:(NSDecimalNumber *)addNum{
    /*
     保留两位小数
     NSRoundDown,    // Always down == truncate  ／／只舍不入
     */
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       
                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                       
                                       scale:2
                                       
                                       raiseOnExactness:NO
                                       
                                       raiseOnOverflow:NO
                                       
                                       raiseOnUnderflow:NO
                                       
                                       raiseOnDivideByZero:YES];
    
    return [number decimalNumberByAdding:addNum withBehavior:roundUp];
}

/**
 *  减法
 *
 *  @param number 数字
 *  @param subtractNum 被减的数字
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumSubtract:(NSDecimalNumber *)number subtractNum:(NSDecimalNumber *)subtractNum{
    /*
     保留两位小数
     NSRoundDown,    // Always down == truncate  ／／只舍不入
     */
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       
                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                       
                                       scale:2
                                       
                                       raiseOnExactness:NO
                                       
                                       raiseOnOverflow:NO
                                       
                                       raiseOnUnderflow:NO
                                       
                                       raiseOnDivideByZero:YES];
    
    return [number decimalNumberBySubtracting:subtractNum withBehavior:roundUp];
}

/**
 *  乘法
 *
 *  @param number 数字
 *  @param multiplyNum 被乘数
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumMultiply:(NSDecimalNumber *)number multiplyNum:(NSDecimalNumber *)multiplyNum{
    /*
     保留两位小数
     NSRoundDown,    // Always down == truncate  ／／只舍不入
     */
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       
                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                       
                                       scale:2
                                       
                                       raiseOnExactness:NO
                                       
                                       raiseOnOverflow:NO
                                       
                                       raiseOnUnderflow:NO
                                       
                                       raiseOnDivideByZero:YES];
    
    return [number decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
}


/**
 *   处理获取的字符串 保留小数点后两位
 *
 *    @brief    截取指定小数位的值
 *
 *    @param     price     目标数据
 *    @param     position     有效小数位
 *
 *    @return    截取后数据
 */
+ (NSString *)notRounding:(NSString*)price afterPoint:(NSInteger)position
{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain                                               scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithString:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    NSString * finaPrice = [NSString stringWithFormat:@"%@",roundedOunces];
    
    if ([finaPrice rangeOfString:@"."].length!=0) {
        
        NSRange range = [finaPrice rangeOfString:@"."];
        if ([finaPrice substringFromIndex:range.location].length==2) {
            return [NSString stringWithFormat:@"%@0",finaPrice];
        }
        return finaPrice;
    }else{
        
        NSString * point = @"";
        for (int i =0; i<position; i++) {
            if ([self isEmpty:point]) {
                 point = @".0";
            }else{
                point = [NSString stringWithFormat:@"%@%@",point,@"0"];
            }
        }
        return [NSString stringWithFormat:@"%@%@",finaPrice,point];
    }

}








/**
 *  整理价格textField 配合(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 *
 *  @param num       几位数价格
 *  @param textField textfield
 *  @param range     range
 *  @param string    string
 *
 *  @return yes or no
 */
+ (BOOL)sortOutNumber:(NSInteger)num TextField:(UITextField * )textField range:(NSRange)range string:(NSString *)string{
    
    //总长度
    NSInteger strLength = textField.text.length - range.length + string.length;
    
    BOOL isHaveDian = YES;
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian=NO;
    }
    
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([textField.text length]==0){
                if(single == '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
                
            }
            
            if (single == '.' && [textField.text length]==1 && [textField.text isEqualToString:@"0"]) {
                return YES;
            }
            if (single == '0' &&[textField.text length]==1 && [textField.text isEqualToString:@"0"]) {
                return NO;
            }
            
            
            if (single=='.')
            {
                if(!isHaveDian)//text中还没有小数点
                {
                    
                }else
                {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    NSInteger tt=range.location-ran.location;
                    if (tt > 2){
                        return NO;
                    }
                }
                
            }
        }else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    
    //超过6位不可输入
    if (strLength > num) {
        NSString *text = nil;
        
        //获取当前输入内容
        if (string.length > 0) {
            text = [NSString stringWithFormat:@"%@%@",textField.text,string];
        }else{
            text = [textField.text substringToIndex:range.location];
        }
        
        if ([text doubleValue] >= pow(10, num)) {
            return NO;
        }
        
    }
    
    
    return YES;
    
}


/**
 *  判断是否登录
 *
 *  @param needLogin YES:未登录就弹出登录页面， NO：未登录不弹出登录页面
 *
 *  @return YES：已经登录 NO：未登录
 */
- (BOOL)isLogin:(BOOL)needLogin{
    return YES;
}


/**
 *  根据时间戳拼接时间字符串
 *
 *  @param timeNumber 时间戳
 *
 *  @return 时间字符串
 */
+ (NSString *)dateStringTime:(NSString *)timeNumber{
    
//    NSDate = 
    NSDate * time = [NSDate dateWithTimeIntervalSince1970:[timeNumber longLongValue]];
    NSDate * nowDate =  [NSDate date];
    
    // 注意获取calendar,应该根据系统版本判断
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit type = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    
    // 4.获取了时间元素
    NSDateComponents *cmps = [calendar components:type fromDate:time toDate:nowDate options:0];
    
    if (cmps.year > 0) {
        if (cmps.day <= 0) {
            if (cmps.month <= 0) {
                return [NSString stringWithFormat:@"%ld年",cmps.year];
            }
            return [NSString stringWithFormat:@"%ld年%ld月",cmps.year,cmps.month];
            
        }
        return [NSString stringWithFormat:@"%ld年%ld月%ld天",cmps.year,cmps.month,cmps.day];
    }
    if (cmps.month > 0) {
        if (cmps.day <= 0) {
            return [NSString stringWithFormat:@"%ld月",cmps.month];
        }
        return [NSString stringWithFormat:@"%ld月%ld天",cmps.month,cmps.day];
    }
    if (cmps.day > 0) {
        if (cmps.hour <= 0) {
            return [NSString stringWithFormat:@"%ld天",cmps.day];
        }
        return [NSString stringWithFormat:@"%ld天%ld小时",cmps.day,cmps.hour];
    }
    if (cmps.hour > 0) {
        if (cmps.minute <= 0) {
            return [NSString stringWithFormat:@"%ld小时",cmps.hour];
        }
        return [NSString stringWithFormat:@"%ld小时%ld分钟",cmps.hour,cmps.minute];
    }
    if (cmps.minute > 0) {
        if (cmps.second <= 0) {
            return [NSString stringWithFormat:@"%ld分钟",cmps.hour];
        }
        return [NSString stringWithFormat:@"%ld分钟%ld秒",cmps.minute,cmps.second];
    }
    
    return [NSString stringWithFormat:@"%ld秒钟",cmps.second];
}

+ (NSArray *)feedEntityListFromHtmlString:(id)responseObject{
    NSMutableArray *FeedEntityList = [[NSMutableArray alloc] init];
    
    @autoreleasepool {
        
        NSString *htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSError *error = nil;
        HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:&error];
        
        if (error) {
            NSLog(@"Error: %@", error);
            return nil;
        }
        
        HTMLNode *bodyNode = [parser body];
        NSArray *cellNodes = [bodyNode findChildTags:@"div"];
        for (HTMLNode *cellNode in cellNodes) {
            //<div class="cell item" style="">
            
            FeedEntity * feedEntity = [[FeedEntity alloc]init];
            feedEntity.member = [[MemberModel alloc]init];
            feedEntity.node = [[NodeModel alloc]init];
            
            if ([[cellNode getAttributeNamed:@"class"] isEqualToString:@"cell item"]) {
                //<td width="10"></td>
                NSArray *tdNodes = [cellNode findChildTags:@"td"];
                
                for (HTMLNode *tdNode in tdNodes) {
                    
                    NSString *content = tdNode.rawContents;
                    
                    //拥有class="avatar"
                    if ([content rangeOfString:@"class=\"avatar\""].location != NSNotFound) {
                        
                        HTMLNode *userIdNode = [tdNode findChildTag:@"a"];
                        if (userIdNode) {
                            //名称
                            NSString *idUrlString = [userIdNode getAttributeNamed:@"href"];
                            feedEntity.member.username = [[idUrlString componentsSeparatedByString:@"/"] lastObject];
                        }
                        HTMLNode *avatarNode = [tdNode findChildTag:@"img"];
                        if (avatarNode) {
                            NSString *avatarString = [avatarNode getAttributeNamed:@"src"];
                            //替换成头像大图
                            if ([avatarString rangeOfString:@"normal.png"].location != NSNotFound) {
                                avatarString = [avatarString stringByReplacingOccurrencesOfString:@"normal.png" withString:@"large.png"];
                            }
                            feedEntity.member.avatar_large = avatarString;
                        }
                        
                    }
                    //title
                    if ([content rangeOfString:@"class=\"item_title\""].location != NSNotFound) {
                        
                        NSArray * spanArrays = [tdNode findChildTags:@"span"];
                        for (HTMLNode * titleNode in spanArrays) {
                            NSString * titleString = titleNode.rawContents;
                            if ([titleString rangeOfString:@"class=\"item_title\""].location != NSNotFound) {
                                //标题
                                HTMLNode *tNode = [titleNode findChildTag:@"a"];
                                feedEntity.title = tNode.allContents;
                                
                            }
                            if ([titleString rangeOfString:@"class=\"node\""].location != NSNotFound) {
                                //tag
                                HTMLNode *tNode = [titleNode findChildTag:@"a"];
                                feedEntity.node.title = tNode.allContents;
                                
                            }
                            feedEntity.replyStatus = nil;
                            if ([titleString rangeOfString:@"class=\"small fade\""].location !=NSNotFound) {
                                
                                if ([titleString rangeOfString:@"最后回复"].location != NSNotFound || [titleString rangeOfString:@"前"].location != NSNotFound){
                                    
                                    feedEntity.replyStatus = [NSString stringWithFormat:@"%@",titleNode.allContents];
                                }
                            }
                        }
                    }
                    if ([content rangeOfString:@"class=\"count_livid\""].location != NSNotFound) {
                        //回复数
                        HTMLNode *replyNode = [tdNode findChildTag:@"a"];
                        feedEntity.replies = replyNode.allContents;
                        
                        //回复单后缀
                        NSString *replyString = [replyNode getAttributeNamed:@"href"];
                        feedEntity.identifier = replyString;
                        
                        
                    }
                }
                [FeedEntityList addObject:feedEntity];
            }
        }
    }
    
    return FeedEntityList;
}

/**
 *  根据data类型html获取feedEntitydetail
 *
 *  @param responseObject data
 *
 *  @return DetailModel
 */
+ (DetailModel *)feedEntityDetailFromHtmlString:(id)responseObject{
    DetailModel * detail = [[DetailModel alloc]init];
    @autoreleasepool {
        NSString *htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSError *error = nil;
        HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:&error];
        
        if (error) {
            NSLog(@"Error: %@", error);
            return nil;
        }
        
        HTMLNode *bodyNode = [parser body];
        NSArray *cellNodes = [bodyNode findChildTags:@"div"];
        for (HTMLNode *cellNode in cellNodes) {
            
            if ([[cellNode getAttributeNamed:@"class"] isEqualToString:@"header"]) {
                
                //帖子详情之头像headImage
                HTMLNode *avatarNode = [cellNode findChildTag:@"img"];
                if (avatarNode) {
                    NSString *avatarString = [avatarNode getAttributeNamed:@"src"];
                    //替换成头像大图
                    if ([avatarString rangeOfString:@"normal.png"].location != NSNotFound) {
                        avatarString = [avatarString stringByReplacingOccurrencesOfString:@"normal.png" withString:@"large.png"];
                        
                    }
                    detail.headImageUrl = avatarString;
                }
                
                NSArray *aNodes = [cellNode findChildTags:@"a"];
                for (HTMLNode * aNode in aNodes) {
                    //
                    NSString *hrefString = [aNode getAttributeNamed:@"href"];
                    
                    if (hrefString) {
                        //userName
                        if ([hrefString rangeOfString:@"/member/"].location != NSNotFound) {
                            detail.userName = [[hrefString componentsSeparatedByString:@"/"]lastObject];
                        }
                        //tag
                        if ([hrefString rangeOfString:@"/go/"].location != NSNotFound) {
                            detail.tag = aNode.allContents;
                        }
                    }
                }
                
                //repilesStatus
                if ([cellNode.rawContents rangeOfString:@"small class=\"gray\""].location != NSNotFound) {
                    HTMLNode * repliesStatusNode = [cellNode findChildTag:@"small"];
                    detail.repilesStatus = repliesStatusNode.allContents;
                }
                
                //title
                if ([cellNode.rawContents rangeOfString:@"<h1>"].location != NSNotFound) {
                    HTMLNode * titleNode = [cellNode findChildTag:@"h1"];
                    detail.title = titleNode.allContents;
                }
                
            }
            //content
            if ([[cellNode getAttributeNamed:@"class"] isEqualToString:@"markdown_body"]) {
//                NSLog(@"markdown_body:%@ \n\n %@",cellNode.allContents,cellNode.rawContents);
                detail.content = cellNode.allContents;
            }
            
            
        }
    }
    
    return detail;
}

@end
