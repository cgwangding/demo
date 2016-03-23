//
//  UIDevice+DeviceValidate.h
//  MyCategoriesCollection
//
//  Created by AD-iOS on 16/3/10.
//  Copyright © 2016年 DW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (DeviceValidate)

//验证设备摄像头是否可用
+ (BOOL)isDeviceCameraAvailable;

+ (BOOL)isDeviceFrontCameraAvailable;
// 相册是否可用
+ (BOOL) isPhotoLibraryAvailable;
//验证设备时候可以使用指南针
+ (BOOL)isDeviceMagnetometerAvailable;

@end
