//
//  ViewController.m
//  毛玻璃效果
//
//  Created by AD-iOS on 16/1/13.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"test.jpg"];
    [self.view addSubview:imageView];
    
    /**
     <#Description#>
     */
    UIVisualEffectView *visualEffect  = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    visualEffect.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300);
    visualEffect.alpha = 1;
    [self.view addSubview:visualEffect];
    
    UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc]initWithEffect:[UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]]];
    vibrancyView.frame = CGRectMake(0, 0, CGRectGetWidth(visualEffect.frame), 150);
    [visualEffect.contentView addSubview:vibrancyView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(vibrancyView.frame), 150)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"test test test";
    [vibrancyView.contentView addSubview:label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
