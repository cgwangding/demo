
//
//  RadarCircleView.m
//  RadarCircleWave
//
//  Created by AD-iOS on 15/12/4.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "RadarCircleView.h"
#import <QuartzCore/QuartzCore.h>

@interface RadarCircleView ()
@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSMutableArray *layerArray;

@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation RadarCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self makeAnimateLayer];
        [self.timer setFireDate:[NSDate date]];
        self.currentIndex = 0;
    }
    return self;
}

- (void)makeAnimateLayer
{
    CGPoint centerPos = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    for (int i = 0; i < 10; i++) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth = 1;
        layer.strokeColor = [UIColor grayColor].CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.fillMode = kCAFillModeRemoved;
        layer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(centerPos.x - 20 * (i + 1) , centerPos.y - 20 * (i + 1), 40 * (i+1), 40 * (i+1))].CGPath;
        [self.layerArray addObject:layer];
    }
}

- (void)update
{
    CAShapeLayer *layer = self.layerArray[self.currentIndex];
    [self.layer addSublayer:layer];
    //alpha
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animate.removedOnCompletion = YES;
    animate.duration = 0.1;
    animate.fromValue = @(1);
    animate.toValue = @(0);
//    animate.autoreverses = YES;
//    animate.repeatCount = MAXFLOAT;
    
    animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [layer addAnimation:animate forKey:@"layerAnimate"];
    
//    [layer setAffineTransform:CGAffineTransformMakeScale(self.currentIndex, self.currentIndex)];
    
    self.currentIndex++;
    if (self.currentIndex >= 10) {
        self.currentIndex = 0;
    }
}

- (NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(update) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (NSMutableArray *)layerArray
{
    if (_layerArray == nil) {
        _layerArray = [NSMutableArray array];
    }
    return _layerArray;
}

@end
