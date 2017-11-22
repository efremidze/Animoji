//
//  Animoji.swift
//  Animoji
//
//  Created by Lasha Efremidze on 11/9/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import Foundation
import SceneKit

let AKPuppet = AvatarKit.shared.AKPuppet
let AKPuppetView = AvatarKit.shared.AKPuppetView

private class AvatarKit {
    static let shared = AvatarKit()
    init() {
        let bundle = Bundle(path: "/System/Library/PrivateFrameworks/AvatarKit.framework")!
        assert(bundle.load())
    }
//    var puppetView: SCNView.Type {
//        return NSClassFromString("AVTPuppetView") as! SCNView.Type
//    }
//    var puppet: NSObject.Type {
//        return NSClassFromString("AVTPuppet") as! NSObject.Type
//    }
    lazy var AKPuppet = NSClassFromString("AVTPuppet") as! NSObject.Type
    lazy var AKPuppetView = NSClassFromString("AVTPuppetView") as! SCNView.Type
}

public enum PuppetItem: String {
    // Generated using AVTPuppet.puppetNames()
    case monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn
    
    public static let all: [PuppetItem] = [monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn]
}

public class PuppetView: SCNView {
    open lazy var instance: SCNView = { [unowned self] in
        let object = AKPuppetView.init()
        object.frame = self.bounds
        object.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(object)
        return object
    }()
    open var avatarInstance: Any? {
        get { return instance.value(forKeyPath: "avatarInstance") }
        set { instance.setValue(newValue, forKeyPath: "avatarInstance") }
    }
//    open func setPuppet(_ item: PuppetItem) {
//        avatarInstance = Puppet.puppetNamed(item.rawValue)
//    }
}

open class Puppet<T: NSObject> {
    open let value: T
    public init(_ value: T) {
        self.value = value
    }
    open var avatarNode: SCNNode? {
        return value.value(forKeyPath: "avatarNode") as? SCNNode
    }
    open var lightingNode: SCNNode? {
        return value.value(forKeyPath: "lightingNode") as? SCNNode
    }
    open var options: NSDictionary? {
        return value.value(forKeyPath: "options") as? NSDictionary
    }
    open class func puppetNamed(_ name: String) -> Puppet<T>? {
        let value = extractMethod(AKPuppet, Selector(("puppetNamed:options:")), name, nil) as? T
        return value.map { Puppet($0) }
    }
    open class func puppetNames() -> [String] {
        return AKPuppet.value(forKeyPath: "puppetNames") as! [String]
    }
    open class func thumbnail(forPuppetNamed name: String) -> UIImage? {
        return extractMethod(AKPuppet, Selector(("thumbnailForPuppetNamed:options:")), name, nil) as? UIImage
    }
}

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
