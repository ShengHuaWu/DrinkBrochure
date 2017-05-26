//
//  DrinkView.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 21/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

final class DrinkView: UIScrollView {
    // MARK: Properties
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        return imageView
    }()
    
    private(set) lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .brown
        return textField
    }()
    
    private(set) lazy var categoryButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .brown
        return button
    }()
    
    private(set) lazy var ratingView: RatingView = {
        let view = RatingView(frame: .zero)
        return view
    }()
    
    private(set) lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .brown
        return textView
    }()
    
    private(set) lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .brown
        return button
    }()
    
    // MARK: Designated Initializer
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
    
    // MARK: Layouts
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spacing: CGFloat = 8.0
        let distribution = Distribution.proportionally(resizedIndices: [1, 2, 3, 5], ratio: .quarter)
        let verticalLayout = CascadingLayout(axis: .vertical, contents: [imageView, textField, categoryButton, ratingView, textView, deleteButton], spacing: spacing, distribution: distribution)
        
        let margin: CGFloat = 16.0
        let composedLayout = InsetLayout(content: verticalLayout, inset: UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
        
        composedLayout.layout(in: CGRect(x: 0.0, y: 0.0, width: frame.width, height: Geometry.drinkViewHeight))
        
        let bottomView = deleteButton.isHidden ? textView : deleteButton
        contentSize = CGSize(width: frame.width, height: bottomView.frame.maxY + margin)
    }
}
