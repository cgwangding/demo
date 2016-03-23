//
//  StarLevelView.m
//  DuoLiFarm
//
//  Created by AD-iOS on 15/5/21.
//  Copyright (c) 2015年 wangding. All rights reserved.
//

#import "StarLevelView.h"

@interface StarLevelView ()

//未选中状态的图片
@property (nonatomic, strong) UIImage *image;
//选中状态的图片
@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, assign) NSInteger totalStars;
@property (nonatomic, assign) CGSize starSize;

@property (nonatomic, assign) NSInteger oldStarDistance;

@property (nonatomic, retain) NSMutableArray *muItemArray;


@end

@implementation StarLevelView

- (NSMutableArray *)muItemArray
{
    if(_muItemArray == nil){
        _muItemArray = [NSMutableArray array];
    }
    return _muItemArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(id)initWithStarsNumber:(NSInteger)stars image:(UIImage *)image selectedImage:(UIImage *)selectedImage starSize:(CGSize)size
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 30, size.width * stars, size.height);
        self.userInteractionEnabled = YES;
        self.totalStars = stars;
        self.image = image;
        self.selectedImage = selectedImage;
        self.starSize = size;
        self.starsDistance = 0;
        self.oldStarDistance = 0;
        [self buildStars];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

- (void)buildStars
{
    for (int i = 0; i < self.totalStars; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i > 0 ) {
            [button setFrame:CGRectMake(self.starSize.width * i + self.starsDistance, 0, self.starSize.width, self.starSize.height)];
        }else{
            [button setFrame:CGRectMake(0, 0, self.starSize.width, self.starSize.height)];
        }
        
        [button setImage:self.image forState:UIControlStateNormal];
        [button setImage:self.selectedImage forState:UIControlStateSelected];
        [ button setTag:100 + i ];
        [button setShowsTouchWhenHighlighted:YES];
        [button addTarget:self action:@selector(starButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (![self.muItemArray containsObject:button]) {
            [self.muItemArray addObject:button];
        }
    }
}

-(void)setStarsDistance:(CGFloat)starsDistance
{
    if (_starsDistance != starsDistance) {
        self.oldStarDistance = _starsDistance;
        _starsDistance = starsDistance;
    }
}

-(void)setSelectedStars:(NSInteger)selectedStars
{
    if (_selectedStars != selectedStars) {
        _selectedStars  = selectedStars;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (int i = 0; i < self.totalStars; i++) {
        UIButton *starButton = (UIButton*)[self viewWithTag:100 + i];
        if (i > 0) {
            UIButton *preButton = (UIButton*)[self viewWithTag:starButton.tag - 1];
            CGRect frame = starButton.frame;
            frame.origin.x = self.starsDistance + CGRectGetMaxX(preButton.frame);
            starButton.frame = frame;
        }
    }
    
}

- (void)starButtonClicked:(UIButton*)button
{
    button.selected = !button.selected;
    
    self.selectedStars = button.tag - 100 + 1;
    if (button.selected == NO && self.selectedStars == 1) {
        self.selectedStars = 0;
    }
    for (UIButton *item in self.muItemArray) {
        if (self.selectedStars == 0) {
            item.selected = NO;
            continue;
        }
        if (item.tag <= button.tag) {
            item.selected = YES;
        }else{
            item.selected = NO;
        }
    }
}

@end
