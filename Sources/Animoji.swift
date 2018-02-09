//
//  Animoji.swift
//  Animoji
//
//  Created by Lasha Efremidze on 11/9/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import Foundation
import SceneKit

public protocol AnimojiDelegate: class {
    func didFinishPlaying(_ animoji: Animoji)
    func didStartRecording(_ animoji: Animoji)
    func didStopRecording(_ animoji: Animoji)
}

public class Animoji: AnimojiView {
    public enum PuppetName: String {
        // Generated using AVTPuppet.puppetNames()
        case monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn
        // case lion, dragon, skull, bear
        
        public static let all: [PuppetName] = [monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn]
    }
    
    public func setPuppet(name: PuppetName) {
//        let puppet = AVTPuppet.puppetNamed(name.rawValue, options: nil)
//        avatarInstance = puppet as? AVTAvatarInstance
        setPuppetName(name.rawValue)
    }
    
    public weak var animojiDelegate: AnimojiDelegate?

    override open func audioPlayerItemDidReachEnd(_ arg1: Any!) {
        super.audioPlayerItemDidReachEnd(arg1)
        
        animojiDelegate?.didFinishPlaying(self)
    }
    
    override open func startRecording() {
        super.startRecording()
        
        animojiDelegate?.didStartRecording(self)
    }
    
    override open func stopRecording() {
        super.stopRecording()
        
        animojiDelegate?.didStopRecording(self)
    }
    
}
