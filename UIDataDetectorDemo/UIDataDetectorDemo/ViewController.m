//
//  ViewController.m
//  UIDataDetectorDemo
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
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, 280, 200)];
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    textView.font = [UIFont systemFontOfSize:20];
    textView.editable = NO;
    textView.text = @"My phone number is +8602980000000.\r\n"
    "My personal web site www.xxxxxx.com.\r\n"
    "My E-mail address is XXXXX@gmail.com.\r\n"
    "I was born in 1900-01-01.";
    [self.view addSubview:textView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
