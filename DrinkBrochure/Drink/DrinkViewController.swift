//
//  DrinkViewController.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 21/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

// MARK: - Drink View Controller
final class DrinkViewController: UIViewController {
    // MARK: Mode
    enum Mode {
        case creation
        case editing
        case presentation
    }
    
    // MARK: Properties
    fileprivate lazy var drinkView: DrinkView = {
        let view = DrinkView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectImageAction(sender:)))
        view.imageView.addGestureRecognizer(tap)
        
        return view
    }()
    
    private var mode: Mode {
        didSet {
            configureDrinkView()
        }
    }
    
    var didSelectImage: (() -> ())?
    var presentCamera: (() -> ())?
    var presentPhotoLibrary: (() -> ())?
    
    // MARK: Designated Initializer
    init(mode: Mode) {
        self.mode = mode
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if case .creation = mode {
            let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction(sender:)))
            navigationItem.leftBarButtonItem = cancelItem
        }
        
        view.backgroundColor = UIColor.white
        view.addSubview(drinkView)
        
        configureDrinkView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerNotifications()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        drinkView.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unregisterNotifications()
    }
    
    // MARK: Actions
    func cancelAction(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func selectImageAction(sender: UITapGestureRecognizer) {
        didSelectImage?()
    }
    
    // MARK: Register & unregister notifications
    private func registerNotifications() {
        let center = NotificationCenter.default
        center.addObserver(with: UIViewController.keyboardWillShow) { (payload) in
            let contentInset = UIEdgeInsetsMake(0.0, 0.0, payload.endFrame.height, 0.0)
            self.drinkView.contentInset = contentInset
            self.drinkView.scrollIndicatorInsets = contentInset
            self.drinkView.scrollRectToVisible(self.drinkView.textField.frame, animated: true)
        }
        center.addObserver(with: UIViewController.keyboardWillHide) { _ in
            let contentInset = UIEdgeInsets.zero
            self.drinkView.contentInset = contentInset
            self.drinkView.scrollIndicatorInsets = contentInset
        }
    }
    
    private func unregisterNotifications() {
        let center = NotificationCenter.default
        center.removeObserver(self, name: UIViewController.keyboardWillShow.name, object: nil)
        center.removeObserver(self, name: UIViewController.keyboardWillHide.name, object: nil)
    }
    
    private func configureDrinkView() {
        switch mode {
        case .creation:
            drinkView.deleteButton.isHidden = true
            drinkView.imageView.isUserInteractionEnabled = true
            drinkView.textField.isUserInteractionEnabled = true
            drinkView.textView.isUserInteractionEnabled = true
            drinkView.ratingView.isUserInteractionEnabled = true
        case .editing:
            drinkView.deleteButton.isHidden = false
            drinkView.imageView.isUserInteractionEnabled = true
            drinkView.textField.isUserInteractionEnabled = true
            drinkView.textView.isUserInteractionEnabled = true
            drinkView.ratingView.isUserInteractionEnabled = true
        case .presentation:
            drinkView.deleteButton.isHidden = true
            drinkView.imageView.isUserInteractionEnabled = false
            drinkView.textField.isUserInteractionEnabled = false
            drinkView.textView.isUserInteractionEnabled = false
            drinkView.ratingView.isUserInteractionEnabled = false
        }
    }
}

// MARK: - Image Picker Controller Delegate && Navigation Controller Delegate
extension DrinkViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        // TODO: Store image
        drinkView.imageView.image = editedImage
        
        picker.dismiss(animated: true, completion: nil)
    }
}
