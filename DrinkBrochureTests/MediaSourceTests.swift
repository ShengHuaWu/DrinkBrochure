//
//  MediaSourceTests.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 01/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import XCTest
@testable import DrinkBrochure

class MediaSourceTests: XCTestCase {
    // MAEK: - Enabled Tests
    func testCameraImagePicker() {
        let source = UIViewController.cameraImage
        
        XCTAssertFalse(source.validate())
    }
    
    func testPhotoLibraryImagePicker() {
        let source = UIViewController.photoLibraryImage
        
        XCTAssert(source.validate())
    }
}
