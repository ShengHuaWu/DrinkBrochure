//
//  DrinkCell.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 20/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

final class DrinkCell: UICollectionViewCell {
    // MARK: - Properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        return imageView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .brown
        return label
    }()
    
    private lazy var ratingView: RatingView = {
        let view = RatingView(frame: .zero)
        return view
    }()
    
    // MARK: - Designated Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
        
        contentView.addSubview(imageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(ratingView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spacing: CGFloat = 8.0
        let distribution = Distribution.proportionally(resizedIndices: [1, 2], ratio: Ratio(value: 0.4))
        let verticalLayout = CascadingLayout(axis: .vertical, contents: [imageView, categoryLabel, ratingView], spacing: spacing, distribution: distribution)
        let composedLayout = InsetLayout(content: verticalLayout, inset: UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing))
        composedLayout.layout(in: bounds)
    }
}
