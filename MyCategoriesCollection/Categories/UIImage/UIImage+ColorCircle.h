//
//  UIImage+ColorCircle.h
//  MyCategoriesCollection
//
//  Created by AD-iOS on 16/4/6.
//  Copyright © 2016年 DW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorCircle)
- (UIImage*)imageWithInsideCircleColor:(UIColor*)inColor outSideCircleColor:(UIColor*)outColor andSize:(CGSize)size;
@end
