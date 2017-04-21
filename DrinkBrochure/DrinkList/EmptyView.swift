//
//  EmptyView.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 20/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    // MARK: - Properties
    private lazy var containerView: UIStackView = {
        let elements: [ContentElement] = [
            .image(image: UIImage()),
            .label(text: "This is a label"),
            .button(title: "Add a new Drink")
        ]
        let view = UIStackView(elements: elements)
        return view
    }()
    
    // MARK: - Designated Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin: CGFloat = 20.0
        // TODO: Move status bar plus navigation bar height to constant
        let statusBarPlusNavigationBarHeight: CGFloat = 64.0
        containerView.frame = CGRect(x: margin, y: statusBarPlusNavigationBarHeight + margin, width: bounds.width - margin * 2.0, height: bounds.height * 2.0 / 3.0)
    }
}
