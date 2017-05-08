//
//  LayoutTests.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 27/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import XCTest
@testable import DrinkBrochure

class LayoutTests: XCTestCase {
    // MARK: - Enabled Tests
    func testComposeInsetAndEquallyHorizontal() {
        let first = MockView()
        let second = MockView()
        let third = MockView()
        let horizontalLayout = HorizontalLayout(contents: [first, second, third], spacing: 5.0, distribution: .equally)
        let composedLayout = InsetLayout(content: horizontalLayout, inset: UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0))
        
        let rect = CGRect(x: 20.0, y: 20.0, width: 110.0, height: 50.0)
        composedLayout.layout(in: rect)
        
        first.verifyLayout(with: CGRect(x: 25.0, y: 25.0, width: 30.0, height: 40.0))
        second.verifyLayout(with: CGRect(x: 60.0, y: 25.0, width: 30.0, height: 40.0))
        third.verifyLayout(with: CGRect(x: 95.0, y: 25.0, width: 30.0, height: 40.0))
    }
    
    func testComposedInsetAndProportionallyHorizontal() {
        let first = MockView()
        let second = MockView()
        let third = MockView()
        let horizontalLayout = HorizontalLayout(contents: [first, second, third], spacing: 5.0, distribution: .proportionally(resizedIndices: [1], ratio: Distribution.Ratio(value: 0.25)))
        let composedLayout = InsetLayout(content: horizontalLayout, inset: UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0))
        
        let rect = CGRect(x: 20.0, y: 20.0, width: 110.0, height: 50.0)
        composedLayout.layout(in: rect)
        
        first.verifyLayout(with: CGRect(x: 25.0, y: 25.0, width: 40.0, height: 40.0))
        second.verifyLayout(with: CGRect(x: 70.0, y: 25.0, width: 10.0, height: 40.0))
        third.verifyLayout(with: CGRect(x: 85.0, y: 25.0, width: 40.0, height: 40.0))
    }
    
    func testComposedInsetAndEquallyVertical() {
        let first = MockView()
        let second = MockView()
        let third = MockView()
        let verticalLayout = VerticalLayout(contents: [first, second, third], spacing: 5.0, distribution: .equally)
        let composedLayout = InsetLayout(content: verticalLayout, inset: UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0))
        
        let rect = CGRect(x: 20.0, y: 20.0, width: 50.0, height: 110.0)
        composedLayout.layout(in: rect)
        
        first.verifyLayout(with: CGRect(x: 25.0, y: 25.0, width: 40.0, height: 30.0))
        second.verifyLayout(with: CGRect(x: 25.0, y: 60.0, width: 40.0, height: 30.0))
        third.verifyLayout(with: CGRect(x: 25.0, y: 95.0, width: 40.0, height: 30.0))
    }
    
    func testComposedInsetAndProportionallyVertical() {
        let first = MockView()
        let second = MockView()
        let third = MockView()
        let verticalLayout = VerticalLayout(contents: [first, second, third], spacing: 5.0, distribution: .proportionally(resizedIndices: [1], ratio: Distribution.Ratio(value: 0.25)))
        let composedLayout = InsetLayout(content: verticalLayout, inset: UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0))
        
        let rect = CGRect(x: 20.0, y: 20.0, width: 50.0, height: 110.0)
        composedLayout.layout(in: rect)
        
        first.verifyLayout(with: CGRect(x: 25.0, y: 25.0, width: 40.0, height: 40.0))
        second.verifyLayout(with: CGRect(x: 25.0, y: 70.0, width: 40.0, height: 10.0))
        third.verifyLayout(with: CGRect(x: 25.0, y: 85.0, width: 40.0, height: 40.0))
    }
}

// MARK: - Mock View
final class MockView: Layout {
    private(set) var layoutCallCount = 0
    private(set) var frame: CGRect
    
    init() {
        frame = .zero
    }
    
    func layout(in rect: CGRect) {
        layoutCallCount += 1
        frame = rect
    }
    
    func verifyLayout(with rect: CGRect, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(layoutCallCount, 1, "call count", file: file, line: line)
        XCTAssertEqual(frame, rect, "frame", file: file, line: line)
    }
}
