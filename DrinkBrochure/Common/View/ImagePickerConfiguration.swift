//
//  ImagePickerConfiguration.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 02/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit
import MobileCoreServices

// MARK: - Image Picker Controller Configuration
extension UIImagePickerController {
    struct Configuration {
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
    
    static let cameraImage = Configuration(sourceType: .camera, mediaTypes: [kUTTypeImage as String])
    static let photoLibraryImage = Configuration(sourceType: .photoLibrary, mediaTypes: [kUTTypeImage as String])
    
    convenience init?(config: Configuration) {
        guard config.validate() else { return nil }
        
        self.init()
        
        sourceType = config.sourceType
        mediaTypes = config.mediaTypes
        allowsEditing = true
    }
}
