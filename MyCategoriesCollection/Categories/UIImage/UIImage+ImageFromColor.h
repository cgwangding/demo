//
//  UIImage+ImageFromColor.h
//  Genvana
//
//  Created by mike.sun on 14-5-27.
//  Copyright (c) 2014年 Panda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageFromColor)

/**
 *  创建一个存颜色的图片
 *
 *  @param color <#color description#>
 *  @param size  <#size description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
