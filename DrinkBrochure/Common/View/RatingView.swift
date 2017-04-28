//
//  RatingView.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 27/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

final class RatingView: UIView {
    // MARK: - Properties
    private let numberOfButtons = 5
    private lazy var buttons: [RatingButton] = {
        var buttons = [RatingButton]()
        for _ in 0 ..< self.numberOfButtons {
            let button = RatingButton(type: .custom)
            button.backgroundColor = .brown
            button.addTarget(self, action: #selector(clickButtonAction(sender:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        return buttons
    }()
    
    private var selectedIndices = [Int]() {
        didSet {
            for (button, index) in zip(buttons, 0 ..< buttons.count) {
                button.isSelected = selectedIndices.contains(index)
            }
        }
    }
    
    // MARK: - Designated Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        buttons.forEach(addSubview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spacing: CGFloat = 8.0
        let horizontalLayout = HorizontalLayout(contents: buttons, spacing: spacing)
        let composedLayout = InsetLayout(content: horizontalLayout, inset: UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing))
        composedLayout.layout(in: bounds)
    }
    
    // MARK: - Button Actions
    func clickButtonAction(sender: RatingButton) {
        guard let index = buttons.index(of: sender) else { return }
        
        let endIndex = selectedIndices.contains(index) ? index - 1 : index
        selectedIndices = endIndex < 0 ? [] : Array(0 ... endIndex)
    }
}

// MARK: - Rating Button
final class RatingButton: UIButton {
    override open var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .yellow
            } else {
                backgroundColor = .brown
            }
        }
    }
}
