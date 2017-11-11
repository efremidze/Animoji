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
    public enum PuppetName: String {
        // Generated using AVTPuppet.puppetNames()
        case monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn
        
        static let all: [PuppetName] = [monkey, robot, cat, dog, alien, fox, poo, pig, panda, rabbit, chicken, unicorn]
    }
    
    public func setPuppet(name: PuppetName) {
        let puppet = AVTPuppet.puppetNamed(name.rawValue, options: nil)
        avatarInstance = puppet as? AVTAvatarInstance
    }
}
