//
//  ImageProvider.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 29/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation

// MARK: - Image Provider
final class ImageProvider {
    // MARK: Public Methods
    static func setUp(with fileManager: FileManagerProtocol = FileManager.default, userDefaults: UserDefaults = UserDefaults.standard) {
        guard userDefaults.directoryURL() == nil else { return }
        
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let uniqueString = ProcessInfo.processInfo.globallyUniqueString
        let directoryURL = documentURL.appendingPathComponent(uniqueString)
        try! fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        userDefaults.set(directoryURL)
    }
}

// MARK: - User Defaults Extension
extension UserDefaults {
    private static let directoryURLKey = "DirectoryURLKey"
    
    @discardableResult
    func set(_ directoryURL: URL) -> Bool {
        set(directoryURL, forKey: UserDefaults.directoryURLKey)
        return synchronize()
    }
    
    func directoryURL() -> URL? {
        return url(forKey: UserDefaults.directoryURLKey)
    }
}

// MARK: - File Manager Protocol
protocol FileManagerProtocol {
    func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL]
    func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [String : Any]?) throws
}

extension FileManager: FileManagerProtocol {}
