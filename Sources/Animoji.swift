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
    func didStartPreviewing(_ animoji: Animoji)
    func didStopPreviewing(_ animoji: Animoji)
}

public class Animoji: AnimojiView {
    public enum PuppetName: String {
        // Generated using AVTPuppet.puppetNames()
        case monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn
        
        // @available(iOS 11.3, *)
        case lion, dragon, skull, bear
        
        public static var allCases: [PuppetName] {
            return [monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn, lion, dragon, skull, bear]
        }
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
    
    override open func startPreviewing() {
        super.startPreviewing()
        
        animojiDelegate?.didStartPreviewing(self)
    }
    
    override open func stopPreviewing() {
        super.stopPreviewing()
        
        animojiDelegate?.didStopPreviewing(self)
    }
    
}
