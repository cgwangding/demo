//
//  UIDevice+DeviceValidate.m
//  MyCategoriesCollection
//
//  Created by AD-iOS on 16/3/10.
//  Copyright © 2016年 DW. All rights reserved.
//

#import "UIDevice+DeviceValidate.h"
#import <CoreLocation/CoreLocation.h>

@implementation UIDevice (DeviceValidate)


+ (BOOL)isDeviceCameraAvailable
{
    BOOL cameraAvailable = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    return cameraAvailable;
}

+ (BOOL)isDeviceFrontCameraAvailable
{
    BOOL frontCameraAvailable = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    return frontCameraAvailable;
}

// 相册是否可用
+ (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

+(BOOL)isDeviceMagnetometerAvailable
{
    //检查指南针 CoreLocation.framework  <CoreLocation/CoreLocation.h>
    BOOL magnetometerAvailbale = [CLLocationManager headingAvailable];
    return magnetometerAvailbale;
    
}


@end
