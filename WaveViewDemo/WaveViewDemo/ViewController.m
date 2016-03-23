//
//  ViewController.m
//  WaveViewDemo
//
//  Created by AD-iOS on 15/12/9.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "ViewController.h"
#import "RecordWaveView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RecordWaveView *view = [[RecordWaveView alloc]initWithFrame:CGRectMake(0, 100, 0, 0)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
