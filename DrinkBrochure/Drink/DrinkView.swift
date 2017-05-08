//
//  DrinkView.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 21/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

final class DrinkView: UIScrollView {
    // MARK: - Properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        return imageView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .brown
        return textField
    }()
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .brown
        return button
    }()
    
    private lazy var ratingView: RatingView = {
        let view = RatingView(frame: .zero)
        return view
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .brown
        return textView
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .brown
        return button
    }()
    
    // MARK: - Designated Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(imageView)
        addSubview(textField)
        addSubview(categoryButton)
        addSubview(ratingView)
        addSubview(textView)
        addSubview(deleteButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spacing: CGFloat = 8.0
        let verticalLayout = VerticalLayout(contents: [imageView, textField, categoryButton, ratingView, textView, deleteButton], spacing: spacing, distribution: .proportionally(resizedIndices: [1, 2, 3, 5], ratio: Distribution.Ratio(value: 0.25)))
        
        let margin: CGFloat = 16.0
        let composedLayout = InsetLayout(content: verticalLayout, inset: UIEdgeInsets(top: margin, left: margin, bottom: 0.0, right: margin))
        
        let height: CGFloat = 600.0
        composedLayout.layout(in: CGRect(x: 0.0, y: 0.0, width: frame.width, height: height))
        
        let bottomView = deleteButton.isHidden ? textView : deleteButton
        contentSize = CGSize(width: frame.width, height: bottomView.frame.maxY + margin)
    }
}
