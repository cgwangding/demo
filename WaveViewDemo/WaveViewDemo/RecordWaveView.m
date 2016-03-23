
//
//  RecordWaveView.m
//  WaveViewDemo
//
//  Created by AD-iOS on 15/12/9.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "RecordWaveView.h"

#define MaxH 16
#define MaxW (180 + 60)

@interface RecordWaveView ()

@property (strong, nonatomic) NSTimer *waveTimer;
@property (strong, nonatomic) UILabel *label;

@property (assign, nonatomic) NSInteger currentSec;

@end

@implementation RecordWaveView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGRect resultFrame = frame;
        resultFrame.size.width = MaxW;
        resultFrame.size.height = MaxH;
        self.frame = resultFrame;
        self.currentSec = 0;
        [self addSubview:self.label];
        [self.waveTimer setFireDate:[NSDate date]];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGPoint center = CGPointMake(0, rect.size.height / 2.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    {
        CGContextSaveGState(context);
        
        CGContextMoveToPoint(context, 0, center.y);
        CGContextAddLineToPoint(context, 90, center.y);
        CGContextMoveToPoint(context, 90 + 60, center.y);
        CGContextAddLineToPoint(context, MaxW, center.y);
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context,[UIColor colorWithRed:87/255.0 green:139/255.0 blue:199/255.0 alpha:1].CGColor);
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
    }
    
}

- (void)clockUpdate
{
    self.currentSec++;
    self.label.text = [self formatTime];
    //    int rand = arc4random() % 10;
    [self updateVoice:7 / 10.0];
}

- (NSString*)formatTime
{
    NSString *result = @"00:00";
    NSInteger currentTime = self.currentSec;
    if (currentTime < 10) {
        result = [NSString stringWithFormat:@"00:0%ld",currentTime];
    }else{
        result = [NSString stringWithFormat:@"00:%ld",currentTime];
    }
    return result;
}

- (void)updateVoice:(CGFloat)voice
{
    CGPoint center = CGPointMake(0, self.frame.size.height / 2.0);
    //16 / 10 * rand / 2.0
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat lineHeight = 16 * voice;
    CGPathMoveToPoint(path, NULL, 0, -lineHeight/2);
    CGPathAddLineToPoint(path, NULL, 0,  lineHeight / 2);
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.position = center;
    layer.path = path;
    layer.lineWidth = .5;
    layer.strokeColor = [UIColor colorWithRed:87/255.0 green:139/255.0 blue:199/255.0 alpha:1].CGColor;
    [self.layer addSublayer:layer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.additive = YES;
    animation.fromValue = @(90 + 60);
    animation.toValue = @(self.frame.size.width);
    animation.duration = 2.5;
    animation.removedOnCompletion = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    [layer addAnimation:animation forKey:@"layerAnimation"];
    
    CAShapeLayer *leftLayer = [CAShapeLayer layer];
    leftLayer.position = center;
    leftLayer.path = path;
    leftLayer.lineWidth = .5;
    leftLayer.strokeColor = [UIColor colorWithRed:87/255.0 green:139/255.0 blue:199/255.0 alpha:1].CGColor;
    [self.layer addSublayer:leftLayer];
    
    CABasicAnimation *leftAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    leftAnimation.additive = YES;
    leftAnimation.fromValue = @(90);
    leftAnimation.toValue = @(0);
    leftAnimation.duration = 2.5;
    leftAnimation.removedOnCompletion = YES;
    leftAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    leftAnimation.delegate = self;
    [leftLayer addAnimation:leftAnimation forKey:@"leftLayerAnimation"];

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        for (id layer in self.layer.sublayers) {
            if ([layer isKindOfClass:[CAShapeLayer class]]) {
                [layer removeFromSuperlayer];
                break;
            }
        }
    }
}

- (NSTimer *)waveTimer
{
    if (_waveTimer == nil) {
        _waveTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(clockUpdate) userInfo:nil repeats:YES];
    }
    return _waveTimer;
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(MaxW / 2 - 30, 0, 60, MaxH)];
        _label.font = [UIFont systemFontOfSize:12];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor lightGrayColor];
        _label.text = @"00:00";
    }
    return _label;
}

@end
