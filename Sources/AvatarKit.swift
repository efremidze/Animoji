//
//  AvatarKit.swift
//  Animoji
//
//  Created by Lasha Efremidze on 5/9/19.
//  Copyright © 2019 Lasha Efremidze. All rights reserved.
//

import Foundation
import SceneKit

let AKAnimoji = AvatarKit.shared.AKAnimoji
let AKRecordView = AvatarKit.shared.AKRecordView

private class AvatarKit {
    static let shared = AvatarKit()
    init() {
        let bundle = Bundle(path: "/System/Library/PrivateFrameworks/AvatarKit.framework")!
        assert(bundle.load())
    }
    lazy var AKAnimoji = NSClassFromString("AVTAnimoji") as! NSObject.Type
    lazy var AKRecordView = NSClassFromString("AVTRecordView") as! SCNView.Type
}

public enum PuppetItem: String, CaseIterable {
    // Generated using AVTAnimoji.animojiNames
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
        let object = AKRecordView.init()
        object.frame = self.bounds
        object.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(object)
        return object
    }()
    open var avatar: Any? {
        get { return value.value(forKeyPath: "avatar") }
        set { value.setValue(newValue, forKeyPath: "avatar") }
    }
    open func setPuppet(_ item: PuppetItem) {
        avatar = Puppet.puppetNamed(item.rawValue)?.value
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
        return (extractMethod(AKAnimoji, Selector(("animojiNamed:")), name) as? T).map { Puppet($0) }
    }
    open class func puppetNames() -> [String] {
        return AKAnimoji.value(forKeyPath: "animojiNames") as! [String]
    }
    open class func thumbnail(forPuppetNamed name: String) -> UIImage? {
        return extractMethod(AKAnimoji, Selector(("thumbnailForAnimojiNamed:options:")), name, nil) as? UIImage
    }
}
