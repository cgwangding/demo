//
//  UIImage+QRCode.h
//  MyCategoriesCollection
//
//  Created by AD-iOS on 16/3/10.
//  Copyright © 2016年 DW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCode)

/**
 *  生成二维码
 *
 *  @param text 二维码信息
 *  @param size 二维码大小
 *
 *  @return 图片对象
 */
+ (UIImage*)createQRCodeWithString:(NSString*)text size:(CGSize)size;

/**
 *  生成一个带logo图片的二维码
 *
 *  @param text     二维码内容
 *  @param size     二维码图片的大小
 *  @param icon     logo图片
 *  @param iconSize logo大小
 *
 *  @return 带有logo的二维码图片
 *  注意：调用该方法生成带有logo的二维码后不可再调用- (UIImage*)imageBlackToTransparentWithRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue,否则会破坏二维码
 */
+ (UIImage*)createQRCodeWithString:(NSString *)text size:(CGSize)size withIconImage:(UIImage*)icon iconSize:(CGSize)iconSize;

/**
 *  生成一个带颜色带logo的二维码
 *
 *  @param text     同上
 *  @param size     同上
 *  @param color    二维码颜色
 *  @param icon     同上
 *  @param iconSize 同上
 *
 *  @return 生成一个带颜色带logo的二维码图片
 *注意：如果使用该方法生成二维码，得到的图片白色部分为透明色，最好不要设置imageView的背景颜色，否则会产生影响
 */
+ (UIImage*)createQRCodeWithString:(NSString *)text size:(CGSize)size color:(UIColor*)color withIconImage:(UIImage*)icon iconSize:(CGSize)iconSize;

/**
 *  改变图片的颜色
 *
 *  @param image 图片
 *  @param red   r值.0-255
 *  @param green g值.0-255
 *  @param blue  b值.0-255
 *
 *  @return 改变颜色后的图片
 */
- (UIImage*)imageBlackToTransparentWithRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

@end
