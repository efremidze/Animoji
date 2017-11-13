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
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.showsVerticalScrollIndicator = false
            collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
            layout?.itemSize = {
                let itemsPerRow = 4
                let availableWidth = self.view.bounds.width - CGFloat(itemsPerRow - 1) * layout!.minimumInteritemSpacing
                let itemLength = floor(availableWidth / CGFloat(itemsPerRow))
                return CGSize(width: itemLength, height: itemLength)
            }()
        }
    }
    
    var layout: UICollectionViewFlowLayout? {
        return collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Animoji.PuppetName.all.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        let name = Animoji.PuppetName.all[indexPath.item]
        cell.animoji.setPuppet(name: name)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = Animoji.PuppetName.all[indexPath.item]
        animoji.setPuppet(name: name)
    }
}

class Cell: UICollectionViewCell {
    lazy var animoji: Animoji = { [unowned self] in
        let animoji = Animoji(frame: self.contentView.bounds)
        self.contentView.addSubview(animoji)
        return animoji
    }()
}
