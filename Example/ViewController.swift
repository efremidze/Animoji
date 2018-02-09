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
            let name = puppetNames[0]
            animoji.setPuppetName(name)
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
            collectionView.showsVerticalScrollIndicator = false
            collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
        }
    }
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    var layout: UICollectionViewFlowLayout {
        return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    lazy var puppetNames: [String] = {
        return Animoji.puppetNames() as! [String]
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let itemsPerRow = 4
        let inset = collectionView.contentInset.left + collectionView.contentInset.right
        let spacing = layout.minimumInteritemSpacing + layout.minimumLineSpacing
        let availableWidth = self.view.bounds.width - inset - CGFloat(itemsPerRow - 1) * spacing
        let width = floor(availableWidth / CGFloat(itemsPerRow))
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    @IBAction func record(sender: UIButton) {
        
    }
    
    @IBAction func preview(sender: UIButton) {
        
    }
    
    @IBAction func delete(sender: UIButton) {
        
    }
    
    @IBAction func share(sender: UIButton) {
        
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return puppetNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        let name = puppetNames[indexPath.item]
        cell.imageView.image = Animoji.thumbnail(forPuppetNamed: name)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = puppetNames[indexPath.item]
        animoji.setPuppetName(name)
    }
}

class Cell: UICollectionViewCell {
    lazy var imageView: UIImageView = { [unowned self] in
        let imageView = UIImageView(frame: self.contentView.bounds)
        imageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(imageView)
        return imageView
    }()
}
