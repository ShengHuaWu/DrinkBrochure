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
            button.addTarget(self, action: #selector(selectButtonAction(sender:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        return buttons
    }()
    
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
        
        let horizontalLayout = HorizontalLayout(contents: buttons, spacing: 8.0)
        let composedLayout = InsetLayout(content: horizontalLayout, inset: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        composedLayout.layout(in: bounds)
    }
    
    // MARK: - Button Actions
    func selectButtonAction(sender: RatingButton) {
        guard let selectedIndex = buttons.index(of: sender) else { return }
        
        sender.isSelected = !sender.isSelected
        
        zip(buttons, 0 ..< buttons.count ).forEach { (button, index) in
            if index > selectedIndex {
                button.isSelected = false
            } else if index < selectedIndex, !button.isSelected {
                button.isSelected = sender.isSelected
            }
        }
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
