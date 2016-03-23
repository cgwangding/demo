//
//  ViewController.m
//  WDCustomProgress
//
//  Created by AD-iOS on 16/1/15.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "ViewController.h"
#import "WDCustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WDCustomView *custom = [[WDCustomView alloc]initWithFrame:self.view.bounds];
    custom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:custom];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
