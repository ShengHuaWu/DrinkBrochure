//
//  DrinkViewController.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 21/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

final class DrinkViewController: UIViewController {
    // MARK: - Mode
    enum Mode {
        case creation
        case editing
        case presentation
    }
    
    // MARK: - Properties
    private lazy var drinkView: DrinkView = {
        let view = DrinkView()
        return view
    }()
    
    let mode: Mode
    
    // MARK: - Designated Initializer
    init(mode: Mode) {
        self.mode = mode
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(drinkView)

        if mode.shouldShowCancelItem {
            let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction(sender:)))
            navigationItem.leftBarButtonItem = cancelItem
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        drinkView.frame = view.bounds
    }
    
    // MARK: - Actions
    func cancelAction(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Drink View Controller Mode Extension
extension DrinkViewController.Mode {
    var shouldShowCancelItem: Bool {
        switch self {
        case .presentation:
            return false
        default:
            return true
        }
    }
}
