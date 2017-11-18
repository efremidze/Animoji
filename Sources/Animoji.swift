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

public protocol AvatarViewProtocol: class {
    var avatarInstance: Any! { get set }
}

public protocol PuppetViewProtocol: AvatarViewProtocol {
    
}

//public extension PuppetView {
//    public mutating func setPuppet(name: PuppetName) {
//        avatarInstance = Animoji.puppet.puppetNamed(arg1: name.rawValue, options: nil)
//    }
//}

public protocol PuppetProtocol: class {
    static func puppetNamed(arg1: Any?, options: Any?) -> Any?
//    static func puppetNames() -> Any?
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

protocol InstanceProtocol {
    associatedtype T
    static var instance: T.Type { get }
    var instance: T { get set }
}

public class PuppetView: SCNView, PuppetViewProtocol {
    static var instance: PuppetViewProtocol.Protocol {
        return NSClassFromString("AVTPuppetView") as! SCNView.Type
    }
    lazy var instance: PuppetViewProtocol = { [unowned self] in
        let bundle = Bundle(path: "/System/Library/PrivateFrameworks/AvatarKit.framework")!
        assert(bundle.load())
        
        let classType = type(of: self).instance
        let object = classType.init()
        object.frame = self.bounds
        object.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(object)
        return object
    }()
    
    public var avatarInstance: Any! {
        get { return instance.avatarInstance }
        set { instance.avatarInstance = newValue }
    }
}

public class Puppet: NSObject, PuppetProtocol, InstanceProtocol {
    static var instance: PuppetProtocol.Protocol {
        return NSClassFromString("AVTPuppet") as! NSObject.Type
    }
    lazy var instance: PuppetProtocol = { [unowned self] in
        let bundle = Bundle(path: "/System/Library/PrivateFrameworks/AvatarKit.framework")!
        assert(bundle.load())
        
        let classType = type(of: self).instance
        return classType.init()
    }()
    
    public static func puppetNamed(arg1: Any?, options: Any?) -> Any? {
        return instance.puppetNamed(arg1: arg1, options: options)
    }
}

// Key-Value Coding
// Create reference to the ForceUser.name key path
// let nameKeyPath = \ForceUser.name
// Access the value from key path on instance
// let obiwanName = obiwan[keyPath: nameKeyPath]  // "Obi-Wan Kenobi"

func getMethods() {
    var mc: CUnsignedInt = 0
    var mlist: UnsafeMutablePointer<Method?> = class_copyMethodList(FirstViewController.classForCoder(), &mc)
    let olist = mlist
    print("\(mc) methods")
    
    for i in (0..<mc) {
        print("Method #\(i): \(method_getName(mlist.pointee))")
        mlist = mlist.successor()
    }
    free(olist)
}

func propertyNames(forClass: AnyClass) -> [String] {
    var count = UInt32()
    let properties = class_copyPropertyList(forClass, &count)
    let names: [String] = (0..<Int(count)).flatMap { i in
        let property: objc_property_t = properties[i]
        guard let name = NSString(UTF8String: property_getName(property)) as? String else {
            debugPrint("Couldn't unwrap property name for \(property)")
            return nil
        }
        return name
    }
    free(properties)
    return names
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

