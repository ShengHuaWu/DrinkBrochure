//
//  EmptyView.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 20/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

class EmptyView: UIScrollView {
    // MARK: - Properties
    // TODO: Remove background color and default text
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = UIColor.brown
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = UIColor.brown
        label.text = "This is a label."
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.brown
        button.setTitle("Add a new Drink", for: .normal)
        return button
    }()
    
    // MARK: - Designated Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(addButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin: CGFloat = 20.0
        let statusBarPlusNavigationBarHeight: CGFloat = 64.0
        let width = frame.width
        let height = frame.height
        
        imageView.frame = CGRect(x: margin, y: statusBarPlusNavigationBarHeight + margin, width: width - margin * 2.0, height: height / 2.0 - margin)
        
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: imageView.frame.minX, y: imageView.frame.maxY + margin, width: imageView.frame.width, height: titleLabel.frame.height)
        
        addButton.frame = CGRect(x: titleLabel.frame.minX, y: titleLabel.frame.maxY + margin, width: titleLabel.frame.width, height: titleLabel.frame.height)
    }
}
