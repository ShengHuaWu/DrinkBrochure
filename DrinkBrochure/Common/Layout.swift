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

// MARK: - Distribution
enum Distribution {
    struct Ratio {
        let value: CGFloat // Between 0 and 1
        
        init(value: CGFloat) {
            precondition(value > 0.0 && value < 1.0, "Ratio value must be between zero and one.")
            
            self.value = value
        }
    }
    
    case equally
    case proportionally(resizedIndices: Set<Int>, ratio: Ratio)
}

// MARK: - Horizontal Layout
struct HorizontalLayout: Layout {
    let contents: [Layout]
    let spacing: CGFloat
    let distribution: Distribution
    
    init(contents: [Layout], spacing: CGFloat, distribution: Distribution) {
        if case let .proportionally(resizedIndices, _) = distribution {
            for index in resizedIndices {
                if !contents.indices.contains(index) {
                    preconditionFailure("Resized content indices are out of bound.")
                }
            }
        }
        
        self.contents = contents
        self.spacing = spacing
        self.distribution = distribution
    }
    
    func layout(in rect: CGRect) {
        switch distribution {
        case .equally:
            setLayoutEqually(in: rect)
        case let .proportionally(resizedIndices, ratio):
            setLayoutProportionally(in: rect, with: resizedIndices, ratio: ratio)
        }
    }
    
    private func setLayoutEqually(in rect: CGRect) {
        let totalWidthWithoutSpacing = rect.width - CGFloat(contents.count - 1) * spacing
        let width = totalWidthWithoutSpacing / CGFloat(contents.count)
        for (offset, content) in contents.enumerated() {
            let frame = CGRect(x: rect.minX + CGFloat(offset) * (width + spacing), y: rect.minY, width: width, height: rect.height)
            content.layout(in: frame)
        }
    }
    
    private func setLayoutProportionally(in rect: CGRect, with resizedIndices: Set<Int>, ratio: Distribution.Ratio) {
        let totalWidthWithoutSpacing = rect.width - CGFloat(contents.count - 1) * spacing
        let standardWidth = totalWidthWithoutSpacing / (CGFloat(contents.count - resizedIndices.count) + ratio.value * CGFloat(resizedIndices.count))
        var minX = rect.minX
        for (index, content) in zip(contents.indices, contents) {
            let width = resizedIndices.contains(index) ? standardWidth * ratio.value : standardWidth
            let frame = CGRect(x: minX, y: rect.minY, width: width, height: rect.height)
            content.layout(in: frame)
            minX = frame.maxX + spacing
        }
    }
}

// MAKR: - Vertical Layout
struct VerticalLayout: Layout {
    let contents: [Layout]
    let spacing: CGFloat
    let distribution: Distribution
    
    init(contents: [Layout], spacing: CGFloat, distribution: Distribution) {
        if case let .proportionally(resizedIndices, _) = distribution {
            for index in resizedIndices {
                if !contents.indices.contains(index) {
                    preconditionFailure("Resized content indices are out of bound.")
                }
            }
        }
        
        self.contents = contents
        self.spacing = spacing
        self.distribution = distribution
    }
    
    func layout(in rect: CGRect) {
        switch distribution {
        case .equally:
            setLayoutEqually(in: rect)
        case let .proportionally(resizedIndices, ratio):
            setLayoutProportionally(in: rect, with: resizedIndices, ratio: ratio)
        }
    }
    
    private func setLayoutEqually(in rect: CGRect) {
        let totalHeightWithoutSpacing = rect.height - CGFloat(contents.count - 1) * spacing
        let height = totalHeightWithoutSpacing  / CGFloat(contents.count)
        for (offset, content) in contents.enumerated() {
            let frame = CGRect(x: rect.minX, y: rect.minY + CGFloat(offset) * (height + spacing), width: rect.width, height: height)
            content.layout(in: frame)
        }
    }
    
    private func setLayoutProportionally(in rect: CGRect, with resizedIndices: Set<Int>, ratio: Distribution.Ratio) {
        let totalHeightWithoutSpacing = rect.height - CGFloat(contents.count - 1) * spacing
        let standardHeight = totalHeightWithoutSpacing / (CGFloat(contents.count - resizedIndices.count) + ratio.value * CGFloat(resizedIndices.count))
        var minY = rect.minY
        for (index, content) in zip(contents.indices, contents) {
            let height = resizedIndices.contains(index) ? standardHeight * ratio.value : standardHeight
            let frame = CGRect(x: rect.minX, y: minY, width: rect.width, height: height)
            content.layout(in: frame)
            minY = frame.maxY + spacing
        }
    }
}
