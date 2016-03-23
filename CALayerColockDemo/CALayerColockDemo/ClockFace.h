//
//  ClockFace.h
//  CALayerColockDemo
//
//  Created by AD-iOS on 15/7/6.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@protocol ClockFaceDelegate;

@interface ClockFace : CAShapeLayer

@property (nonatomic, strong) NSDate *time;

@property (nonatomic, weak) id<ClockFaceDelegate>delegate;

@end

@protocol ClockFaceDelegate <NSObject>

- (void)clockDidChangeTimeWithTimeInterval:(NSInteger)timeInterval;

@end