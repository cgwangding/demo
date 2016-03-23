//
//  WDRecorder.m
//  RecorderDemo
//
//  Created by AD-iOS on 15/12/1.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "WDRecorder.h"
#import <AVFoundation/AVFoundation.h>

#define kRecorderFileName @"recorder.wav"

@interface WDRecorder ()<AVAudioRecorderDelegate>

@property (strong, nonatomic) AVAudioRecorder *audioRecorder;

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) NSTimeInterval recordTime;

@property (copy, nonatomic) AudioPowerListener listener;

@property (copy, nonatomic) RecordSucceed recordSucceed;

@property (copy, nonatomic) RecordFailed recordFailed;

@end

@implementation WDRecorder

- (instancetype)init
{
    if (self = [super init]) {
        [self setAudioSession];
        [self.audioRecorder prepareToRecord];
        self.recordTime = 0;
    }
    return self;
}

#pragma mark - AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (flag) {
        if ([self.delegate respondsToSelector:@selector(recorder:didSuccessfullyWithFilePath:recordTime:)]) {
            [self.delegate recorder:self didSuccessfullyWithFilePath:self.audioRecorder.url recordTime:self.recordTime];
        }
        if (self.recordSucceed) {
            self.recordSucceed(self.audioRecorder.url,self.recordTime);
        }
    }else{
        NSLog(@"录音失败");
    }
}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error
{
    if (error) {
        if ([self.delegate respondsToSelector:@selector(recorder:didFailedWithError:)]) {
            [self.delegate recorder:self didFailedWithError:error];
        }
        if (self.recordFailed) {
            self.recordFailed(error);
        }
    }
}

#pragma mark  - public method

- (void)startRecord
{
    if (![self.audioRecorder isRecording]) {
        [self setAudioSession];
        [self.audioRecorder record];
        [self.timer setFireDate:[NSDate date]];
    }
}

- (void)pauseRecord
{
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder pause];
        [self fireTimerDistantFuture];
    }
}

- (void)stopRecord
{
    
    [self.audioRecorder stop];
    [[AVAudioSession sharedInstance]setActive:NO error:nil];
    [self fireTimerDistantFuture];
    self.audioPower = 0.0;
    self.recordTime = 0;
}

- (void)addAudioPowerListener:(AudioPowerListener)listener
{
    self.listener      = listener;
}

- (void)didRecordFailed:(RecordFailed)recordFailed
{
    self.recordFailed  = recordFailed;
}

- (void)didRecordSucceed:(RecordSucceed)recordSucceed
{
    self.recordSucceed = recordSucceed;
}

- (void)fireTimerDistantFuture
{
    [self.timer setFireDate:[NSDate distantFuture]];
}
#pragma mark - private method

- (NSURL*)savePath
{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:kRecorderFileName];
    NSLog(@"file path:%@",urlStr);
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

- (void)setAudioSession
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [session setActive:YES error:nil];
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting{
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dicM;
}

#pragma mark - timer action
/**
 *  录音声波状态设置
 */
-(void)audioPowerChange{
    [self.audioRecorder updateMeters];//更新测量值
    float power= [self.audioRecorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    CGFloat progress=(1.0/160.0)*(power+160.0);
    self.audioPower = progress;
    NSLog(@"录音声波状态>>>>%f，currentTime>>>>%f,currentDeviceTime>>>>%f",progress,self.audioRecorder.currentTime,self.audioRecorder.deviceCurrentTime);
    self.recordTime = self.audioRecorder.currentTime;
    if(self.listener){
        self.listener(progress);
    }
}

#pragma mark - setter

- (void)setAudioPower:(float)audioPower
{
    _audioPower = audioPower;
}

#pragma mark - getter 

- (AVAudioRecorder *)audioRecorder
{
    if (_audioRecorder == nil) {
        NSError *error = nil;
        _audioRecorder = [[AVAudioRecorder alloc]initWithURL:[self savePath] settings:[self getAudioSetting] error:&error];
        _audioRecorder.delegate = self;
        _audioRecorder.meteringEnabled = YES;
        if (error) {
            NSLog(@"录音机创建错误%@",error.localizedDescription);
            return nil;
        }
        
    }
    return _audioRecorder;
}

- (NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
    }
    return _timer;
}

#pragma mark - dealloc

- (void)dealloc
{
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
