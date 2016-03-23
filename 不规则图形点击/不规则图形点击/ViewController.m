//
//  ViewController.m
//  不规则图形点击
//
//  Created by AD-iOS on 16/1/14.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "ViewController.h"
#import "UIView+EventHook.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)buttonAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.button.layer.cornerRadius = 50;
    self.button.layer.masksToBounds = YES;
//    [self.button setHookEnable:YES];
    [self.button setEnableIrregularTouch:YES enablePath:[UIBezierPath bezierPathWithOvalInRect:self.button.bounds]];
//    [self.button setIrregularPathBlock:^UIBezierPath *{
//       
//        return [UIBezierPath bezierPathWithOvalInRect:self.button.bounds];
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(id)sender {
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"点击了按钮" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//    [alertView show];
    NSLog(@"点中了圆形区域");
    
}
@end
