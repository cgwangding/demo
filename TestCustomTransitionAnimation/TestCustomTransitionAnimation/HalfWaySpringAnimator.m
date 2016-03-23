//
//  HalfWaySpringAnimator.m
//  TestCustomTransitionAnimation
//
//  Created by AD-iOS on 16/2/15.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "HalfWaySpringAnimator.h"

@implementation HalfWaySpringAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 2;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = fromVC.view;
    UIView *toView  = toVC.view;
    
    toView.frame = CGRectMake(-320, 0, 160, fromView.frame.size.height);
    
    [containerView addSubview:toView];
    
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:transitionDuration delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        toView.frame = [transitionContext finalFrameForViewController:toVC];
        toView.frame = CGRectMake(0,0, 2 / 3.0 * fromView.frame.size.width, fromView.frame.size.height);
        
        fromView.frame = CGRectMake(2 / 3.0 * fromView.frame.size.width, 0, fromView.frame.size.width - 2 / 3.0 * fromView.frame.size.width, fromView.frame.size.height);
        fromView.alpha = 0.5;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
