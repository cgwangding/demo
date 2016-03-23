//
//  NSURL+MediaDuration.h
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/26.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (MediaDuration)

/**
 *  获取音频文件总时间长度
 *
 *  @param mediaDuation 音频文件获取时间后的回调block
 */
- (void)timeIntervalForMediaWithCompeletion:(void(^)(NSTimeInterval mediaDuation))mediaDuation;
@end
