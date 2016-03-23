//
//  CustomDragView.m
//  CustomDrag
//
//  Created by AD-iOS on 15/9/17.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "CustomDragView.h"

@interface CustomDragView ()<UIGestureRecognizerDelegate>

@property (assign, nonatomic) BOOL canDrag;

@property (strong, nonatomic) UITapGestureRecognizer *tagGesture;

@property (strong, nonatomic) UILongPressGestureRecognizer *dragLongPress;

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

//当前点中的在移动的视图
@property (strong, nonatomic) UIView *currentTouchedItem;
//当前移动视图的原frame
@property (assign, nonatomic) CGRect currentTouchedItemOriginalFrame;


//最后需要移动的视图
@property (strong, nonatomic) UIView *finalMovedItem;

//当前已经移动了的item的frmae
@property (assign, nonatomic) CGRect currentMovedItemFrame;


@property (strong, nonatomic) NSMutableArray *muItemsArr;

@property (assign, nonatomic) BOOL isEditingMode;

@end

@implementation CustomDragView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat dashPattern[]= {3.0, 2};
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIView *item in self.muItemsArr) {
        CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
        CGContextSetLineWidth(context, 1.0);
        CGContextSetLineDash(context, 0.0, dashPattern, 2);
        CGContextAddRect(context, item.frame);
        CGContextStrokePath(context);
    }
    
}


- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self.muItemsArr addObjectsFromArray:items];
        
        //初始化
        self.itemSpacing = 10.0f;
        self.lineSpacing = 20.0f;
        self.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 0, 10);
        self.lineOfItemCount =5;
        self.itemSize  = CGSizeMake(( CGRectGetWidth(self.frame) - (self.lineOfItemCount - 1) * self.itemSpacing - self.contentEdgeInsets.left - self.contentEdgeInsets.right) / self.lineOfItemCount ,( CGRectGetWidth(self.frame) - (self.lineOfItemCount - 1) * self.itemSpacing - self.contentEdgeInsets.left - self.contentEdgeInsets.right) / self.lineOfItemCount);
        [self addGestureRecognizer:self.dragLongPress];
        [self addGestureRecognizer:self.panGesture];
        [self addGestureRecognizer:self.tagGesture];
        
        [self buildUI];
    }
    return self;
}

- (void)buildUI
{
    //布局界面
    NSInteger row = self.muItemsArr.count % self.lineOfItemCount;
    if (row == 0) {
        row = self.muItemsArr.count / self.lineOfItemCount;
    }else{
        row = self.muItemsArr.count / self.lineOfItemCount + 1;
    }
    BOOL shouldShowDeleteState = NO;
    for (int i = 0; i < row ; i ++) {
        for (int j = 0; j < self.lineOfItemCount ; j++) {
            if (i * self.lineOfItemCount + j == self.muItemsArr.count) {
                break;
            }
            UIView *item = self.muItemsArr[i * self.lineOfItemCount + j];
            
            [item setFrame:CGRectMake((self.itemSpacing + self.itemSize.width) * j + self.contentEdgeInsets.left, (self.lineSpacing + self.itemSize.height) * i + self.contentEdgeInsets.top, self.itemSize.width, self.itemSize.height)];
            
            if ([item isKindOfClass:[CustomItem class]]) {
                CustomItem *cusItem = (CustomItem*)item;
                [cusItem addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                if (i == 0 && j == 0) {
                    if (cusItem.showingDeleteState == YES) {
                        shouldShowDeleteState = YES;
                    }
                }
                if (shouldShowDeleteState == YES) {
                    [cusItem visibleDeleteButton];
                }
            }
            
            [item setNeedsLayout];
            [self addSubview:item];
        }
    }
}

#pragma mark - Public method 

- (void)endDeleting
{
    for (CustomItem *item in self.muItemsArr) {
        [item invisibleDeleteButton];
    }
    self.canDrag = NO;
}

- (void)reloadData
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self buildUI];
    [self setNeedsDisplay];
}


#pragma mark - button action

- (void)buttonClicked:(CustomItem*)item
{
    if (item.showingDeleteState == YES) {
        [self.muItemsArr removeObject:item];
        NSLog(@"删除了>>>%@",item.currentTitle);
        [self reloadData];
    }
    if ([self.delegate respondsToSelector:@selector(customDragView:didClickedItem:withItemState:)]) {
        [self.delegate customDragView:self didClickedItem:item withItemState:item.showingDeleteState];
    }
}

#pragma mark - core method for move the item
/**
 *  核心方法，用于实现item的移动
 */
