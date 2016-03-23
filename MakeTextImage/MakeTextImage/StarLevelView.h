//
//  StarLevelView.h
//  DuoLiFarm
//
//  Created by AD-iOS on 15/5/21.
//  Copyright (c) 2015年 wangding. All rights reserved.
//

//you must need set the frame for starlevelview after initialize

#import <UIKit/UIKit.h>

@interface StarLevelView : UIView

//已经选中的星星的个数
@property (nonatomic, assign, readonly) NSInteger selectedStars;

//星星之间的间隔
@property (nonatomic, assign) CGFloat starsDistance;


- (id)initWithStarsNumber:(NSInteger)stars image:(UIImage*)image selectedImage:(UIImage*)selectedImage starSize:(CGSize)size;

@end
