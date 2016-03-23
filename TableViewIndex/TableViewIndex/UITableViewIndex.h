//
//  UITableView+IndexView.h
//  TableViewIndex
//
//  Created by AD-iOS on 15/9/10.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UITableViewIndexViewDelegate;

@interface UITableViewIndexView : UIView

@property (nonatomic, weak) id<UITableViewIndexViewDelegate>delegate;

/**
 *  主要用于设置索引的上下间隔，一般情况下不要设置左右
 */
@property (assign, nonatomic) UIEdgeInsets indexViewInset;

@end


@protocol UITableviewIndexDataSource;
@interface UITableViewIndex:UITableView

/**
 *  如果需要使用索引列表必须实现这个数据源代理
 */
@property (weak, nonatomic) id<UITableviewIndexDataSource>indexDataSource;



/**
 *  索引的背景颜色，默认和UITableView的背景颜色相同
 */
@property (nonatomic, strong) UIColor *indexBackgroundColor;

/**
 *  索引的文字颜色，默认黑色
 */
@property (nonatomic, strong) UIColor *indexTextColor;

/**
 *  索引的字体，默认12
 */
@property (nonatomic, strong) UIFont *indexFont;

- (void)setUpIndexViewWithFrame:(CGRect)frame superView:(UIView*)view;

@end

/**
 *  如果需要使用索引列表必须实现这个数据源代理
 */
@protocol UITableviewIndexDataSource <NSObject>

@optional
/**
 * 索引的数据源
 *
 *  @param tableView tableView
 *
 *  @return 索引数组
 */
- (NSArray*)tableViewSectionIndexs:(UITableView*)tableView;

//- (NSInteger)tableView:(UITableView*)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;

@end

@protocol UITableViewIndexViewDelegate <NSObject>

/**
 *  触摸到索引时触发
 *
 *  @param tableViewIndex 触发didSelectSectionAtIndex对象
 *  @param index          索引下标
 *  @param title          索引文字
 */
- (void)tableViewIndex:(UITableViewIndexView *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title;

/**
 *  开始触摸索引
 *
 *  @param tableViewIndex 触发tableViewIndexTouchesBegan对象
 */
- (void)tableViewIndexTouchesBegan:(UITableViewIndexView *)tableViewIndex;
/**
 *  触摸索引结束
 *
 *  @param tableViewIndex
 */
- (void)tableViewIndexTouchesEnd:(UITableViewIndexView *)tableViewIndex;

/**
 *  TableView中右边右边索引title
 *
 *  @param tableViewIndex 触发tableViewIndexTitle对象
 *
 *  @return 索引title数组
 */
- (NSArray *)tableViewIndexTitle:(UITableViewIndexView *)tableViewIndex;

@end
