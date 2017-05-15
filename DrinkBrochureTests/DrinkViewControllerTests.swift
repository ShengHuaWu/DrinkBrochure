//
//  DrinkViewControllerTests.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 21/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import FBSnapshotTestCase
@testable import DrinkBrochure

class DrinkViewControllerTests: FBSnapshotTestCase {
    // MARK: - Overrider Methods
    override func setUp() {
        super.setUp()
        
        recordMode = false
    }
    
    // MARK: - Enabled Tests
    func testCreationMode() {
        let drinkVC = DrinkViewController(mode: .creation)
        
        FBSnapshotVerifyView(drinkVC.view)
    }
    
    func testEditingMode() {
        let drinkVC = DrinkViewController(mode: .editing)
        
        FBSnapshotVerifyView(drinkVC.view)
    }
    
    func testPresentationMode() {
        let drinkVC = DrinkViewController(mode: .presentation)
        
        FBSnapshotVerifyView(drinkVC.view)
    }
}
