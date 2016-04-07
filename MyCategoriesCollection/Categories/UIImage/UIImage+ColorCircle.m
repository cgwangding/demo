
//
//  UIImage+ColorCircle.m
//  MyCategoriesCollection
//
//  Created by AD-iOS on 16/4/6.
//  Copyright © 2016年 DW. All rights reserved.
//

#import "UIImage+ColorCircle.h"

@implementation UIImage (ColorCircle)

- (UIImage*)imageWithInsideCircleColor:(UIColor*)inColor outSideCircleColor:(UIColor*)outColor andSize:(CGSize)size {
    
    CGRect rect = CGRectMake(2.5, 2.5, size.width * 2 - 3.5, size.height * 2 - 3.5);
    UIGraphicsBeginImageContext(CGSizeMake(size.width * 2, size.height * 2));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor lightGrayColor] colorWithAlphaComponent:0].CGColor);
    CGContextFillEllipseInRect(context,rect);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    
    
    //outside
    CGContextSetStrokeColorWithColor(context, outColor.CGColor);
    CGContextStrokeEllipseInRect(context, rect);
    
    //draw image
    
    CGRect newRect = CGRectMake(8.5, 8.5, size.width * 2 - 16.5, size.height * 2 - 16.5);
    //    //inside
    CGContextSetStrokeColorWithColor(context, inColor.CGColor);
    CGContextStrokeEllipseInRect(context, newRect);
    
    UIImageView *imgView =  [[UIImageView alloc]initWithImage:self];
    imgView.contentMode = UIViewContentModeCenter;
    [imgView setFrame:newRect];
    imgView.layer.borderColor = inColor.CGColor;
    imgView.layer.borderWidth = 0.5;
    imgView.layer.cornerRadius = newRect.size.width / 2.0;
    imgView.layer.masksToBounds = YES;
    [imgView drawViewHierarchyInRect:newRect afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


@end
