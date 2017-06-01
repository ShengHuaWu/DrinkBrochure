//
//  ImageProvider.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 29/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

// MARK: - Image Provider
final class ImageProvider {
    static func setUp(with fileManager: FileManagerProtocol = FileManager.default, userDefaults: UserDefaults = UserDefaults.standard) {
        guard userDefaults.directoryURL() == nil else { return }
        
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let uniqueString = ProcessInfo.processInfo.globallyUniqueString
        let directoryURL = documentURL.appendingPathComponent(uniqueString)
        try! fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        userDefaults.set(directoryURL)
    }
    
    func save(_ image: UIImage, to url: URL) throws {
        try UIImageJPEGRepresentation(image, 1.0).flatMap{ try $0.write(to: url) }
    }
    
    func load(at url: URL, with exist: (URL) -> Bool = { FileManager.default.fileExists(atPath: $0.path) }) -> UIImage? {
        guard exist(url) else { return nil }
                
        return UIImage(contentsOfFile: url.path)
    }
}

// MARK: - Drink Extension
extension Drink {
    func photoURL(with userDefaults: UserDefaults = UserDefaults.standard) -> URL {
        guard let directoryURL = userDefaults.directoryURL() else {
            fatalError("Directory doesn'r exist.")
        }
        
        return directoryURL.appendingPathComponent(drinkID)
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
