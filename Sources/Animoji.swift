//
//  Animoji.swift
//  Animoji
//
//  Created by Lasha Efremidze on 11/9/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import Foundation
import SceneKit

struct AvatarKit {
    static let shared = AvatarKit()
    init() {
        let bundle = Bundle(path: "/System/Library/PrivateFrameworks/AvatarKit.framework")!
        assert(bundle.load())
    }
    var puppetView: SCNView.Type {
        return NSClassFromString("AVTPuppetView") as! SCNView.Type
    }
    var puppet: NSObject.Type {
        return NSClassFromString("AVTPuppet") as! NSObject.Type
    }
}

public enum PuppetName: String {
    // Generated using AVTPuppet.puppetNames()
    case monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn
    
    public static let all: [PuppetName] = [monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn]
}

public class PuppetView: SCNView {
    lazy var instance: SCNView = { [unowned self] in
        let object = AvatarKit.shared.puppetView.init()
        object.frame = self.bounds
        object.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(object)
        return object
    }()
}

open class Puppet: NSObject {
    lazy var instance: NSObject = { [unowned self] in
        return AvatarKit.shared.puppet.init()
    }()
    open class func puppetNamed(_ arg1: Any!, options arg2: Any!) -> Any {
        return AvatarKit.shared.puppet.value(forKeyPath: "puppetNamed") as Any
    }
    open class func puppetNames() -> [String] {
        return AvatarKit.shared.puppet.value(forKeyPath: "puppetNames") as! [String]
    }
    open class func thumbnail(forPuppetNamed arg1: Any!, options arg2: Any!) -> UIImage {
        return AvatarKit.shared.puppet.value(forKeyPath: "thumbnail") as! UIImage
    }
    
//    public static func puppetNamed(arg1: Any?, options: Any?) -> Any? {
//        return instance.puppetNamed(arg1: arg1, options: options)
//    }
}

// Key-Value Coding
// Create reference to the ForceUser.name key path
// let nameKeyPath = \ForceUser.name
// Access the value from key path on instance
// let obiwanName = obiwan[keyPath: nameKeyPath]  // "Obi-Wan Kenobi"

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
