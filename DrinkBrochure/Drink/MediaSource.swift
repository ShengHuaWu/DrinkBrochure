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
    
    func validate() -> Bool {
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

// MARK: - Image Picker Controller Extension
extension UIImagePickerController {
    convenience init?(mediaSource: MediaSource) {
        guard mediaSource.validate() else { return nil }
        
        self.init()
    
        sourceType = mediaSource.sourceType
        mediaTypes = mediaSource.mediaTypes
        allowsEditing = true
    }
}

// MARK: - View Controller Extension
extension UIViewController {
    static let cameraImage = MediaSource(sourceType: .camera, mediaTypes: [kUTTypeImage as String])
    static let photoLibraryImage = MediaSource(sourceType: .photoLibrary, mediaTypes: [kUTTypeImage as String])
}
