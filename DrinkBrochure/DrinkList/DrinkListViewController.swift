//
//  DrinkListViewController.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 19/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

class DrinkListViewController: UIViewController {
    // MARK: - Mode
    enum Mode {
        case empty
        case normal
    }
    
    // MARK: - Private Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.description())
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var emptyView: EmptyView = {
        let view = EmptyView(frame: .zero)
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    var mode: Mode = .normal {
        didSet {
            switch mode {
            case .empty:
                collectionView.isHidden = true
                emptyView.isHidden = false
            case .normal:
                collectionView.isHidden = false
                emptyView.isHidden = true
            }
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        view.addSubview(emptyView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.frame = view.bounds
        emptyView.frame = view.bounds
    }
}

// MARK: - Collection View Data Source
extension DrinkListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.description(), for: indexPath)
        
        cell.backgroundColor = UIColor.red
        
        return cell
    }
}
