//
//  ViewController.m
//  RadarCircleWave
//
//  Created by AD-iOS on 15/12/4.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "ViewController.h"
#import "RadarCircleView.h"
#import <MediaPlayer/MPMoviePlayerViewController.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RadarCircleView *view = [[RadarCircleView alloc]initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];

     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
