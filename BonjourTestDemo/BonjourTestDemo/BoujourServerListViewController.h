//
//  BoujourServerListViewController.h
//  BonjourTestDemo
//
//  Created by AD-iOS on 16/2/23.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoujourServerListViewController : UIViewController

// properties you must set before starting and must not change while started

@property (nonatomic, copy,   readwrite) NSString *             type;


// properties you can set at any time

@property (nonatomic, strong, readwrite) NSNetService *         localService;

- (void)startSearchServices;
- (void)stopSearchServices;

@end
