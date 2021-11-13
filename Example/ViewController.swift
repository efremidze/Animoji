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
//            animoji.animojiDelegate = self
//            guard let name = puppetNames.first else { return }
//            animoji.setPuppetName(name)
            animoji.isHidden = true
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
    
    let puppetNames = Puppet.puppetNames()
    
    var fileUrl: URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL.appendingPathComponent("animoji.mov")
    }
    
    var enableRecording: Bool = true {
        didSet {
            recordButton.isHidden = !enableRecording
            previewButton.isHidden = enableRecording
            deleteButton.isHidden = enableRecording
            shareButton.isHidden = enableRecording
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableRecording = true
    }
    
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
//        let vc = AvatarKit.shared.AVTSplashScreenViewController.init()
        let vc = MemojiViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
//        if animoji.recording {
//            animoji.stopRecording()
//        } else {
//            animoji.startRecording()
//        }
    }
    
    @IBAction func preview(sender: UIButton) {
        if animoji.previewing {
            animoji.stopPreviewing()
        } else {
            animoji.startPreviewing()
        }
    }
    
    @IBAction func delete(sender: UIButton) {
        animoji.stopPreviewing()
        deleteRecording()
        enableRecording = true
    }
    
    @IBAction func share(sender: UIButton) {
        animoji.exportMovie(toURL: fileUrl, options: nil, completionHandler: { [unowned self] in
            let viewController = UIActivityViewController(activityItems: [self.fileUrl], applicationActivities: nil)
            self.present(viewController, animated: true, completion: nil)
        })
    }
    
    func deleteRecording() {
        try? FileManager.default.removeItem(at: fileUrl)
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

extension ViewController: AnimojiDelegate {
    func didFinishPlaying(_ animoji: Animoji) {
        if !animoji.recording {
            animoji.stopPreviewing()
        }
    }
    func didStartRecording(_ animoji: Animoji) {
        deleteRecording()
        enableRecording = true
        recordButton.setImage(#imageLiteral(resourceName: "stop-recording"), for: .normal)
    }
    func didStopRecording(_ animoji: Animoji) {
        animoji.startPreviewing()
        recordButton.setImage(#imageLiteral(resourceName: "record"), for: .normal)
    }
    func didStartPreviewing(_ animoji: Animoji) {
        enableRecording = false
        previewButton.setImage(#imageLiteral(resourceName: "stop-playing"), for: .normal)
    }
    func didStopPreviewing(_ animoji: Animoji) {
        previewButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
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

// https://worthdoingbadly.com/memoji/

class MemojiViewController: UIViewController {
    private var carouselSource: NSObject?
    private var carouselView: UIView?
    
    lazy var carouselController: UIViewController = {
        [Bundle.AvatarKit, Bundle.AvatarUI].forEach { assert($0.load()) }
        hookMethods()
        let source = extractMethod(AvatarKit.shared.AVTAvatarRecordDataSource, Selector(("defaultUIDataSourceWithDomainIdentifier:")), Bundle.main.bundleIdentifier) as! NSObject
        let controller = extractMethod(AvatarKit.shared.AVTCarouselController, Selector(("recordingCarouselForRecordDataSource:")), source) as! UIViewController
        controller.setValue(self, forKey: "presenterDelegate")
        let view = controller.value(forKeyPath: "view") as! UIView
        view.frame = self.view.bounds
        self.view.addSubview(view)
        self.carouselSource = source
        self.carouselView = view
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        _ = carouselController
    }
    
    @objc func presentAvatarUIController(_ presentation: NSObject, animated: Bool) {
        self.present(presentation.value(forKey: "controller") as! UIViewController, animated: animated)
    }
    @objc func dismissAvatarUIControllerAnimated(_ animated: Bool) {
        self.dismiss(animated: animated)
    }
}

typealias BundleForClass_Type = @convention(c) (AnyClass, Selector, AnyClass) -> Bundle
private var NSBundle_bundleForClass_real:BundleForClass_Type!
private func NSBundle_bundleForClass_hook(bundleClass: AnyClass, selector: Selector, classToGet:AnyClass) -> Bundle {
//    if let execNameCStr = class_getImageName(classToGet) {
//        let execName = String(cString: execNameCStr)
//        if execName == "/System/Library/PrivateFrameworks/AvatarUI.framework/AvatarUI" {
//            let url = Bundle.main.url(forResource: "AvatarUI", withExtension: "framework")!
//            return Bundle(url: url)!
//        }
//        if execName == "/System/Library/PrivateFrameworks/AvatarKit.framework/AvatarKit" {
//            let url = Bundle.main.url(forResource: "AvatarKit", withExtension: "framework")!
//            return Bundle(url: url)!
//        }
//    }
    return NSBundle_bundleForClass_real(bundleClass, selector, classToGet)
}

extension Bundle {
    static let AvatarKit = Bundle(path: "/System/Library/PrivateFrameworks/AvatarKit.framework")!
    static let AvatarUI = Bundle(path: "/System/Library/PrivateFrameworks/AvatarUI.framework")!
}

private func AVTUIEnvironment_storeLocation_hook(bundleClass: AnyClass, selector: Selector) -> NSURL {
    let manager = FileManager.default
    let documentDirectories = manager.urls(for: .documentDirectory, in: .userDomainMask)
    if documentDirectories.count < 1 {
        fatalError("No document directory?")
    }
    return documentDirectories[0].appendingPathComponent("Avatar", isDirectory: true) as NSURL
}

private var hooked = false;
private func hookMethods() {
    if hooked {
        return
    }
    hooked = true
    guard dlopen("/System/Library/PrivateFrameworks/AvatarUI.framework/AvatarUI", RTLD_LOCAL | RTLD_NOW) != nil else {
        let errS = dlerror()
        let err = errS == nil ? "" : String(cString: errS!)
        fatalError("Can't open library: \(err)")
    }
    hookBundle()
}

private func hookBundle() {
    guard let method = class_getClassMethod(Bundle.self, Selector(("bundleForClass:"))) else {
        fatalError("Can't find method")
    }
    NSBundle_bundleForClass_real = unsafeBitCast(method_getImplementation(method), to:BundleForClass_Type.self)
    method_setImplementation(method, unsafeBitCast(NSBundle_bundleForClass_hook as BundleForClass_Type, to: IMP.self))
}

private let swizzling: (AnyClass?, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    guard
        let originalMethod = class_getInstanceMethod(forClass, originalSelector),
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    else { return }
    method_exchangeImplementations(originalMethod, swizzledMethod)
}

extension NSObject {
    static let classInit: Void = {
        let originalSelector = Selector(("storeLocation"))
        let swizzledSelector = #selector(swizzled_storeLocation)
        swizzling(NSClassFromString("AVTUIEnvironment"), originalSelector, swizzledSelector)
    }()
    @objc func swizzled_storeLocation() -> NSURL {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return documentDirectories[0].appendingPathComponent("Avatar", isDirectory: true) as NSURL
    }
}
