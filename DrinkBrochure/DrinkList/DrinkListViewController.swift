//
//  DrinkListViewController.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 19/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

// MARK: - Drink List View Controller
final class DrinkListViewController: UIViewController {
    // MARK: Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DrinkCell.self, forCellWithReuseIdentifier: DrinkCell.description())
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var emptyView: EmptyView = {
        let view = EmptyView(frame: .zero)
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    var viewModel: DrinkListViewModel!
    var addDrink: (() -> ())?
    var didSelect: (() -> ())?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let drinkCreationItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(drinkCreationAction(sender:)))
        navigationItem.rightBarButtonItem = drinkCreationItem
        
        view.addSubview(collectionView)
        view.addSubview(emptyView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let margin: CGFloat = 10.0
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout.itemSize = CGSize(width: (view.bounds.width - margin * 3.0) / 2.0, height: Geometry.drinkListItemHeight)
        layout.minimumInteritemSpacing = margin
        layout.minimumLineSpacing = margin
        
        collectionView.frame = view.bounds
        emptyView.frame = view.bounds
    }
    
    // MARK: Actions
    func drinkCreationAction(sender: UIBarButtonItem) {
        addDrink?()
    }
    
    // MARK: Public Methods
    func updateUI(with state: DrinkListState) {
        switch state {
        case .empty:
            collectionView.isHidden = true
            emptyView.isHidden = false
        case .normal:
            collectionView.isHidden = false
            emptyView.isHidden = true
        }
    }
}

// MARK: - Collection View Data Source
extension DrinkListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.state.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkCell.description(), for: indexPath)
                
        return cell
    }
}

// MARK: - Collection View Delegate
extension DrinkListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect?()
    }
}
