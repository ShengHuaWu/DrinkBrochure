//
//  ImageProvider.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 29/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

// MARK: - Asset
struct Asset {
    let save: (UIImage) throws -> ()
    let load: () -> UIImage?
}

// MARK: - Drink Extension
extension Drink {
    // TODO: This is just a temporary solution
    func asset(with fileManager: FileManager = FileManager.default, userDefaults: UserDefaults = UserDefaults.standard) -> Asset? {
        guard let directoryURL = userDefaults.directoryURL() else { return nil }
        
        let url = directoryURL.appendingPathComponent(drinkID)

        return Asset(save: { (image) in
            let data = UIImageJPEGRepresentation(image, 1.0)
            try data?.write(to: url)
        }, load: { () -> UIImage? in
            guard fileManager.fileExists(atPath: url.path) else { return nil }
            
            return UIImage(contentsOfFile: url.path)
        })
    }
}

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
