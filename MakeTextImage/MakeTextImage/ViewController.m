//
//  ViewController.m
//  MakeTextImage
//
//  Created by AD-iOS on 15/6/12.
//  Copyright (c) 2015年 wangding. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extension.h"
#import "StarLevelView.h"

#import "UIImage+HeaderMontage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    imgView.backgroundColor = [UIColor lightGrayColor];
    imgView.layer.cornerRadius = 25;
    imgView.layer.masksToBounds = YES;
    [self.view addSubview:imgView];
//    StarLevelView *levelView = [[StarLevelView alloc]initWithStarsNumber:5 image:[UIImage imageNamed:@"star2"] selectedImage:[UIImage imageNamed:@"star"] starSize:CGSizeMake(22, 22)];
//    [self.view addSubview:levelView];
//
    NSArray *arr = [NSArray arrayWithObjects:@"http://101.231.200.154:8004/image/2.jpg",@"http://101.231.200.154:8004/image/2.jpg", nil];
    UIImage *image = [UIImage makeHeaderWithURLArray:arr];
    [imgView setImage:image];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIImage *)addText:(UIImage *)img text:(NSString *)text1
{
    //上下文的大小
    int w = img.size.width;
    int h = img.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//创建颜色
    //创建上下文
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);//将img绘至context上下文中
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);//设置颜色
    char* text = (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Georgia", 30, kCGEncodingMacRoman);//设置字体的大小
    CGContextSetTextDrawingMode(context, kCGTextFill);//设置字体绘制方式
    CGContextSetRGBFillColor(context, 255, 0, 0, 1);//设置字体绘制的颜色
    CGContextShowTextAtPoint(context, w/2-strlen(text)*5, h/2, text, strlen(text));//设置字体绘制的位置
      //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);//创建CGImage
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];//获得添加水印后的图片
}
@end
