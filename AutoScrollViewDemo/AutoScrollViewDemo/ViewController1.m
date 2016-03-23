//
//  ViewController1.m
//  AutoScrollViewDemo
//
//  Created by AD-iOS on 16/3/10.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "ViewController1.h"
#import "WDScrollView.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WDScrollView *scrollView = [[WDScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100) andLayout:WDScrollViewLayoutDefault];
    NSArray *imageURL = @[@"http://wenwen.soso.com/p/20091001/20091001123707-792857275.jpg"];
    NSMutableArray *muImageArr = [NSMutableArray array];
    for (NSString *str in imageURL) {
        NSURL *url = [NSURL URLWithString:str];
        [muImageArr addObject:url];
    }
    scrollView.imageArr = muImageArr;
    //    scrollView.titleArr = @[@"1",@"2",@"3",@"4"];
    scrollView.autoScrollTimeinterval = 2;
    [self.view addSubview:scrollView];
    //    scrollView.shouldAutoScoll = NO;
    
    WDScrollView *scrollView1 = [[WDScrollView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 100) andLayout:WDScrollViewLayoutDefault];
    NSArray *imageURL1 = @[@"http://wenwen.soso.com/p/20091001/20091001123707-792857275.jpg",@"http://wenwen.soso.com/p/20091001/20091001123707-792857275.jpg",@"http://wenwen.soso.com/p/20091001/20091001123707-792857275.jpg"];
    NSMutableArray *muImageArr1 = [NSMutableArray array];
    for (NSString *str in imageURL1) {
        NSURL *url = [NSURL URLWithString:str];
        [muImageArr1 addObject:url];
    }
    scrollView1.imageArr = muImageArr1;
    scrollView1.autoScrollTimeinterval = 1;
    [self.view addSubview:scrollView1];
    
 
    
    [scrollView1 addListenerWithCurrentIndexBlock:^(NSInteger currentIndex) {
        NSLog(@"ViewController1 scrollview1 = %ld",currentIndex);
    }];

    
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

@end
