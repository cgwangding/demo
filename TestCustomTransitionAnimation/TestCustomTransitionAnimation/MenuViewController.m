//
//  MenuViewController.m
//  TestCustomTransitionAnimation
//
//  Created by AD-iOS on 16/2/15.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
- (IBAction)dismissClicked:(id)sender;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)dismissClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
