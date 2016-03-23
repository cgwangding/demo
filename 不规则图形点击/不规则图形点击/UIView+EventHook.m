
//
//  UIView+EventHook.m
//  不规则图形点击
//
//  Created by AD-iOS on 16/1/14.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "UIView+EventHook.h"
#import <objc/runtime.h>
#import "AppDelegate.h"

@implementation UIView (EventHook)

- (void)setEnableIrregularTouch:(BOOL)isEnable
{
    if (isEnable) {

        Method origin = class_getInstanceMethod([self class], @selector(pointInside:withEvent:));
        Method custom = class_getInstanceMethod([self class], @selector(wd_pointInside:withEvent:));
        method_exchangeImplementations(origin, custom);
        
        origin = class_getInstanceMethod([self class], @selector(hitTest:withEvent:));
        custom = class_getInstanceMethod([self class], @selector(wd_hitTest:withEvent:));
        method_exchangeImplementations(origin, custom);
    }
}

- (BOOL)wd_pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    [self wd_pointInside:point withEvent:event];
    //根据此处的判断来确定
   UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    BOOL can = [path containsPoint:point];
    return can;
}

- (UIView *)wd_hitTest: (CGPoint)point withEvent: (UIEvent *)event
{
    UIView * answerView = [self wd_hitTest: point withEvent: event];
    if ([self wd_pointInside:point withEvent:event]) {
        return answerView;
    }
    return nil;
}


@end
