//
//  UIControl+TouchEventInterval.h
//  CompetitionApply
//
//  Created by AD-iOS on 15/12/7.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (TouchEventInterval)
/**
 *  设置点击间隔时间防止重复快速点击
 */
@property (assign, nonatomic) NSTimeInterval wd_acceptEventInterval;

@property (assign, nonatomic, readonly) NSTimeInterval wd_acceptedEventTime;

@end
