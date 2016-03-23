//
//  ViewController.m
//  TableViewIndex
//
//  Created by AD-iOS on 15/9/10.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import "ViewController.h"
#import "UITableViewIndex.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UITableviewIndexDataSource>

@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableViewIndex *tableVeiw = [[UITableViewIndex alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableVeiw.delegate = self;
    tableVeiw.dataSource = self;
    tableVeiw.indexDataSource = self;
//    tableVeiw.contentInset = UIEdgeInsetsMake(0, 0, 0, 20);

    [self.view addSubview:tableVeiw];
    self.dataSource = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"fafda";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"fsafsfa";
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.dataSource[section];
}

- (NSArray *)tableViewSectionIndexs:(UITableView *)tableView
{
    NSMutableArray *muArr = [NSMutableArray array];
    for (int i = 'A' ; i < 'Z' + 1; i++) {
        [muArr addObject:[NSString stringWithFormat:@"%c",i]];
    }
    return [NSArray arrayWithArray:muArr];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [self.dataSource indexOfObject:title];
}

@end
