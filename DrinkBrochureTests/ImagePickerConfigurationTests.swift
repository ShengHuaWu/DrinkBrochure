//
//  ImagePickerConfigurationTests.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 02/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import XCTest
@testable import DrinkBrochure

class ImagePickerConfigurationTests: XCTestCase {
    // MAEK: - Enabled Tests
    func testCameraImagePicker() {
        let config = UIImagePickerController.cameraImage
        
        XCTAssertFalse(config.validate())
    }
    
    func testPhotoLibraryImagePicker() {
        let config = UIImagePickerController.photoLibraryImage
        
        XCTAssert(config.validate())
    }
}
