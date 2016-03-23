//
//  ViewController.m
//  RecorderDemo
//
//  Created by AD-iOS on 15/12/1.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "ViewController.h"
#import "WDRecorder.h"
#import "WDAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<WDRecorderDelegate>

@property (strong, nonatomic) AVAudioPlayer *player;

@property (strong, nonatomic) WDRecorder *recorder;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
- (IBAction)startRecord:(id)sender;
- (IBAction)pauseRecord:(id)sender;
- (IBAction)stopRecord:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"xunzhang" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    if (error == nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [player prepareToPlay];
            [player play];
            sleep(player.duration);
        });
    }else{
        NSLog(@"%@",error.localizedDescription);
    }
    
//    self.recorder = [[WDRecorder alloc]init];
//    self.recorder.delegate = self;
//    [self.recorder addAudioPowerListener:^(float audioPower) {
//        self.progressView.progress = audioPower;
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startRecord:(id)sender {
    [self.recorder startRecord];
}
- (IBAction)pauseRecord:(id)sender {
    [self.recorder pauseRecord];
}

- (IBAction)stopRecord:(id)sender {
    [self.recorder stopRecord];
}

- (void)recorder:(WDRecorder *)recorder didSuccessfullyWithFilePath:(NSURL *)filePath recordTime:(NSTimeInterval)time
{
    NSLog(@"%@",filePath);
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([filePath isFileURL]) {
        if ([fm fileExistsAtPath:[filePath path]]) {
            NSLog(@"存在");
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                WDAudioPlayer *player = [[WDAudioPlayer alloc]initWithContentURL:filePath];
                [player audioPlay];
//                sleep(2);
            });

        }else{
            NSLog(@"不存在");
        }
    }else{
        NSLog(@"不是文件路径");
    }
    
}
@end
