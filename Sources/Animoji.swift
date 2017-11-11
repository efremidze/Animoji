//
//  Animoji.swift
//  Animoji
//
//  Created by Lasha Efremidze on 11/9/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import Foundation
import SceneKit

public class Animoji: AVTPuppetView {
    public func setRandomPuppet() {
        let names = AVTPuppet.puppetNames() as? [String]
        guard let name = names?.first else { return }
        let puppet = AVTPuppet.puppetNamed(name, options: nil)
        avatarInstance = puppet as? AVTAvatarInstance
    }
}

func propertyNames(forClass: AnyClass) -> [String] {
    var count = UInt32()
    guard let properties = class_copyPropertyList(forClass, &count) else { fatalError("missing properties") }
    let names: [String] = (0..<Int(count)).flatMap { i in
        let property: objc_property_t = properties[i]
        return String(cString: property_getName(property))
    }
    free(properties)
    return names
}
