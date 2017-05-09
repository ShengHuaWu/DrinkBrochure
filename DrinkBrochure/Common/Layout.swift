//
//  Layout.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 27/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

// MARK: - Layout
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

// MARK: - Axis
enum Axis {
    case horizontal
    case vertical
    
    func standardEdge(of rect: CGRect) -> CGFloat {
        switch self {
        case .horizontal: return rect.width
        case .vertical: return rect.height
        }
    }
}

// MARK: - Ratio
struct Ratio {
    let value: CGFloat // Between 0 and 1
    
    init(value: CGFloat) {
        precondition(value > 0.0 && value < 1.0, "Ratio value must be between zero and one.")
        
        self.value = value
    }
}

// MARK: - Distribution
enum Distribution {
    case equally
    case proportionally(resizedIndices: Set<Int>, ratio: Ratio)
    
    func validateIndices(in range: CountableRange<Int>) -> Bool {
        switch self {
        case .equally: return true
        case let .proportionally(indices, _):
            for index in indices {
                if !range.contains(index) { return false }
            }
            return true
        }
    }
}

// MARK: - Cascading Layout
struct CascadingLayout: Layout {
    let axis: Axis
    let contents: [Layout]
    let spacing: CGFloat
    let distribution: Distribution
    
    init(axis: Axis, contents: [Layout], spacing: CGFloat, distribution: Distribution = .equally) {
        guard distribution.validateIndices(in: contents.indices) else {
            preconditionFailure("Resized indices are out of bound.")
        }
        
        self.axis = axis
        self.contents = contents
        self.spacing = spacing
        self.distribution = distribution
    }
    
    func layout(in rect: CGRect) {
        let standard = standardValue(in: rect)
        switch axis {
        case .horizontal:
            var minX = rect.minX
            for (index, content) in zip(contents.indices, contents) {
                let width = adjust(standard: standard, at: index)
                let frame = CGRect(x: minX, y: rect.minY, width: width, height: rect.height)
                content.layout(in: frame)
                minX = frame.maxX + spacing
            }
        case .vertical:
            var minY = rect.minY
            for (index, content) in zip(contents.indices, contents) {
                let height = adjust(standard: standard, at: index)
                let frame = CGRect(x: rect.minX, y: minY, width: rect.width, height: height)
                content.layout(in: frame)
                minY = frame.maxY + spacing
            }
        }
    }
    
    private func standardValue(in rect: CGRect) -> CGFloat {
        let totalWidth = axis.standardEdge(of: rect) - CGFloat(contents.count - 1) * spacing
        switch distribution {
        case .equally:
            return totalWidth / CGFloat(contents.count)
        case let .proportionally(resizedIndices, ratio):
            return totalWidth / (CGFloat(contents.count - resizedIndices.count) + ratio.value * CGFloat(resizedIndices.count))
        }
    }
    
    private func adjust(standard: CGFloat, at index: Int) -> CGFloat {
        switch distribution {
        case .equally:
            return standard
        case let .proportionally(resizedIndices, ratio):
            return resizedIndices.contains(index) ? standard * ratio.value : standard
        }
    }
}
