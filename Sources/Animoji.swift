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
    public typealias PuppetName = PuppetItem
    
    public func setPuppet(name: PuppetName) {
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
