//
//  UITableView+IndexView.m
//  TableViewIndex
//
//  Created by AD-iOS on 15/9/10.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import "UITableViewIndex.h"
#import <objc/runtime.h>

@interface UITableViewIndexView ()

@property (strong, nonatomic) NSArray *letters;

@property (assign, nonatomic) CGFloat letterHeight;

@property (assign, nonatomic) BOOL isNeedLayout;

@property (strong, nonatomic) CAShapeLayer *shapeLayer;

@property (strong, nonatomic) UIFont *font;

@end

@implementation UITableViewIndexView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        if (frame.size.height > 480) {
            self.font = [UIFont systemFontOfSize:12];
        }else{
            self.font = [UIFont systemFontOfSize:11];
        }
        self.letterHeight = frame.size.height / self.letters.count > 0?self.letters.count:1;
    }
    return self;
}

- (void)setup{
    if (_shapeLayer == nil) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.lineWidth = 1.0f;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.lineJoin = kCALineCapSquare;
        _shapeLayer.strokeColor = [[UIColor clearColor] CGColor];
        _shapeLayer.strokeEnd = 1.0f;
        self.layer.masksToBounds = NO;
    }
}

- (void)setDelegate:(id<UITableViewIndexViewDelegate>)delegate
{
    _delegate = delegate;
    self.letters = [self.delegate tableViewIndexTitle:self];
    self.isNeedLayout = NO;
    [self setNeedsLayout];
}

- (void)setIndexViewInset:(UIEdgeInsets)indexViewInset
{
    _indexViewInset = indexViewInset;
   
    CGRect rect = self.frame;
    rect.size.height  = [self superview].frame.size.height - indexViewInset.top - indexViewInset.bottom;
    rect.origin.y = indexViewInset.top;
    self.frame = rect;
    
     self.letterHeight = rect.size.height / self.letters.count;
    self.isNeedLayout = NO;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!self.isNeedLayout){
         [self setup];
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        
        _shapeLayer.frame = (CGRect) {.origin = CGPointZero, .size = self.layer.frame.size};
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointZero];
        [bezierPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
//        self.letterHeight  = self.frame.size.height / self.letters.count;
        [self.letters enumerateObjectsUsingBlock:^(NSString *letter, NSUInteger idx, BOOL *stop) {
            CGFloat originY = idx * self.letterHeight;
            CATextLayer *ctl = [self textLayerWithFont:self.font
                                                string:letter
                                              andFrame:CGRectMake(0, originY, self.frame.size.width, self.letterHeight)];
            [self.layer addSublayer:ctl];
            [bezierPath moveToPoint:CGPointMake(0, originY)];
            [bezierPath addLineToPoint:CGPointMake(ctl.frame.size.width, originY)];
        }];
        
        _shapeLayer.path = bezierPath.CGPath;
        [self.layer addSublayer:_shapeLayer];
        
        self.isNeedLayout = YES;
    }
}

- (CATextLayer*)textLayerWithFont:(UIFont*)font string:(NSString*)string andFrame:(CGRect)frame{
    CATextLayer *textLayer = [CATextLayer layer];
    UIFontDescriptor *fontDescriptor = [font fontDescriptor];
    NSDictionary *fontAttr = [fontDescriptor fontAttributes];
    textLayer.font = (__bridge CFTypeRef)(fontAttr[UIFontDescriptorNameAttribute]);
    textLayer.fontSize = [fontAttr[UIFontDescriptorSizeAttribute] doubleValue];
    [textLayer setFrame:frame];
    [textLayer setAlignmentMode:kCAAlignmentCenter];
    [textLayer setContentsScale:[[UIScreen mainScreen] scale]];
    [textLayer setForegroundColor:[[UIColor orangeColor] colorWithAlphaComponent:0.35].CGColor];
    [textLayer setString:string];
    return textLayer;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self sendEventToDelegate:event];
    [self.delegate tableViewIndexTouchesBegan:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    [self sendEventToDelegate:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate tableViewIndexTouchesEnd:self];
}

- (void)sendEventToDelegate:(UIEvent*)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    
    NSInteger indx = ((NSInteger) floorf(point.y) / self.letterHeight);
    
    if (indx< 0 || indx > self.letters.count - 1) {
        return;
    }
    
    [self.delegate tableViewIndex:self didSelectSectionAtIndex:indx withTitle:self.letters[indx]];
}

@end


static const NSString *indexBackgroundColorKey = @"indexBackgroundColorKey";
static const NSString *indexTextColorKey = @"indexTextColorKey";
static const NSString *indexTextFontKey = @"indexTextFontKey";
static const NSString *indexDelegateKey = @"indexDelegateKey";

static const NSString *indexViewKey = @"indexViewKey";
static const NSString *flotageLabelKey = @"flotageLabelKey";

@interface UITableViewIndex ()<UITableViewIndexViewDelegate>

@property (nonatomic, strong) UILabel * flotageLabel;
@property (nonatomic, strong) UITableViewIndexView * IndexView;

@end

@implementation UITableViewIndex

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self setUpIndexViewWithFrame:frame superView:self.superview];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setUpIndexViewWithFrame:(CGRect)frame superView:(UIView *)view
{
    if (self.flotageLabel == nil) {
        self.flotageLabel = [[UILabel alloc] initWithFrame:(CGRect){(frame.size.width - 64 ) / 2,(frame.size.height - 64) / 2,64,64}];
        self.flotageLabel.backgroundColor = [[UIColor darkTextColor] colorWithAlphaComponent:0.1];
        self.flotageLabel.textColor = [UIColor whiteColor];
        self.flotageLabel.hidden = NO;
        self.flotageLabel.textAlignment = NSTextAlignmentCenter;
    }
    [self.flotageLabel removeFromSuperview];
    [view addSubview:self.flotageLabel];
    
    
    if (self.IndexView == nil) {
        self.IndexView = [[UITableViewIndexView alloc] initWithFrame:(CGRect){frame.size.width - 20,0,20,frame.size.height}];
//        self.IndexView.backgroundColor = [UIColor redColor];
        self.IndexView.delegate = self;
    }
    [self.IndexView removeFromSuperview];
    [view addSubview:self.IndexView];
}

- (void)hideFlotage {
    self.flotageLabel.hidden = YES;
}

#pragma mark - UITableViewIndexViewDelegate

- (NSArray *)tableViewIndexTitle:(UITableViewIndexView *)tableViewIndex
{
    return [self.indexDataSource tableViewSectionIndexs:self];
}

- (void)tableViewIndexTouchesEnd:(UITableViewIndexView *)tableViewIndex
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [self.flotageLabel.layer addAnimation:animation forKey:nil];
    
    self.flotageLabel.hidden = YES;
}

- (void)tableViewIndexTouchesBegan:(UITableViewIndexView *)tableViewIndex
{
 self.flotageLabel.hidden = NO;
}

- (void)tableViewIndex:(UITableViewIndexView *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title
{
//    if (index > -1){   // for safety, should always be YES
//        NSInteger realIndex = [self.indexDataSource tableView:self sectionForSectionIndexTitle:title atIndex:index];
//        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:realIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//        self.flotageLabel.text = title;
//    }
}

#pragma mark - setter and getter

- (void)setIndexDataSource:(id<UITableviewIndexDataSource>)indexDataSource
{
    _indexDataSource = indexDataSource;
    [self reloadData];
}


@end
