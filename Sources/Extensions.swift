//
//  Extensions.swift
//  Animoji
//
//  Created by Lasha Efremidze on 11/21/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import Foundation
import ObjectiveC.runtime

// https://codelle.com/blog/2016/2/calling-methods-from-strings-in-swift/
func extractMethodFrom(_ owner: AnyObject, _ selector: Selector) -> ((Any?, Any?) -> AnyObject)? {
    guard let method = methodFrom(owner, selector) else { return nil }
    
    let implementation = method_getImplementation(method)
    
    typealias Function = @convention(c) (AnyObject, Selector, Any?, Any?) -> Unmanaged<AnyObject>
    let function = unsafeBitCast(implementation, to: Function.self)
    
    return { arg1, arg2 in function(owner, selector, arg1, arg2).takeUnretainedValue() }
}

func methodFrom(_ owner: AnyObject, _ selector: Selector) -> Method? {
    if let owner = owner as? AnyClass {
        return class_getClassMethod(owner, selector)
    } else {
        return class_getInstanceMethod(type(of: owner), selector)
    }
}
