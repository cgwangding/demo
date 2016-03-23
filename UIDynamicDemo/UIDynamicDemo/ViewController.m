//
//  ViewController.m
//  UIDynamicDemo
//
//  Created by AD-iOS on 15/12/7.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "ViewController.h"
#import <SpriteKit/SpriteKit.h>

@interface ViewController ()

@property (strong, nonatomic) UIDynamicAnimator *dyAnimator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *ballView = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 80, 80)];
    ballView.layer.cornerRadius = 40;
    ballView.layer.masksToBounds = YES;
    ballView.transform = CGAffineTransformMakeRotation(M_PI_4);
    ballView.backgroundColor = [UIColor redColor];
    [self.view addSubview:ballView];
    
    
    UIView *barriView = [[UIView alloc]initWithFrame:CGRectMake(0, 300, 100, 100)];
    barriView.layer.cornerRadius = 50;
    barriView.layer.masksToBounds = YES;
    barriView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:barriView];
    
    UIDynamicAnimator *dyAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    self.dyAnimator = dyAnimator;
    
    //重力行为
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc]initWithItems:@[ballView]];
//    [gravityBehavior setAngle:M_PI_4 magnitude:0.5];
    
    //碰撞行为
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[ballView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:barriView.frame];
    [collisionBehavior addBoundaryWithIdentifier:@"barriView" forPath:circlePath];
    
    
    
    [dyAnimator addBehavior:gravityBehavior];
    [dyAnimator addBehavior:collisionBehavior];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
