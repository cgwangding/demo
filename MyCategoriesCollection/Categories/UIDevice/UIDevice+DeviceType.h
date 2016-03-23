//
//  UIDevice+getDeviceType.h
//  CompetitionApply
//
//  Created by AD-iOS on 15/8/31.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (DeviceType)

/**
 *  获取设备的型号，eg.iphone 5
 *
 *  @return 设备型号
 */
+ (NSString*)getDeviceTypeDetail;

@end
