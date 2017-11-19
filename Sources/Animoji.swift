//
//  Animoji.swift
//  Animoji
//
//  Created by Lasha Efremidze on 11/9/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import Foundation
import SceneKit
import AvatarKit

public enum PuppetName: String {
    // Generated using AVTPuppet.puppetNames()
    case monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn
    
    public static let all: [PuppetName] = [monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn]
}

@objc
public final class PuppetView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        let _ = avatarKitBundle
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let _ = avatarKitBundle
    }
    
    private lazy var puppetView: AVTPuppetView = {
       
        let view = AVTPuppetView(frame: bounds)
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
        
        return view
    }()
    
    public var puppetName: PuppetName? {
        
        didSet {
            
            let puppet: AVTPuppet?
            
            if let name = puppetName {
                
                puppet = AVTPuppet(named: name.rawValue, options: nil)
                
            } else {
                
                puppet = nil
            }
            
            self.puppetView.avatarInstance = unsafeBitCast(puppet, to: AVTAvatarInstance.self)
        }
    }
    
    public static func thumbnail(for puppetName: PuppetName) -> UIImage {
        
        return AVTPuppet.thumbnail(forPuppetNamed: puppetName.rawValue, options: nil)
    }
}

private let avatarKitBundle: Bundle = {
    
    let bundle = Bundle(path: "/System/Library/PrivateFrameworks/AvatarKit.framework")!
    assert(bundle.load())
    return bundle
}()
