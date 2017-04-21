//
//  DrinkView.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 21/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

class DrinkView: UIScrollView {
    // MARK: - Properties
    private lazy var containerView: UIStackView = {
        let elements: [ContentElement] = [
            .image(image: UIImage()),
            .textField(text: "", placeholder: "Drink Name"),
            .label(text: "Category Selection"),
            .label(text: "Rating Selection"),
            .textView(text: "Comment"),
            .button(title: "Delete Drink")
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
        
        containerView.frame = frame
    }
}
