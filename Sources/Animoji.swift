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

// write class that makes forwards all methods using runtime to instance or some protocol defined variable

// makes a class act like another class without subclassing
protocol ForwardInvocationProtocol {
    associatedtype T
    var instance: T { get }
    func swizzleMethods()
}

extension ForwardInvocationProtocol {
    func swizzleMethods() {
        // loop through all methods and call instance method
        // this includes protocols methods
        
        // basically if u have func foo(), call instance.foo(), similar to super.foo()
        // swizzle these functions to call the instance fuctions
        
        // first get all functions then loop through them and swizzle them
    }
}

public class PuppetView: SCNView {
    let instance: AVTPuppetView // PuppetViewProtocol
    
    public required init?(coder aDecoder: NSCoder) {
        let bundle = Bundle(path: "/System/Library/PrivateFrameworks/AvatarKit.framework")!
        assert(bundle.load())
        
        let classType = NSClassFromString("AVTPuppetView") as! AVTPuppetView.Type
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

//open class AVTPuppetView : AVTAvatarView {
//    open var previewing: Bool { get }
//    open var recording: Bool { get }
//    open func audioPlayerItemDidReachEnd(_ arg1: Any!)
//    open func exportMovie(toURL arg1: Any!, options arg2: Any!, completionHandler arg3: Any!) -> Bool /* block */
//    open func recordingDuration() -> Double
//    open func startPreviewing()
//    open func startRecording()
//    open func stopPreviewing()
//    open func stopRecording()
//}
//
//open class AVTPuppet : NSObject {
//    open class func puppetNamed(_ arg1: Any!, options arg2: Any!) -> Any!
//    open class func puppetNames() -> Any!
//    open class func thumbnail(forPuppetNamed arg1: Any!, options arg2: Any!) -> Any!
//}
//
//open class AVTAvatarView : SCNView {
//    open var avatarInstance: AVTAvatarInstance!
//}

