//
//  UIImage+QRCode.m
//  MyCategoriesCollection
//
//  Created by AD-iOS on 16/3/10.
//  Copyright © 2016年 DW. All rights reserved.
//

#import "UIImage+QRCode.h"

@implementation UIImage (QRCode)

+ (UIImage*)createQRCodeWithString:(NSString*)text size:(CGSize)size
{
    CIImage *ciImage = [UIImage createQRCodeWithString:text];
    return [UIImage createUIImageWithCIImage:ciImage size:size];
}

+ (UIImage*)createQRCodeWithString:(NSString *)text size:(CGSize)size withIconImage:(UIImage*)icon iconSize:(CGSize)iconSize
{
    UIImage *image = [UIImage createQRCodeWithString:text size:size];
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width,size.height)];
    [icon drawInRect:CGRectMake(size.width / 2 - iconSize.width / 2, (size.height - iconSize.height) / 2, iconSize.width, iconSize.height)];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

+ (UIImage*)createQRCodeWithString:(NSString *)text size:(CGSize)size color:(UIColor*)color withIconImage:(UIImage*)icon iconSize:(CGSize)iconSize{
    UIImage *image = [UIImage createQRCodeWithString:text size:size];
    
    CGColorRef colorRef = color.CGColor;
    const CGFloat *components =  CGColorGetComponents(colorRef);
    
    CGFloat red = components[0] * 255;
    CGFloat green = components[1] * 255;
    CGFloat blue = components[2] * 255;
    CGFloat alpha = components[3];
    UIImage *colorImage = [image imageBlackToTransparentWithRed:red andGreen:green andBlue:blue];
    UIGraphicsBeginImageContext(size);
    [colorImage drawInRect:CGRectMake(0, 0, size.width,size.height)];
    [icon drawInRect:CGRectMake(size.width / 2 - iconSize.width / 2, (size.height - iconSize.height) / 2, iconSize.width, iconSize.height)];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}

+ (CIImage*)createQRCodeWithString:(NSString*)text{
    NSData *stringData = [text dataUsingEncoding:NSUTF8StringEncoding];
    //获取所有的filter名字
    NSArray<NSString*> *filterNames = [CIFilter filterNamesInCategory:kCICategoryGenerator];
    //取出二维码生成器的filter
    CIFilter *qrFilter = [CIFilter filterWithName:filterNames[6]];
    //获取所有可设置的key
    NSArray *arr = qrFilter.inputKeys;
    //设置二维码的值
    [qrFilter setValue:stringData forKey:arr[0]];
    return qrFilter.outputImage;
}

+ (UIImage*)createUIImageWithCIImage:(CIImage*)image size:(CGSize)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (UIImage*)imageBlackToTransparentWithRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = self.size.width;
    const int imageHeight = self.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(
                                                 rgbImageBuf,
                                                 imageWidth,
                                                 imageHeight,
                                                 8,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), self.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentPerceptual);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}



@end
