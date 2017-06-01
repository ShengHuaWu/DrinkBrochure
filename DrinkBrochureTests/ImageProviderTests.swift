//
//  ImageProviderTests.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 29/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import XCTest
@testable import DrinkBrochure

// MARK: - Image Provider Tests
class ImageProviderTests: XCTestCase {
    // MARK: Properties
    private var imageProvider: ImageProvider!
    
    // MARK: Override Methods
    override func setUp() {
        super.setUp()
        
        imageProvider = ImageProvider()
    }
    
    override func tearDown() {
        imageProvider = nil
        
        super.tearDown()
    }
    
    // MARK: Enabled Tests
    func testSetUp() {
        let fileManager = MockFileManager()
        let userDefaults = UserDefaults(suiteName: #file)!
        userDefaults.removePersistentDomain(forName: #file)
        
        ImageProvider.setUp(with: fileManager, userDefaults: userDefaults)
        
        fileManager.verify()
        XCTAssertNotNil(userDefaults.directoryURL())
    }
    
    func testLoadWithoutFileExist() {
        let url = URL(string: "https://developer.apple.com")!
        
        let image = imageProvider.load(at: url) { _ in return false }
        
        XCTAssertNil(image)
    }
}

// MARK: - Mock File Manager
final class MockFileManager: FileManagerProtocol {
    private(set) var urlsCallCount = 0
    private(set) var createDirectoryCallCount = 0
    
    func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL] {
        urlsCallCount += 1
        return [URL(string: "https://developer.apple.com")!]
    }
    
    func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [String : Any]?) throws {
        createDirectoryCallCount += 1
    }
    
    func verify(file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(urlsCallCount, 1, "urls call count", file: file, line: line)
        XCTAssertEqual(createDirectoryCallCount, 1, "create directory call count", file: file, line: line)
    }
}
