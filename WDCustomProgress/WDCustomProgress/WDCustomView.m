//
//  WDCustomView.m
//  WDCustomProgress
//
//  Created by AD-iOS on 16/1/15.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "WDCustomView.h"

@interface WDCustomView()

@property (strong, nonatomic) CAShapeLayer *progressLayer;

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) CGFloat currentStrokeEnd;

@end
@implementation WDCustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //        [self performSelector:@selector(buildUI) withObject:nil afterDelay:3];
        self.currentStrokeEnd = 0;
        [self buildUI];
        
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

- (void)buildUI
{
    [self.layer addSublayer:self.progressLayer];
    [self.timer fire];
    
    
    self.progressLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)].CGPath;
//    self.progressLayer.position = CGPointMake(160, 200);
    self.progressLayer.strokeColor = [UIColor redColor].CGColor;
    self.progressLayer.lineWidth = 4;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeStart = 0;
    self.progressLayer.strokeEnd = 1;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor orangeColor].CGColor,(id)[UIColor yellowColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor cyanColor].CGColor,(id)[UIColor blueColor].CGColor,(id)[UIColor purpleColor].CGColor];
//    gradientLayer.locations = @[@(0.3),@(0.35),@(0.4),@(0.45),@(0.5),@(0.55),@(0.6)];
//    gradientLayer.startPoint = CGPointMake(0.32, 0.6);
//    gradientLayer.endPoint = CGPointMake(0.8, 1);
    gradientLayer.mask = self.progressLayer;
    [self.layer addSublayer:gradientLayer];
}

- (void)timerFunction
{
    return;
    if (self.progressLayer.strokeEnd > 1 && self.progressLayer.strokeStart < 1) {
        self.progressLayer.strokeStart += 0.1;
    }else if(self.progressLayer.strokeStart == 0){
        if (self.progressLayer.strokeEnd > 0.85) {
            self.progressLayer.strokeEnd += 0.025;
        }else{
            self.progressLayer.strokeEnd += 0.1;
        }
    }
    
    if (self.progressLayer.strokeEnd == 0) {
        self.progressLayer.strokeStart = 0;
    }
    
    if (self.progressLayer.strokeStart >= self.progressLayer.strokeEnd) {
        self.progressLayer.strokeEnd = 0;
    }
}

- (UIColor*)randomColor
{
    int r = arc4random() % 256;
    int g = arc4random() % 256;
    int b = arc4random() % 256;
    
    return [UIColor colorWithRed:r/ 255.0 green:g/255.0 blue:b/255.0 alpha:1];
    
}

- (CAShapeLayer*)progressLayer
{
    if (_progressLayer == nil) {
        _progressLayer = [CAShapeLayer layer];
    }
    return _progressLayer;
}

- (NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timerFunction) userInfo:nil repeats:YES];
        
    }
    return _timer;
}
@end
