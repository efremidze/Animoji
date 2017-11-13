//
//  ViewController.swift
//  Example
//
//  Created by Lasha Efremidze on 11/9/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit
import Animoji

class ViewController: UIViewController {

    @IBOutlet weak var animoji: Animoji! {
        didSet {
            for (index, name) in Animoji.PuppetName.all.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + (10 * Double(index))) {
                    self.animoji.setPuppet(name: name)
                }
            }
        }
    }
    
}
