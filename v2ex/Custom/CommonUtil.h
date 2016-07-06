//
//  CommonUtil.h
//  wedding
//
//  Created by duanjycc on 14/11/14.
//  Copyright (c) 2014年 daoshun. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^BackUserIdentifyState)(NSString* identifyState);

@interface CommonUtil : NSObject

/**
 *  共同处理类单例实例化
 *
 *  @return 共同处理类单例
 */
+ (instancetype)currentUtil;

// 判断空字符串
+ (BOOL)isEmpty:(NSString *)string;
+ (NSString *)stringForID:(id)objectid;

+ (BOOL)isNullEmpty:(NSArray *)array;

/**
 *  判断数组是否为空
 *
 *  @param array 判断的数组
 *
 *  @return YES：为空， NO：不为空
 */
+ (BOOL)arrayIsEmpty:(NSArray *)array;

+ (NSString *)stringWithUrl:(NSString *)url Dic:(NSDictionary *)dict;

/**
 *  判断该字典是否为空
 *
 *  @param dict 判断的字典
 *
 *  @return NO：不为空 YES：为空
 */
+ (BOOL)dictIsEmpty:(NSDictionary *)dict;

/**
 *  去除左右空格
 *
 *  @param str 需要去除左右空格的字符串
 *
 *  @return 去除左右空格之后的字符串
 */
+ (NSString *)trimStr:(NSString *)str;


//读取 NSUserDefaults
+ (id)getObjectFromUD:(NSString *)key;

//存储 NSUserDefaults
+ (void)saveObjectToUD:(id)value key:(NSString *)key;
+ (void)deleteObjectFromUD:(NSString *)key;

//MD5加密
+ (NSString *)md5:(NSString *)password;

/**
 *  验证邮箱
 *
 *  @param email 邮箱
 *
 *  @return YES 格式正确 NO 格式错误
 */
+(BOOL)checkEmailForm:(NSString*)email;


/**
 *  checkPhonenum
 *
 *  @param phone 手机号码
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkPhonenum:(NSString *)phone;


/**
 *  判断电话号码格式
 *
 *  @param cellPhone 电话号码
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkCellPhone:(NSString *)cellPhone;

/**
 *  判断是否是数字(小数点后两位)
 *
 *  @param num 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkNum:(NSString *)num;

/**
 *  判断是否只是数字
 *
 *  @param num 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkOnlyNum:(NSString *)num;


/**
 *  判断是否是数字和字母
 *
 *  @param string 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkNumAndLetter:(NSString *)string;


/**
 *  不能输入特殊字符，可以输入字母，中文，[]【】(){}《》.,?><!:;''""，、。？；：“”‘’！
 *
 *  @param content 内容
 *
 *  @return YES:格式正确 NO：格式错误
 */
+ (BOOL)checkContent:(NSString *)content;


/**
 *  只能输入中文 字母 数字 空格
 *
 *  @param content 内容
 *
 *  @return YES:格式正确  NO:格式错误
 */
+ (BOOL)checkString:(NSString *)content;


/**
 *  判断是否含有表情
 *
 *  @param string 内容
 *
 *  @return YES:含有表情 NO:不含有表情
 */
+(BOOL)stringContainsEmoji:(NSString *)string;

/**
 *  校验密码复杂度
 *
 *  @param pwd 密码
 *
 *  @return YES 正确 NO 错误
 */
+ (BOOL)checkPwd:(NSString *)pwd;

/**
 *  校验款号复杂度
 *
 *  @param number 款号
 *
 *  @return YES 正确 NO 错误
 */
+ (BOOL)checkNumber:(NSString *)number;

/**
 *  校验email复杂度
 *
 *  @param email 邮件
 *
 *  @return YES 正确 NO 错误
 */
+ (BOOL)checkEmail:(NSString *)email;

/**
 *  获取设备型号
 *
 *  @return 设备型号
 */
+ (NSString *)getCurrentDeviceModel;


/**
 *  去除emoji表情
 *
 *  @param text 内容
 *
 *  @return
 */
+ (NSString *)disableEmoji:(NSString *)text;

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
        borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;
/**
 *  给view添加圆角
 *
 *  @param view       需要添加圆角的view
 *  @param radius     圆角度数
 *  @param rectCorner 给哪几个角添加 UIRectCornerTopLeft，UIRectCornerTopRight，UIRectCornerBottomLeft，UIRectCornerBottomRight，UIRectCornerAllCorners
 *  @param lineColor  线的颜色
 */
+ (void)addViewCornerRadius:(UIView *)view cornerRadius:(CGFloat)radius
                 rectCorner:(UIRectCorner)rectCorner lineColor:(UIColor *)lineColor;

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
         shadowRadius:(CGFloat)shadowRadius;

///****************** 关于时间方法 <S> ******************/
//// Date 转换 NSString (默认格式：自定义)
//+ (NSString *)getStringForDate:(NSDate *)date format:(NSString *)format;
//
//// NSString 转换 Date (默认格式：自定义)
//+ (NSDate *)getDateForString:(NSString *)string format:(NSString *)format;



// 根据文字，字号及固定宽(固定高)来计算高(宽)
+ (CGSize)sizeWithString:(NSString *)text
                fontSize:(CGFloat)fontsize
               sizewidth:(CGFloat)width
              sizeheight:(CGFloat)height;

// 窗口弹出动画
+ (void)shakeToShow:(UIView*)aView;

/****************** 关于数据方法 <S> ******************/
/**
 *  数组随机排序
 *
 *  @param array 需要排序的数组
 *
 *  @return 排序好的数组
 */
+ (NSMutableArray *) randomizedArrayWithArray:(NSArray *)array;

/****************** 关于图像方法 <S> ******************/

//图片方向处理
+ (UIImage *)fixOrientation:(UIImage *)srcImg;

//缩放图片
+ (UIImage *)scaleImage:(UIImage *)image minLength:(float)length;

/****************** 关于颜色方法 <S> ******************/

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/****************** 关于数字加减乘除方法 <S> ******************/
/**
 *  加法
 *
 *  @param number 数字
 *  @param addNum 被加的数字
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumAdd:(NSDecimalNumber *)number addNum:(NSDecimalNumber *)addNum;

/**
 *  减法
 *
 *  @param number 数字
 *  @param subtractNum 被减的数字
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumSubtract:(NSDecimalNumber *)number subtractNum:(NSDecimalNumber *)subtractNum;

/**
 *  乘法
 *
 *  @param number 数字
 *  @param multiplyNum 被乘数
 *
 *  @return 总数，保留两位小数
 */
+ (NSDecimalNumber *)decimalNumMultiply:(NSDecimalNumber *)number multiplyNum:(NSDecimalNumber *)multiplyNum;

/**
 *  处理获取的价格字符串
 *
 *  @param price    价格
 *  @param position 小数点几位
 *
 *  @return 处理后的字符串
 */

+ (NSString *)notRounding:(NSString*)price afterPoint:(NSInteger)position;



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
+ (BOOL)sortOutNumber:(NSInteger)num TextField:(UITextField * )textField range:(NSRange)range string:(NSString *)string;

/**
 *  根据时间戳拼接时间字符串
 *
 *  @param timeNumber 时间戳
 *
 *  @return 时间字符串
 */
+ (NSString *)dateStringTime:(NSString *)timeNumber;


@end
