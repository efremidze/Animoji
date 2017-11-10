//
//  Animoji.swift
//  Animoji
//
//  Created by Lasha Efremidze on 11/9/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import Foundation
import SceneKit

//AvatarKit

public class Animoji: SCNView {
    public class func foo() {
        let object = NSClassFromString("AVTPuppet")
        propertyNames(forClass: object!).forEach { print($0) }
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
