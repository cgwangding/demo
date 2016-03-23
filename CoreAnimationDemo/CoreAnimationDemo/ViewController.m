//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by AD-iOS on 15/6/24.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import "ViewController.h"
#import "AnimationLayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CABasicAnimation *theAnimation1 = [CABasicAnimation animation];
    theAnimation1.duration = 3.0;
    theAnimation1.repeatCount = HUGE_VALF;
    theAnimation1.autoreverses = YES;

    UIView *view = [[UIView alloc]initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor grayColor];
    view.layer.position = CGPointMake(0.5, 0.5);
    view.layer.transform = CATransform3DMakeRotation(90, 180, 90, 90);
    [view.layer addAnimation:theAnimation1 forKey:@"aff"];
    
    
    CATransition *ani = [[CATransition alloc]init];
    ani.duration = 1;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ani.type = kCATransitionPush;
    ani.subtype = kCATransitionFromRight;
    
    [self.view.layer addAnimation:ani forKey:@"transition"];
    
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)subView;
            [button addTarget:self action:@selector(customPushAnimation) forControlEvents:UIControlEventTouchUpInside];
        }
    }

    

    
    
    
//    CALayer *layer = [[CALayer alloc]init];
//    layer.backgroundColor = [UIColor greenColor].CGColor;
//    [layer addAnimation:g forKey:@"ll"];

    UITapGestureRecognizer *push = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(push)];
    [self.view addGestureRecognizer:push];
}

- (void)push{
    UIViewController *testController = [[UIViewController alloc]init];
    testController.view.backgroundColor = [UIColor greenColor];
    [self.navigationController pushViewController:testController animated:YES];
}

- (void)customPushAnimation
{
    CATransition *ani = [[CATransition alloc]init];
    ani.duration = 1;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ani.type = kCATransitionPush;
    ani.subtype = kCATransitionFromRight;
    
    UIViewController *testController = [[UIViewController alloc]init];
    testController.view.backgroundColor = [UIColor greenColor];
    [testController.view.layer addAnimation:ani forKey:@"afdaf"];
    [self.navigationController pushViewController:testController animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
