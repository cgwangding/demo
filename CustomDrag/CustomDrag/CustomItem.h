//
//  CustomItem.h
//  CustomDrag
//
//  Created by AD-iOS on 15/9/17.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomItem;
@protocol CustomItemDelegate <NSObject>

@optional

- (void)customItem:(CustomItem*)customItem didClickedDeleteButton:(UIButton*)deleteButton;

@end


@interface CustomItem : UIButton

@property (nonatomic, weak) id<CustomItemDelegate>delegate;

/**
 *  不需要主动设置该状态
 */
@property (nonatomic, assign) BOOL showingDeleteState;
/**
 *  use this property to keep relationship with some info 
 */
@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic, strong) UIButton *deleteButton;

//使用下面两个方法使button进入编辑状态
- (void)visibleDeleteButton;
- (void)invisibleDeleteButton;

@end
