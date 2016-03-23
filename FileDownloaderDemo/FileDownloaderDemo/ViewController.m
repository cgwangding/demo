//
//  ViewController.m
//  FileDownloaderDemo
//
//  Created by AD-iOS on 15/10/15.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WDFileDownloaderManager.h"

@interface ViewController ()

@property (copy,nonatomic) NSMutableArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.http://pan.baidu.com/share/link?shareid=1604939913&uk=2337020227
//        [[WDFileDownloaderManager manager]downloadWithURL:[NSURL URLWithString:@"http://pan.baidu.com/share/link?shareid=1604939913&uk=2337020227"]];
    self.array = [NSMutableArray arrayWithArray:@[@"1"]];
    [self.array addObject:@"3"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //

}

@end
