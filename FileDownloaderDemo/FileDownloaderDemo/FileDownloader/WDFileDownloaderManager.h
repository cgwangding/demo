//
//  WDFileDownloaderManager.h
//  FileDownloaderDemo
//
//  Created by AD-iOS on 15/10/15.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDFileDownloaderManager : NSObject

+ (instancetype)manager;

- (void)downloadWithURL:(NSURL*)url;

@end
