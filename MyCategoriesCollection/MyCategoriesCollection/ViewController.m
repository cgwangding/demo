//
//  ViewController.m
//  MyCategoriesCollection
//
//  Created by AD-iOS on 16/3/9.
//  Copyright © 2016年 DW. All rights reserved.
//

#import "ViewController.h"
#import "NSString+AES.h"
#import "UIImage+QRCode.h"
#import "UIImage+ColorCircle.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
////    NSString *encrypt = [NSString AES128Encrypt:@"wangding"];
////    NSLog(@"encrypt = %@",encrypt);
////    NSString *decrypt = [NSString AES128Decrypt:encrypt];
////    NSLog(@"decrypt = %@",decrypt);
//
//    NSString *original = @"12345";
//    NSString *key = @"123456";
//    
//    NSString *en = [original AES256EncryptWithKey:key withECBMode:YES];
//    NSLog(@"encrypt = %@",en);
//    NSString *de = [en AES256DecryptWithKey:key withECBMode:YES];
//    NSLog(@"decrypt = %@",de);
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 200, 200)];
//    imageView.image = [UIImage createQRCodeWithString:@"http://www.baidu.com" size:CGSizeMake(200, 200) withIconImage:[UIImage imageNamed:@"qq"] iconSize:CGSizeMake(40, 40)] ;
//    imageView.image = [UIImage createQRCodeWithString:@"http://www.baidu.com" size:CGSizeMake(200, 200) color:[UIColor redColor] withIconImage:[UIImage imageNamed:@"qq"] iconSize:CGSizeMake(40, 40)];
    
    imageView.image = [[UIImage imageNamed:@"qq"] imageWithInsideCircleColor:[UIColor redColor] outSideCircleColor:[UIColor greenColor] andSize:CGSizeMake(100, 100)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView];
    
//    UIImageView *centerImg = [[UIImageView alloc]initWithFrame:CGRectMake(100 - 20, 100 - 20 , 40, 40)];
//    centerImg.backgroundColor = [UIColor redColor];
//    [imageView addSubview:centerImg];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
