//
//  ViewController.m
//  CALayerColockDemo
//
//  Created by AD-iOS on 15/7/6.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import "ViewController.h"
#import "ClockFace.h"

@interface ViewController ()<ClockFaceDelegate>
@property (nonatomic, strong) ClockFace *clock;
@property (nonatomic, strong) UILabel *hourLabel;
@property (nonatomic, strong) UILabel *minuteLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.clock = [[ClockFace alloc]init];
    self.clock.position = CGPointMake(self.view.bounds.size.width / 2, 150);
    self.clock.delegate = self;
    self.clock.time = [NSDate date];
    [self.view.layer addSublayer:self.clock];
    [self.clock setNeedsDisplay];
    
    self.hourLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, self.view.center.y, 20, 25)];
    self.hourLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.hourLabel];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.hourLabel.frame), self.view.center.y, 4, 25)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @":";
    [self.view addSubview:label1];
    
    self.minuteLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), self.view.center.y, 25, 25 )];
    self.minuteLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.minuteLabel];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.minuteLabel.frame), self.view.center.y, 4, 25)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @":";
    [self.view addSubview:label2];
    
    self.secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame), self.view.center.y, 25, 25)];
    self.secondLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.secondLabel];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 1.f;
    animation.fromValue = @1.0;
    animation.toValue = @0.0;
    [animation setCumulative:YES];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.repeatCount = HUGE_VALF;
    [label1.layer addAnimation:animation forKey:@"opacity1"];
    [label2.layer addAnimation:animation forKey:@"opacity2"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clockDidChangeTimeWithTimeInterval:(NSInteger)timeInterval
{
    NSInteger hour = timeInterval / 3600;
    NSInteger minute = (timeInterval - hour * 3600) / 60;
    NSInteger second = timeInterval - hour * 3600 - minute * 60;
    
    self.hourLabel.text = [NSString stringWithFormat:@"%lu",hour];
    self.minuteLabel.text = [NSString stringWithFormat:@"%lu",minute];
    self.secondLabel.text = [NSString stringWithFormat:@"%lu",second];
    
}

@end
