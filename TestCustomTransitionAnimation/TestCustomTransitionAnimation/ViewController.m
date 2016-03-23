//
//  ViewController.m
//  TestCustomTransitionAnimation
//
//  Created by AD-iOS on 16/2/15.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"
#import "HalfWaySpringAnimator.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) MenuViewController *presentController;

- (IBAction)buttonClicked:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [HalfWaySpringAnimator new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [HalfWaySpringAnimator new];
}
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
//{
//
//}
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
//{
//    
//}

- (IBAction)buttonClicked:(id)sender {
//    self.presentController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    self.presentController.modalPresentationStyle = UIModalPresentationCustom;
    self.presentController.transitioningDelegate = self;
    [self presentViewController:self.presentController animated:YES completion:nil];

}

- (MenuViewController *)presentController
{
    if (_presentController == nil) {
        _presentController = [[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
        _presentController.view.backgroundColor = [UIColor redColor];
    }
    return _presentController;
}
@end
