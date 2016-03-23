//
//  ViewController.m
//  CustomDrag
//
//  Created by AD-iOS on 15/9/17.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "ViewController.h"
#import "CustomDragView.h"

@interface ViewController ()<CustomItemDelegate,CustomDragViewDelegate>

@property (strong, nonatomic) CustomDragView *myDragView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0;i < 10 ; i ++ ) {
        CustomItem *item = [CustomItem buttonWithType:UIButtonTypeCustom];
        [item setTitle:[NSString stringWithFormat:@"%i",i] forState:UIControlStateNormal];
//        [item addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        item.delegate = self;
        [items addObject:item];
    }
    CustomDragView *view = [[CustomDragView alloc]initWithFrame:self.view.frame andItems:items];
    view.delegate = self;
    [self.view addSubview:view];
    self.myDragView = view;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:CGRectMake(0, 568 - 44, 320, 44)];
    [button setTitle:@"增加" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


//- (void)clicked:(UIButton*)button
//{
//    NSLog(@"%@",button.currentTitle);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)add:(UIButton*)button
{
    NSInteger currentInterger = 0;
    for (CustomItem *item in self.myDragView.items) {
        if ([item.currentTitle integerValue] > currentInterger) {
            currentInterger = [item.currentTitle integerValue];
        }
    }
    CustomItem *item = [CustomItem buttonWithType:UIButtonTypeCustom];
    [item setTitle:[NSString stringWithFormat:@"%u",currentInterger+1] forState:UIControlStateNormal];
    item.delegate = self;
    self.myDragView.items = [self.myDragView.items arrayByAddingObject:item];
    [self.myDragView reloadData];
}

- (void)customItem:(CustomItem *)customItem didClickedDeleteButton:(UIButton *)deleteButton
{
    NSLog(@"didClickedDeleteButton>>>%@",customItem.currentTitle);
}

- (void)customDragView:(CustomDragView *)dragView didClickedItem:(CustomItem *)item withItemState:(BOOL)isDeletingState
{
    if (isDeletingState == NO) {
        NSLog(@"%@",item.currentTitle);
    }
}

@end
