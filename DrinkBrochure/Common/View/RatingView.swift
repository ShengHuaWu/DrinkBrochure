//
//  RatingView.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 27/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

class RatingView: UIView {
    // MARK: - Properties
    private let numberOfButtons = 5
    private lazy var buttons: [UIButton] = {
        var buttons = [UIButton]()
        for _ in 0 ..< self.numberOfButtons {
            let button = UIButton(type: .custom)
            button.backgroundColor = .brown
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
}
