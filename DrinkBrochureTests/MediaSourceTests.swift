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
        
        XCTAssertNil(source.imagePicker)
    }
    
    func testPhotoLibraryImagePicker() {
        let source = UIViewController.photoLibraryImage
        
        let imagePicker = source.imagePicker
        
        imagePicker!.verify(sourceType: source.sourceType, mediaTypes: source.mediaTypes)
    }
}

extension UIImagePickerController {
    func verify(sourceType: UIImagePickerControllerSourceType, mediaTypes: [String], file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(self.sourceType, sourceType, "source type", file: file, line: line)
        XCTAssertEqual(self.mediaTypes, mediaTypes, "media types", file: file, line: line)
        XCTAssertEqual(self.allowsEditing, true, "allows editing", file: file, line: line)
    }
}
