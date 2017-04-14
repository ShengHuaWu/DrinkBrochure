//
//  DatabaseTests.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 13/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import XCTest
import RealmSwift
import CoreLocation
@testable import DrinkBrochure

class DatabaseTests: XCTestCase {
    // MARK: - Properties
    var database: Database!
    
    // MARK: - Override Methods
    override func setUp() {
        super.setUp()
        
        let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "com.shenghuawu.DrinkBrochure.test"))
        database = Database(realm: realm)
    }
    
    override func tearDown() {
        database = nil
        
        super.tearDown()
    }
    
    // MAEK: - Enabled Tests
    func testCreateAndDeleteDrink() {
        let newDrink = Drink.one
        database.createOrUpdate(with: Drink.createOrUpdate, for: newDrink)
        
        var results = database.fetch(with: Drink.all)
        XCTAssert(results.count == 1)
        
        let drinkInDB = results.first!
        XCTAssert(drinkInDB.drinkID.characters.count > 0)
        XCTAssert(drinkInDB.name == newDrink.name)
        XCTAssert(drinkInDB.comment == newDrink.comment)
        
        database.delete(with: drinkInDB.delete)
        
        results = database.fetch(with: Drink.all)
        XCTAssert(results.count == 0)
    }
}

// MARK: - Seed Data
extension Drink {
    static let one = Drink(drinkID: "", createdAt: Date(), rating: .good, location: CLLocation(latitude: 0.0, longitude: 0.0), category: .beer, photoURL: URL(string: "https://developer.apple.com")!, name: "Good Beer", comment: "This is a beer")
}
