//
//  UIImage+HeaderMontage.h
//  CompetitionApply
//
//  Created by AD-iOS on 15/8/26.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HeaderMontage)

+ (UIImage*)makeHeaderWithArray:(NSArray*)array;

/**
 *  图片拼接
 *
 *  @param array       <#array description#>
 *  @param compeleting <#compeleting description#>
 *  @param failed      <#failed description#>
 */
+ (void)makeHeaderWithURLArray:(NSArray*)array compeletionHander:(void(^)(UIImage *image))compeleting failed:(void(^)(NSError*error))failed;

@end
