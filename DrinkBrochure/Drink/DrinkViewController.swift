//
//  DrinkViewController.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 21/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

final class DrinkViewController: UIViewController {
    // MARK: - Mode
    enum Mode {
        case creation
        case editing
        case presentation
    }
    
    // MARK: - Properties
    private lazy var drinkView: DrinkView = {
        let view = DrinkView()
        return view
    }()
    
    let mode: Mode
    
    var shouldShowCancelItem: Bool {
        switch mode {
        case .presentation: return false
        default: return true
        }
    }
    
    var shouldShowDeleteButton: Bool {
        switch mode {
        case .editing: return true
        default: return false
        }
    }
    
    // MARK: - Designated Initializer
    init(mode: Mode) {
        self.mode = mode
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if shouldShowCancelItem {
            let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction(sender:)))
            navigationItem.leftBarButtonItem = cancelItem
        }
        
        view.backgroundColor = UIColor.white
        view.addSubview(drinkView)
        
        drinkView.deleteButton.isHidden = !shouldShowDeleteButton
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectImageAction(sender:)))
        drinkView.imageView.addGestureRecognizer(tap)
        drinkView.imageView.isUserInteractionEnabled = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        drinkView.frame = view.bounds
    }
    
    // MARK: - Actions
    func cancelAction(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func selectImageAction(sender: UITapGestureRecognizer) {
        let actionSheet = UIAlertController.makeImagePickerActionSheet(cameraHandler: presentCamera, photoLibraryHandler: presentPhotoLibrary)
        present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func presentCamera() {
        guard let imagePicker = UIImagePickerController(config: UIImagePickerController.cameraImage) else { return }
        
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func presentPhotoLibrary() {
        guard let imagePicker = UIImagePickerController(config: UIImagePickerController.photoLibraryImage) else { return }
        
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - Image Picker Controller Delegate && Navigation Controller Delegate
extension DrinkViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        // TODO: Store image
        print(editedImage.size)
        picker.dismiss(animated: true, completion: nil)
    }
}
