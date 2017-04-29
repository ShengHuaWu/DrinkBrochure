//
//  ImagePicker.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 29/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit
import MobileCoreServices

final class ImagePicker: NSObject {
    // MARK: - Properties
    // TODO: Use callback closure instead of delegate?
    
    // MARK: - Public Methods
    func present(with source: UIImagePickerControllerSourceType, from viewController: UIViewController) {
        guard UIImagePickerController.checkImageAvailability(of: source) else { return }
        
        let imagePicker = UIImagePickerController(source: source, delegate: self)
        viewController.present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - Image Picker Controller Delegate
extension ImagePicker: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
}

// MARK: - Navigation Controller Delegate
extension ImagePicker: UINavigationControllerDelegate {
    
}

// MARK: - Image Picker Controller Extension
private extension UIImagePickerController {
    static func checkImageAvailability(of source: UIImagePickerControllerSourceType) -> Bool {
        guard UIImagePickerController.isSourceTypeAvailable(source),
            let mediaTypes = UIImagePickerController.availableMediaTypes(for: source) else {
                return false
        }
        
        return mediaTypes.contains(kUTTypeImage as String)
    }
    
    convenience init(source: UIImagePickerControllerSourceType, delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        self.init()
        
        self.sourceType = source
        self.mediaTypes = [kUTTypeImage as String]
        self.allowsEditing = true
        self.delegate = delegate
    }
}