- (void)move
{
    //获取到最后移动的那个位置
    NSInteger finalIndex = [self.muItemsArr indexOfObject:self.finalMovedItem];
    //获取到当前选中的那个位置
    NSInteger orignalIndex = [self.muItemsArr indexOfObject:self.currentTouchedItem];
    if (finalIndex > self.muItemsArr.count-1 || orignalIndex > self.muItemsArr.count-1 || finalIndex < 0 || orignalIndex < 0) {
        NSLog(@"当前位置不合法");
        return;
    }
    if (finalIndex < orignalIndex) {
        NSLog(@"反向");
        //反向遍历
        NSInteger tempIndex = orignalIndex;
        while (tempIndex > finalIndex) {
            tempIndex--;
            NSMutableArray *tempItemsArr = [self.muItemsArr mutableCopy];
            UIView *view = tempItemsArr[tempIndex];
            //移动前保存他的frame
            self.currentMovedItemFrame = view.frame;
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                //改变他的frame
                view.frame = self.currentTouchedItemOriginalFrame;
            } completion:nil];
            
            //将当前放大的item的原位置记录改变为当前移动过的位置，方便下一个item的改变，且当移动完成后，改frame就为当前放大的item的目标位置
            self.currentTouchedItemOriginalFrame = self.currentMovedItemFrame;
            //改变item的位置
            [self.muItemsArr exchangeObjectAtIndex:tempIndex+1 withObjectAtIndex:tempIndex];
        }
    }else{
        //正向遍历
        NSLog(@"正向");
        NSInteger tempIndex = orignalIndex;
        while (tempIndex < finalIndex) {
            tempIndex++;
            UIView *view = self.muItemsArr[tempIndex];
            //移动前保存他的frame
            self.currentMovedItemFrame = view.frame;
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                //改变他的frame
                view.frame = self.currentTouchedItemOriginalFrame;
            } completion:nil];
            //
            self.currentTouchedItemOriginalFrame = self.currentMovedItemFrame;
            //改变item的位置
            [self.muItemsArr exchangeObjectAtIndex:tempIndex-1 withObjectAtIndex:tempIndex];
        }
    }
    self.finalMovedItem = nil;

}

#pragma mark - 

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"gestureRecognizerShouldBegin");
    if (self.canDrag) {
        if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
            return NO;
        }else{
            return YES;
        }
    }else{
        if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
            return YES;
        }else{
            return NO;
        }
    }
}


#pragma mark - Gesture action

- (void)gestureRecognizerAction:(UIGestureRecognizer*)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.canDrag = YES;
            [self disableAllItem];
            CGPoint point = [gesture locationInView:self];
            self.currentTouchedItem = [self findItemWithTouch:point];
            self.currentTouchedItemOriginalFrame = self.currentTouchedItem.frame;
            self.currentTouchedItem.center = point;
            [self enlargeItem:self.currentTouchedItem];
            [self bringSubviewToFront:self.currentTouchedItem];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self identityItem:self.currentTouchedItem];
        }
            break;
        case UIGestureRecognizerStateFailed:
        {
            [self identityItem:self.currentTouchedItem];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            //移动当前的
            CGPoint movePoint = [gesture locationInView:self];
            self.currentTouchedItem.center = movePoint;
            self.finalMovedItem = [self findItemWithTouch:movePoint];
            if (self.finalMovedItem) {
                [self move];
            }
            
            
        }
            break;
        case UIGestureRecognizerStatePossible:
        {
            
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            [self identityItem:self.currentTouchedItem];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - helper

- (void)disableAllItem
{
    for (UIView *item in self.muItemsArr) {
//        item.userInteractionEnabled = NO;
        if ([item isKindOfClass:[CustomItem class]]) {
            CustomItem *cusItem = (CustomItem*)item;
            [cusItem visibleDeleteButton];
            self.isEditingMode = YES;
        }
    }
}

- (void)enablAllItem
{
        self.isEditingMode = NO;
}


- (UIView*)findItemWithTouch:(CGPoint)point
{
    for (UIView *view  in self.muItemsArr) {
        if (CGRectContainsPoint(view.frame, point) && ![view isEqual:self.currentTouchedItem]) {
            return view;
        }
    }
    return nil;
}

- (void)enlargeItem:(UIView*)item
{
    item.transform = CGAffineTransformMakeScale(1.2, 1.2);
}

- (void)identityItem:(UIView*)item
{
    item.transform = CGAffineTransformIdentity;
    self.currentTouchedItem.frame = self.currentTouchedItemOriginalFrame;
    self.currentTouchedItem = nil;
    [self enablAllItem];
    [item setNeedsLayout];
}

#pragma mark - gettter

- (UILongPressGestureRecognizer *)dragLongPress
{
    if (_dragLongPress == nil) {
        _dragLongPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(gestureRecognizerAction:)];
        _dragLongPress.minimumPressDuration = 1;
        _dragLongPress.allowableMovement = 0;
        _dragLongPress.delegate = self;
    }
    return _dragLongPress;
}

- (UIPanGestureRecognizer *)panGesture
{
 
    if (_panGesture == nil) {
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gestureRecognizerAction:)];
        _panGesture.delegate = self;
    }
    return _panGesture;
}

- (NSMutableArray *)muItemsArr
{
    if (_muItemsArr == nil) {
        _muItemsArr = [NSMutableArray array];
    }
    return _muItemsArr;
}

- (void)setItems:(NSArray *)items
{
    [self.muItemsArr removeAllObjects];
    [self.muItemsArr addObjectsFromArray:items];
}

- (NSArray *)items
{
    return [NSArray arrayWithArray:self.muItemsArr];
}

- (UITapGestureRecognizer *)tagGesture
{
    if (_tagGesture == nil) {
        _tagGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endDeleting)];
        
    }
    return _tagGesture;
}

@end
