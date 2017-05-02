//
//  UIAlertController+Helpers.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 02/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func makeImagePickerActionSheet(cameraHandler: @escaping () -> (), photoLibraryHandler: @escaping () -> ()) -> UIAlertController {
        let actionSheet = UIAlertController(title: NSLocalizedString("drink.action-sheet.image-picker", comment: ""), message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: NSLocalizedString("drink.action-sheet.camera", comment: ""), style: .default) { _ in
            cameraHandler()
        }
        actionSheet.addAction(cameraAction)
        
        let photoLibraryAction = UIAlertAction(title: NSLocalizedString("drink.action-sheet.photo-library", comment: ""), style: .default) { _ in
            photoLibraryHandler()
        }
        actionSheet.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("drink.action-sheet.cancel", comment: ""), style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        return actionSheet
    }
}
