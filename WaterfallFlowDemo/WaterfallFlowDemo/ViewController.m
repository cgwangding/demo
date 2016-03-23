//
//  ViewController.m
//  WaterfallFlowDemo
//
//  Created by AD-iOS on 16/3/3.
//  Copyright © 2016年 DW. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"

static NSString *cellIdentifier = @"customCellidentifier";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *sizeArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    NSInteger width = (NSInteger)CGRectGetWidth(self.view.frame);
    NSMutableArray *muArr = [NSMutableArray array];
    for ( int i = 0; i < 100; i++) {
        CGFloat w = arc4random() % width;
        w = (width - 8 * 2) / 3;
        CGFloat h = arc4random() % width;
        if (h < 100) {
            h = 100;
        }
        CGSize size = CGSizeMake(w, h);
        [muArr addObject:[NSValue valueWithCGSize:size]];
    }
    self.sizeArr = [NSArray arrayWithArray:muArr];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [self randomColor];
    
    NSInteger remaider = indexPath.item % 3;
    NSInteger currentRow = indexPath.item / 3;

    
    CGFloat shouldPosition = (currentRow + 1) * 10;
    for (int i = 0; i < currentRow; i++) {
        NSInteger postion = remaider + i * 3;
        shouldPosition += [self.sizeArr[postion] CGSizeValue].height + 8;
    }
    CGRect frame = cell.frame;
    frame.origin.y = shouldPosition;
    cell.frame = frame;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSValue *sizeValue = [self.sizeArr objectAtIndex:indexPath.item];
    return [sizeValue CGSizeValue];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

- (UIColor*)randomColor
{
    int r = arc4random() % 256;
    int g = arc4random() % 256;
    int b = arc4random() % 256;
    return [UIColor colorWithRed:r/ 255.0 green:g/ 255.0 blue:b / 255.0 alpha:1.0];
}

@end
