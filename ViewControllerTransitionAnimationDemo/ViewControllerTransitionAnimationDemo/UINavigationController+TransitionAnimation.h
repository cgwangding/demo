//
//  UINavigationController+TransitionAnimation.h
//  ViewControllerTransitionAnimationDemo
//
//  Created by AD-iOS on 15/10/19.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TransitonAnimateType) {
    TransitonAnimateTypeNone,
    TransitonAnimateTypeAnimate,
};

@interface UINavigationController (TransitionAnimation)<UIViewControllerTransitioningDelegate>

- (void)pushViewController:(UIViewController *)viewController animateType:(TransitonAnimateType)animateType;

@end
