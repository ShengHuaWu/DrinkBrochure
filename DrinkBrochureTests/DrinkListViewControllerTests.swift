//
//  DrinkListViewControllerTests.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 19/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import FBSnapshotTestCase
@testable import DrinkBrochure

class DrinkListViewControllerTests: FBSnapshotTestCase {
    // MARK: - Override Methods
    override func setUp() {
        super.setUp()
        
        recordMode = false
    }
    
    // MARK: - Enabled Tests
    func testEmptyMode() {        
        let drinkListVC = DrinkListViewController()
        
        drinkListVC.mode = .empty
        
        FBSnapshotVerifyView(drinkListVC.view)
    }
    
    func testNormalMode() {
        let drinkListVC = DrinkListViewController()
        
        drinkListVC.mode = .normal
        
        FBSnapshotVerifyView(drinkListVC.view)
    }
}
