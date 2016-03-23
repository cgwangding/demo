//
//  CustomDragView.h
//  CustomDrag
//
//  Created by AD-iOS on 15/9/17.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomItem.h"

@protocol CustomDragViewDelegate;

@interface CustomDragView : UIView

/**
 *  Init CustomDragView with frame and
 *
 *  @param frame frame of self
 *  @param items dataSource
 *
 *  @return instantiation object
 */
- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray*)items;

@property (nonatomic, weak) id<CustomDragViewDelegate>delegate;

/**
 * 数据源,当你需要改变数据源时，必须调用reloadData方法，直接改变数据源并不会有什么效果
 */
@property (nonatomic, strong) NSArray *items;

/**
 *  每行item的数量，默认5个
 */
@property (nonatomic, assign) NSInteger lineOfItemCount;

/**
 *  每个item的大小，默认自动计算
 */
@property (nonatomic, assign) CGSize itemSize;

/**
 *  两列item之间的距离，默认10.0f;
 */
@property (nonatomic, assign) CGFloat itemSpacing;

/**
 *  两行item 之间的距离 ， 默认20.0f;
 */
@property (nonatomic, assign) CGFloat lineSpacing;

/**
 *  布局item的content距离上下左右的距离，默认（10,10,0,10）
 */
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;

//当数据源更新时调用这个方法
- (void)reloadData;

//结束删除状态
- (void)endDeleting;

@end

@protocol CustomDragViewDelegate <NSObject>

@optional

/**
 *  当item上有点击操作时将会触发这个代理
 *
 *  @param dragView        当前的item的父视图
 *  @param item            当前触发点击事件的按钮
 *  @param isDeletingState 按钮所在的编辑状态，为NO时为普通状态，需要判断该状态分情况处理
 */
- (void)customDragView:(CustomDragView*)dragView didClickedItem:(CustomItem*)item withItemState:(BOOL)isDeletingState;



@end
