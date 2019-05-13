//
//  AvatarKit.swift
//  Animoji
//
//  Created by Lasha Efremidze on 5/9/19.
//  Copyright © 2019 Lasha Efremidze. All rights reserved.
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
    lazy var AKPuppet = NSClassFromString("AVTPuppet") as! NSObject.Type
    lazy var AKPuppetView = NSClassFromString("AVTPuppetView") as! SCNView.Type
}

public enum PuppetItem: String, CaseIterable {
    // Generated using AVTPuppet.puppetNames()
    case monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn
    
//    @available(iOS 11.3, *)
    case lion, dragon, skull, bear
    
//    @available(iOS 12.0, *)
    case tiger, koala, trex, ghost
    
//    @available(iOS 12.2, *)
    case giraffe, shark, owl, boar
    
    public typealias AllCases = [PuppetItem]
    public static var allCases: AllCases {
        var cases = [monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn]
        if #available(iOS 11.3, *) {
            cases += [lion, dragon, skull, bear]
        }
        if #available(iOS 12.0, *) {
            cases += [tiger, koala, trex, ghost]
        }
        if #available(iOS 12.2, *) {
            cases += [giraffe, shark, owl, boar]
        }
        return cases
    }
}

public class PuppetView: SCNView {
    open lazy var value: SCNView = { [unowned self] in
        let object = AKPuppetView.init()
        object.frame = self.bounds
        object.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(object)
        return object
    }()
    open var avatarInstance: Any? {
        get { return value.value(forKeyPath: "avatarInstance") }
        set { value.setValue(newValue, forKeyPath: "avatarInstance") }
    }
    open func setPuppet(_ item: PuppetItem) {
        avatarInstance = Puppet.puppetNamed(item.rawValue)?.value
    }
}

open class Puppet<T: NSObject> {
    public let value: T
    public init(_ value: T) {
        self.value = value
    }
    open var avatarNode: SCNNode? {
        return value._value(forKeyPath: "avatarNode")
    }
    open var lightingNode: SCNNode? {
        return value._value(forKeyPath: "lightingNode")
    }
    open class func puppetNamed(_ name: String) -> Puppet<T>? {
        return (extractMethod(AKPuppet, Selector(("puppetNamed:options:")), name, nil) as? T).map { Puppet($0) }
    }
    open class func puppetNames() -> [String] {
        return AKPuppet.value(forKeyPath: "puppetNames") as! [String]
    }
    open class func thumbnail(forPuppetNamed name: String) -> UIImage? {
        return extractMethod(AKPuppet, Selector(("thumbnailForPuppetNamed:options:")), name, nil) as? UIImage
    }
}
