//
//  NotificationDescriptor.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 01/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

// MARK: - Notification Descriptor
struct NotificationDescriptor<Payload> {
    let name: Notification.Name
    let convert: (Notification) -> Payload
}

// MARK: - Notification Center Extension
extension NotificationCenter {
    func addObserver<Payload>(with descriptor: NotificationDescriptor<Payload>, block: @escaping (Payload) -> ()) {
        addObserver(forName: descriptor.name, object: nil, queue: nil) { (note) in
            block(descriptor.convert(note))
        }
    }
}

// MARK: - View Controller Extension
extension UIViewController {
    static let keyboardWillShow = NotificationDescriptor(name: Notification.Name.UIKeyboardWillShow, convert: KeyboardPayload.init)
    static let keyboardWillHide = NotificationDescriptor(name: Notification.Name.UIKeyboardWillHide, convert: KeyboardPayload.init)
}
