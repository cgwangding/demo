//
//  ViewController.m
//  CustomCalandar
//
//  Created by AD-iOS on 15/12/17.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "ViewController.h"
#import "CustomCalandarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CustomCalandarView *calandarView = [[CustomCalandarView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:calandarView];
    
    NSDateComponents *fromComp = [[NSDateComponents alloc]init];
    fromComp.year = 2015;
    fromComp.month = 12;
    fromComp.day = 11;
    
    NSDateComponents *toComp = [[NSDateComponents alloc]init];
    toComp.year = 2016;
    toComp.month = 1;
    toComp.day =12;
    [calandarView validDateFormDateComponents:fromComp toDateComponents:toComp];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
