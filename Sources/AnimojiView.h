//
//  AnimojiView.h
//  Animoji
//
//  Created by Lasha Efremidze on 11/12/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>

@interface AnimojiView : SCNView

//@property (nonatomic, retain) NSString *puppetName;

- (void)setPuppetName:(NSString *)puppetName;
+ (NSArray *)puppetNames;
+ (UIImage *)thumbnailForPuppetNamed:(NSString *)string;

@property (nonatomic, assign) double maxRecordingDuration; // Defaults to 60 seconds

//@property (getter=isPreviewing, nonatomic, readonly) bool previewing;
//@property (getter=isRecording, nonatomic, readonly) bool recording;
//- (void)audioPlayerItemDidReachEnd:(id)arg1;
//- (bool)exportMovieToURL:(id)arg1 options:(id)arg2 completionHandler:(id /* block */)arg3;

- (double)recordingDuration;
- (void)startPreviewing;
- (void)startRecording;
- (void)stopPreviewing;
- (void)stopRecording;

@end
