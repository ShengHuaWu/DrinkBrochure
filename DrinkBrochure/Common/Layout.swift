//
//  Layout.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 27/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

// MARK: - Layout Protocol
protocol Layout {
    func layout(in rect: CGRect)
}

extension UIView: Layout {
    func layout(in rect: CGRect) {
        frame = rect
    }
}

// MARK: - Inset Layout
struct InsetLayout: Layout {
    let content: Layout
    let inset: UIEdgeInsets
    
    func layout(in rect: CGRect) {
        content.layout(in: UIEdgeInsetsInsetRect(rect, inset))
    }
}

// MARK: - Horizontal Layout
struct HorizontalLayout: Layout {
    let contents: [Layout]
    let spacing: CGFloat
    
    func layout(in rect: CGRect) {
        let width = (rect.width - CGFloat(contents.count - 1) * spacing) / CGFloat(contents.count)
        for (offset, content) in contents.enumerated() {
            let frame = CGRect(x: rect.minX + CGFloat(offset) * (width + spacing), y: rect.minY, width: width, height: rect.height)
            content.layout(in: frame)
        }
    }
}

// MAKR: - Vertical Layout
struct VerticalLayout: Layout {
    let contents: [Layout]
    let spacing: CGFloat
    
    func layout(in rect: CGRect) {
        let height = (rect.height - CGFloat(contents.count - 1) * spacing) / CGFloat(contents.count)
        for (offset, content) in contents.enumerated() {
            let frame = CGRect(x: rect.minX, y: rect.minY + CGFloat(offset) * (height + spacing), width: rect.width, height: height)
            content.layout(in: frame)
        }
    }
}
