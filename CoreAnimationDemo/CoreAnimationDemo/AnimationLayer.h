//
//  AnimationLayer.h
//  CoreAnimationDemo
//
//  Created by AD-iOS on 15/6/24.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface AnimationLayer : NSObject

+ (CABasicAnimation*)createOpacityAnimationWithBlock:(void(^)(CABasicAnimation *theAnimation))animation;


@end
