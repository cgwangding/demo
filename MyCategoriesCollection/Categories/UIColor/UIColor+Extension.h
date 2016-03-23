//
//  UIColor+Extension.h
//  DuoLiFarm
//
//  Created by AD-iOS on 15/5/14.
//  Copyright (c) 2015年 wangding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
/**
 *  获取随机颜色
 *
 *  @return 颜色对象
 */
+ (UIColor*)randomColor;

/**
 *  将十六进制颜色转成UIColor
 *
 *  @param hexValue   16进制颜色 0xafd234
 *  @param alphaValue 透明度
 *
 *  @return 颜色对象
 */
+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;

/**
 *  将UIColor转换成16进制颜色
 *
 *  @param color color对象
 *
 *  @return 16进制颜色
 */
+ (NSString *) hexFromUIColor: (UIColor*) color;
@end
