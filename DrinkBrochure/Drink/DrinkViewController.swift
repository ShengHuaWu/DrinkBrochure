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
    // MARK: Properties
    fileprivate lazy var drinkView: DrinkView = {
        let view = DrinkView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectImageAction(sender:)))
        view.imageView.addGestureRecognizer(tap)
        
        return view
    }()
        
    var viewModel: DrinkViewModel!
    var didSelectImage: (() -> ())?
    var presentCamera: (() -> ())?
    var presentPhotoLibrary: (() -> ())?
    var didCreateDrink: (() -> ())?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(drinkView)
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
    
    func doneCreationAction(sender: UIBarButtonItem) {
        guard let image = drinkView.imageView.image else {
            // TODO: Show alert
            return
        }
        
        // TODO: Not finish
        viewModel.createDrink(with: image)
        
        didCreateDrink?()
    }
    
    func editAction(sender: UIBarButtonItem) {
        viewModel.switchToEditing()
    }
    
    func doneEditingAction(sender: UIBarButtonItem) {
        viewModel.switchToPresentation()
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
    
    // MARK: Public Methods
    func updateUI(with state: DrinkState) {
        switch state {
        case .creation:
            let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction(sender:)))
            navigationItem.leftBarButtonItem = cancelItem
            
            let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneCreationAction(sender:)))
            navigationItem.rightBarButtonItem = doneItem
        case .editing:
            let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEditingAction(sender:)))
            navigationItem.rightBarButtonItem = doneItem
        case .presentation:
            let editItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAction(sender:)))
            navigationItem.rightBarButtonItem = editItem
        }
        
        drinkView.configure(with: state)
    }
}

// MARK: - Image Picker Controller Delegate && Navigation Controller Delegate
extension DrinkViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        drinkView.imageView.image = editedImage        
        picker.dismiss(animated: true, completion: nil)
    }
}
