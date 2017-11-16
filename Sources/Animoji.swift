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

//class Box<T> {
//    let value: T
//    init(value: T) {
//        self.value = value
//    }
//}

public enum PuppetName: String {
    // Generated using AVTPuppet.puppetNames()
    case monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn
    
    public static let all: [PuppetName] = [monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn]
}

public protocol AvatarViewProtocol {
    var avatarInstance: Any? { get set }
}

public protocol PuppetViewProtocol: AvatarViewProtocol {
    
}

//public extension PuppetView {
//    public mutating func setPuppet(name: PuppetName) {
//        avatarInstance = Animoji.puppet.puppetNamed(arg1: name.rawValue, options: nil)
//    }
//}

public protocol PuppetProtocol {
    static func puppetNamed(arg1: Any?, options: Any?) -> Any?
    static func puppetNames() -> Any?
}

// AnimojiFactory
public class PuppetView: SCNView {
    let instance: SCNView // PuppetViewProtocol
    
    public required init?(coder aDecoder: NSCoder) {
        let bundle = Bundle(path: "/System/Library/PrivateFrameworks/AvatarKit.framework")!
        assert(bundle.load())
        
        let classType = NSClassFromString("AVTPuppetView") as! SCNView.Type
        instance = classType.init()
        
        super.init(coder: aDecoder)
        
        instance.frame = self.bounds
        instance.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(instance)
    }
}

//public class Puppet: NSObject {
//    let instance: PuppetProtocol
//
//}
