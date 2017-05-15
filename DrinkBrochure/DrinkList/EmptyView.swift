//
//  EmptyView.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 20/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

final class EmptyView: UIView {
    // MARK: Properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .brown
        return label
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .brown
        return button
    }()
    
    // MARK: Designated Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(textLabel)
        addSubview(addButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layouts
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spacing: CGFloat = 8.0
        let distribution = Distribution.proportionally(resizedIndices: [1, 2], ratio: .oneFifth)
        let verticalLayout = CascadingLayout(axis: .vertical, contents: [imageView, textLabel, addButton], spacing: spacing, distribution: distribution)
        
        let horizontalMargin: CGFloat = 16.0
        let statusBarPlusNavigationBarHeight = Geometry.statusBarHeight + Geometry.navigationBarHeight
        let verticalMargin: CGFloat = (bounds.height - statusBarPlusNavigationBarHeight - Geometry.emptyViewContentHeight) / 2.0
        let composedLayout = InsetLayout(content: verticalLayout, inset: UIEdgeInsets(top: verticalMargin, left: horizontalMargin, bottom: verticalMargin, right: horizontalMargin))
        composedLayout.layout(in: CGRect(x: bounds.minX, y: bounds.minY + statusBarPlusNavigationBarHeight, width: bounds.width, height: bounds.height - statusBarPlusNavigationBarHeight))
    }
}
