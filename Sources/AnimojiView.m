//
//  AnimojiView.m
//  Animoji
//
//  Created by Lasha Efremidze on 11/12/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

#import "AnimojiView.h"
#import "AVTPuppetView.h"
#import "AVTPuppet.h"
#import <objc/runtime.h>

@interface AnimojiView ()

@property (readwrite, nonatomic, strong) AVTPuppetView *puppetView;

@end

@implementation AnimojiView

- (instancetype)initWithFrame:(CGRect)frame options:(nullable NSDictionary<NSString *, id> *)options
{
    self = [super initWithFrame:frame options:options];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    // load AvatarKit
    NSBundle *b = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/AvatarKit.framework"];
    if (![b load]) {
        NSLog(@"Error"); // maybe throw an exception
    }
}

- (AVTPuppetView *)puppetView
{
    if (!_puppetView) {
        _puppetView = [[NSClassFromString(@"AVTPuppetView") alloc] initWithFrame:self.bounds];
        _puppetView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _puppetView.backgroundColor = UIColor.whiteColor;
        [self addSubview:_puppetView];
    }
    return _puppetView;
}

- (void)setPuppetName:(NSString *)puppetName
{
    AVTPuppet *puppet = [NSClassFromString(@"AVTPuppet") puppetNamed:puppetName options:nil];
    self.puppetView.avatarInstance = (AVTAvatarInstance *)puppet;
}

+ (NSArray *)puppetNames
{
    return [NSClassFromString(@"AVTPuppet") puppetNames];
}

+ (UIImage *)thumbnailForPuppetNamed:(NSString *)string
{
    return [NSClassFromString(@"AVTPuppet") thumbnailForPuppetNamed:string options: nil];
}

- (bool)isPreviewing
{
    return self.puppetView.isPreviewing;
}

- (bool)isRecording
{
    return self.puppetView.isRecording;
}

- (double)maxRecordingDuration
{
    return _maxRecordingDuration ? _maxRecordingDuration : 60;
}

- (void)audioPlayerItemDidReachEnd:(id)arg1
{
    [self.puppetView audioPlayerItemDidReachEnd:arg1];
}

- (bool)exportMovieToURL:(id)arg1 options:(id)arg2 completionHandler:(id /* block */)arg3
{
    return [self.puppetView exportMovieToURL:arg1 options:arg2 completionHandler:arg3];
}

- (double)recordingDuration
{
    return self.puppetView.recordingDuration;
}

- (void)startRecording
{
    [self.puppetView startRecording];
    
    int duration = self.maxRecordingDuration * 60;
    
    NSMutableData *timesBuffer = [NSMutableData dataWithCapacity: duration * 8];
    NSMutableData *blendShapeBuffer = [NSMutableData dataWithCapacity: duration * 204];
    NSMutableData *transformData = [NSMutableData dataWithCapacity: duration * 64];
    
    [self.puppetView setValue:[NSNumber numberWithInt:duration] forKey:@"_recordingCapacity"];
    [self.puppetView setValue:timesBuffer forKey:@"_rawTimesData"];
    [self.puppetView setValue:blendShapeBuffer forKey:@"_rawBlendShapesData"];
    [self.puppetView setValue:transformData forKey:@"_rawTransformsData"];
    
    {
        Ivar ivar = class_getInstanceVariable(NSClassFromString(@"AVTPuppetView"), "_rawTimes");
        object_setIvar(self.puppetView, ivar, [timesBuffer mutableBytes]);
    }
    
    {
        Ivar ivar = class_getInstanceVariable(NSClassFromString(@"AVTPuppetView"), "_rawBlendShapes");
        object_setIvar(self.puppetView, ivar, [blendShapeBuffer mutableBytes]);
    }
    
    {
        Ivar ivar = class_getInstanceVariable(NSClassFromString(@"AVTPuppetView"), "_rawTransforms");
        object_setIvar(self.puppetView, ivar, [transformData mutableBytes]);
    }
}

- (void)stopRecording
{
    [self.puppetView stopRecording];
}

- (void)startPreviewing
{
    [self.puppetView startPreviewing];
}

- (void)stopPreviewing
{
    [self.puppetView stopPreviewing];
}

- (UIImage*)snapshotWithSize:(CGSize)size
{
    return [self.puppetView snapshotWithSize:size];
}

@end
