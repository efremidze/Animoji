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

@end
