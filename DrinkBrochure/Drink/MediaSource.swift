//
//  MediaSource.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 01/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit
import MobileCoreServices

// MARK: - Media Source
struct MediaSource {
    let sourceType: UIImagePickerControllerSourceType
    let mediaTypes: [String]
    
    var imagePicker: UIImagePickerController? {
        if !validate() { return nil }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = mediaTypes
        imagePicker.allowsEditing = true
        
        return imagePicker
    }
    
    private func validate() -> Bool {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType),
            let availableMediaTypes = UIImagePickerController.availableMediaTypes(for: sourceType) else {
                return false
        }
        
        for type in mediaTypes {
            if !availableMediaTypes.contains(type) {
                return false
            }
        }
        
        return true
    }
}

// MARK: - View Controller Extension
extension UIViewController {
    static let cameraImage = MediaSource(sourceType: .camera, mediaTypes: [kUTTypeImage as String])
    static let photoLibraryImage = MediaSource(sourceType: .photoLibrary, mediaTypes: [kUTTypeImage as String])
}
