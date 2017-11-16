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

public protocol AvatarView {
    var avatarInstance: Any? { get set }
}

public protocol PuppetView: AvatarView {
    func setPuppetName(_ puppetName: String!)
}

public protocol Puppet {
    static func puppetNamed(arg1: Any?, options: Any?) -> Any?
    static func puppetNames() -> Any?
}

//protocol PuppetProtocol {
//    + (id)puppetNamed:(id)arg1 options:(id)arg2;
//    + (id)puppetNames;
//    + (UIImage *)thumbnailForPuppetNamed:(id)arg1 options:(id)arg2;
//    static var puppetNames: [String] { get }
//}

//class Puppet: NSObject, PuppetProtocol {
//    static func make() -> Puppet {
//        let myClass = NSClassFromString("AVTPuppet") as! Puppet.Type
//        return myClass.init()
//    }
//}

// AnimojiFactory
public class Animoji: SCNView {
    private var puppetView: PuppetView!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let bundle = Bundle(path: "/System/Library/PrivateFrameworks/AvatarKit.framework")!
        assert(bundle.load())
        
        // add methods to class by looping through objc runtime methods/properties
        // build generic factory to make any class
    }
    
    // make AVTPuppetView instance
    class var puppetView: PuppetView.Type {
        return NSClassFromString("AVTPuppetView") as! PuppetView.Type
    }
    
    // make AVTPuppet instance
    class var puppet: Puppet.Type {
        return NSClassFromString("AVTPuppet") as! Puppet.Type
    }
}

public extension PuppetView {
    public mutating func setPuppet(name: PuppetName) {
        avatarInstance = Animoji.puppet.puppetNamed(arg1: name.rawValue, options: nil)
    }
}
