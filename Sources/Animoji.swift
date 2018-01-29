//
//  Animoji.swift
//  Animoji
//
//  Created by Lasha Efremidze on 11/9/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import Foundation
import SceneKit

//public protocol AnimojiDelegate: class {
//    func didFinishPlaying(animoji: Animoji)
//    func didStartRecording(animoji: Animoji)
//    func didStopRecording(animoji: Animoji)
//}

public class Animoji: AnimojiView {
    public enum PuppetName: String {
        // Generated using AVTPuppet.puppetNames()
        case monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn
        // case lion, dragon, skull, bear
        
        public static let all: [PuppetName] = [monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn]
    }
    
//    public var maxDuration: Int = 60
//    public weak var delegate: AnimojiDelegate?
    
    public func setPuppet(name: PuppetName) {
//        let puppet = AVTPuppet.puppetNamed(name.rawValue, options: nil)
//        avatarInstance = puppet as? AVTAvatarInstance
        setPuppetName(name.rawValue)
    }
    
    public func setPuppet(name: String) {
        setPuppetName(name)
    }
    
//    override public func startRecording() {
//        super.startRecording()
//
//        let duration = maxDuration * 60
//
//        let timesBuffer = Data(capacity: duration * 8)
//        let blendShapeBuffer = Data(capacity: duration * 204)
//        let transformData = Data(capacity: duration * 64)
//
//        setValue(duration, forKey: "_recordingCapacity")
//        setValue(timesBuffer, forKey: "_rawTimesData")
//        setValue(blendShapeBuffer, forKey: "_rawBlendShapesData")
//        setValue(transformData, forKey: "_rawTransformsData")
//
//        let ivar = class_getInstanceVariable(AVTPuppetView.self, "_rawTimes")
//        object_setIvar(self, ivar!, timesBuffer)
//
//        let ivar2 = class_getInstanceVariable(AVTPuppetView.self, "_rawBlendShapes")
//        object_setIvar(self, ivar2!, blendShapeBuffer)
//
//        let ivar3 = class_getInstanceVariable(AVTPuppetView.self, "_rawTransforms")
//        object_setIvar(self, ivar3!, transformData)
//
//        playbackDelegate?.didStartRecording(animoji: self)
//    }
}
