//
//  ClockFace.m
//  CALayerColockDemo
//
//  Created by AD-iOS on 15/7/6.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import "ClockFace.h"
#import <UIKit/UIKit.h>

@interface ClockFace ()

@property (nonatomic, strong) CAShapeLayer *hourHand;
@property (nonatomic, strong) CAShapeLayer *minuteHand;
@property (nonatomic, strong) CAShapeLayer *secondHand;

@property (nonatomic, strong) CATextLayer *tLayer1;
@property (nonatomic, strong) CATextLayer *tLayer2;
@property (nonatomic, strong) CATextLayer *tLayer3;
@property (nonatomic, strong) CATextLayer *tLayer4;


@property (nonatomic, strong) CAGradientLayer *gradientLayer;



@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timeInterval;

@end

@implementation ClockFace

- (instancetype)init
{
    if (self = [super init]) {
        self.bounds = CGRectMake(0, 0, 200, 200);
        self.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
        self.fillColor = [UIColor clearColor].CGColor;
        self.strokeColor = [UIColor blackColor].CGColor;
        self.lineWidth = 4;
        
        self.hourHand = [CAShapeLayer layer];
        self.hourHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-2, -70, 4, 70)].CGPath;
        self.hourHand.fillColor = [UIColor blackColor].CGColor;
        self.hourHand.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self addSublayer:self.hourHand];
        
        self.minuteHand = [CAShapeLayer layer];
        self.minuteHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-1, -80, 3, 80)].CGPath;
        self.minuteHand.fillColor = [UIColor blackColor].CGColor;
        self.minuteHand.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self addSublayer:self.minuteHand];
        
        self.secondHand = [CAShapeLayer layer];
        self.secondHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-1, -90, 1, 90)].CGPath;
        self.secondHand.fillColor = [UIColor blackColor].CGColor;
        self.secondHand.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self addSublayer:self.secondHand];
        
        self.timeInterval = 1;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeClockFace) userInfo:nil repeats:YES];
        
        [self addSublayer:self.tLayer1];
        [self addSublayer:self.tLayer2];
        [self addSublayer:self.tLayer3];
        [self addSublayer:self.tLayer4];
    


        
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx
{
    CGContextAddRect(ctx, CGRectMake(99, 2, 2, 3));
    CGContextAddRect(ctx, CGRectMake(99, 196, 2, 3));
        CGContextAddRect(ctx, CGRectMake(2, 99, 2, 3));
        CGContextAddRect(ctx, CGRectMake(196, 99, 2, 3));
    CGContextSetFillColorWithColor(ctx, [UIColor darkTextColor].CGColor);
    CGContextFillPath(ctx);
}


- (void)changeClockFace
{
    if ([self.delegate respondsToSelector:@selector(clockDidChangeTimeWithTimeInterval:)]) {
        [self.delegate clockDidChangeTimeWithTimeInterval:self.timeInterval];
    }
    self.secondHand.affineTransform = CGAffineTransformMakeRotation(self.timeInterval/ 60.0 * 2.0 * M_PI);
    if (self.timeInterval > 60) {
        self.minuteHand.affineTransform = CGAffineTransformMakeRotation((self.timeInterval / 60.0) / 60.0 * 2.0 * M_PI);
        self.hourHand.affineTransform = CGAffineTransformMakeRotation(self.timeInterval / 3600.0 / 12.0 * 2.0 * M_PI);
    }
    self.timeInterval++;
}

- (void)setTime:(NSDate *)time
{
    NSCalendar *calendar = [NSCalendar currentCalendar ];
    NSDateComponents *comp = [calendar components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:time];
    NSLog(@"%lu-%lu-%lu",comp.hour,comp.minute,comp.second);
    self.timeInterval = comp.second + comp.minute * 60 + comp.hour * 60 * 60;
    [self changeClockFace];
}

- (void)startAnimation
{
    
}

#pragma mark - getter
- (CATextLayer *)tLayer1
{
    if (_tLayer1 == nil) {
        _tLayer1 = [CATextLayer layer];
        _tLayer1.fontSize = 12;
        _tLayer1.string = @"12";
        _tLayer1.foregroundColor = [UIColor darkTextColor].CGColor;
        _tLayer1.alignmentMode = kCAAlignmentCenter;
        _tLayer1.frame = CGRectMake(93, 3, 14, 12);
        
    }
    return _tLayer1;
}

- (CATextLayer *)tLayer2
{
    if (_tLayer2 == nil) {
        _tLayer2 = [CATextLayer layer];
        _tLayer2.fontSize = 12;
        _tLayer2.string = @"6";
        _tLayer2.foregroundColor = [UIColor darkTextColor].CGColor;
        _tLayer2.alignmentMode = kCAAlignmentCenter;
        _tLayer2.frame = CGRectMake(93, 183, 14, 12);
        
    }
    return _tLayer2;
}

- (CATextLayer *)tLayer3
{
    if (_tLayer3 == nil) {
        _tLayer3 = [CATextLayer layer];
        _tLayer3.fontSize = 12;
        _tLayer3.string = @"9";
        _tLayer3.foregroundColor = [UIColor darkTextColor].CGColor;
        _tLayer3.alignmentMode = kCAAlignmentLeft;
        _tLayer3.frame = CGRectMake(5, 94, 14, 12);
        
    }
    return _tLayer3;
}

- (CATextLayer *)tLayer4
{
    if (_tLayer4 == nil) {
        _tLayer4 = [CATextLayer layer];
        _tLayer4.fontSize = 12;
        _tLayer4.string = @"3";
        _tLayer4.foregroundColor = [UIColor darkTextColor].CGColor;
        _tLayer4.alignmentMode = kCAAlignmentRight;
        _tLayer4.frame = CGRectMake(181, 94, 14, 12);
        
    }
    return _tLayer4;
}


- (CAGradientLayer *)gradientLayer
{
    if (_gradientLayer == nil) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.frame;
        _gradientLayer.startPoint = CGPointMake(0,0);
        _gradientLayer.endPoint = CGPointMake(1, 1);
        _gradientLayer.colors = @[(id)[UIColor redColor].CGColor];

    }
    return _gradientLayer;
}

@end
