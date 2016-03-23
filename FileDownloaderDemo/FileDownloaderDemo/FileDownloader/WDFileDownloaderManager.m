//
//  WDFileDownloaderManager.m
//  FileDownloaderDemo
//
//  Created by AD-iOS on 15/10/15.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "WDFileDownloaderManager.h"

@interface WDFileDownloaderManager ()<NSURLSessionDownloadDelegate>

@end

@implementation WDFileDownloaderManager

+(instancetype)manager
{
    static WDFileDownloaderManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WDFileDownloaderManager alloc]init];
    });
    return manager;
}

- (void)downloadWithURL:(NSURL*)url
{
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession]downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *fileError = nil;
        NSFileHandle *handle = [NSFileHandle fileHandleForReadingFromURL:location error:&error];
        NSLog(@"%@",error);
        NSData *data = [handle readDataToEndOfFile];
        
        NSLog(@"%@-%@",location,response.suggestedFilename);
    }];
    [downloadTask resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"%@",location);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"完成-%@",task.currentRequest);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
}

@end
