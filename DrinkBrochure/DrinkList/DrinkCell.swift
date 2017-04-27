//
//  DrinkCell.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 20/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

class DrinkCell: UICollectionViewCell {
    // MARK: - Properties
    private lazy var containerView: UIStackView = {
        let elements: [ContentElement] = [
            .image(image: UIImage()),
            .label(text: "Drink Name"),
            .rating
        ]
        let view = UIStackView(elements: elements)
        return view
    }()
    
    // MARK: - Designated Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
        
        contentView.addSubview(containerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.frame = contentView.bounds
    }
}
