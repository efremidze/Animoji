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
func extractMethod(_ owner: AnyObject, _ selector: Selector, _ arg1: Any?) -> AnyObject? {
    guard let method = getMethod(owner, selector) else { return nil }
    let imp = method_getImplementation(method)
    typealias CFunction = @convention(c) (AnyObject, Selector, Any?) -> Unmanaged<AnyObject>
    let function = unsafeBitCast(imp, to: CFunction.self)
    return function(owner, selector, arg1).takeUnretainedValue()
}

func extractMethod(_ owner: AnyObject, _ selector: Selector, _ arg1: Any?, _ arg2: Any?) -> AnyObject? {
    guard let method = getMethod(owner, selector) else { return nil }
    let imp = method_getImplementation(method)
    typealias CFunction = @convention(c) (AnyObject, Selector, Any?, Any?) -> Unmanaged<AnyObject>
    let function = unsafeBitCast(imp, to: CFunction.self)
    return function(owner, selector, arg1, arg2).takeUnretainedValue()
}

private func getMethod(_ owner: AnyObject, _ selector: Selector) -> Method? {
    if let owner = owner as? AnyClass {
        return class_getClassMethod(owner, selector)
    } else {
        return class_getInstanceMethod(type(of: owner), selector)
    }
}

private class Associated<Type>: NSObject {
    let value: Type
    init(_ value: Type) {
        self.value = value
    }
}

protocol Associable {}
extension Associable where Self: NSObject {
    func _value<T>(forKeyPath keyPath: String) -> T? {
        return (value(forKeyPath: keyPath) as? Associated<T>).map { $0.value }
    }
    func _setValue<T>(_ value: T?, forKeyPath keyPath: String) {
        setValue(value.map { Associated<T>($0) }, forKeyPath: keyPath)
    }
}
extension NSObject: Associable {}
