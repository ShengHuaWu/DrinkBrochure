//
//  ContentElement.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 20/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Content Element
enum ContentElement {
    case label(text: String)
    case image(image: UIImage)
    case button(title: String)
}

extension ContentElement {
    // TODO: Remove background color
    var view: UIView {
        switch self {
        case let .label(text):
            let label = UILabel()
            label.backgroundColor = UIColor.brown
            label.text = text
            return label
        case let .image(image):
            let imageView = UIImageView()
            imageView.image = image
            imageView.backgroundColor = UIColor.brown
            return imageView
        case let .button(title):
            let button = UIButton(type: .custom)
            button.backgroundColor = UIColor.brown
            button.setTitle(title, for: .normal)
            return button
        }
    }
}

// MARK: - Stack View Custom Initializer
extension UIStackView {
    convenience init(elements: [ContentElement]) {
        self.init()
        
        axis = .vertical
        spacing = 20.0
        
        for element in elements {
            addArrangedSubview(element.view)
        }
    }
}
