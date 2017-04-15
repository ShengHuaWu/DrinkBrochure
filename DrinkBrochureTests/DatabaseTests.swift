//
//  DatabaseTests.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 13/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import XCTest
import RealmSwift
@testable import DrinkBrochure

class DatabaseTests: XCTestCase {
    // MARK: - Properties
    var database: Database!
    
    // MARK: - Override Methods
    override func setUp() {
        super.setUp()
        
        let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "com.shenghuawu.DrinkBrochure"))
        database = Database(realm: realm)
    }
    
    override func tearDown() {
        database.deleteAll()
        database = nil
        
        super.tearDown()
    }
    
    // MAEK: - Enabled Tests
    func testDrinkCreation() {
        let beer = Drink.beer
        
        database.createOrUpdate(with: Drink.createOrUpdate, for: beer)
        
        database.verifyDrinkCreationOrUpdating(newDrink: beer)
    }
    
    func testDrinkDeletion() {
        let wine = Drink.wine
        database.createOrUpdate(with: Drink.createOrUpdate, for: wine)
        let wineInDB = database.fetch(with: Drink.all).first!

        database.delete(with: wineInDB.delete)
        
        database.verifyDrinkDeletion()
    }
    
    func testDrinkUpdating() {
        let whiskey = Drink.whiskey
        database.createOrUpdate(with: Drink.createOrUpdate, for: whiskey)
        let whiskeyInDB = database.fetch(with: Drink.all).first!
        
        let newDrink = Drink(drinkID: whiskeyInDB.drinkID, createdAt: whiskeyInDB.createdAt, rating: .outstanding, location: whiskeyInDB.location, category: .other(name: "unknown"), photoURL: URL(string: "https://google.com")!, name: nil, comment: "Excellent!")
        database.createOrUpdate(with: Drink.createOrUpdate, for: newDrink)
        
        database.verifyDrinkCreationOrUpdating(newDrink: newDrink)
    }
}

// MARK: - Verify
extension Database {
    func verifyDrinkCreationOrUpdating(newDrink: Drink, file: StaticString = #file, line: UInt = #line) {
        let results = fetch(with: Drink.all)
        XCTAssertEqual(results.count, 1, "results count", file: file, line: line)

        let drinkInDB = results.first!
        XCTAssert(drinkInDB.drinkID.characters.count > 0, "drink ID is empty", file: file, line: line)
        XCTAssertEqual(drinkInDB.createdAt, newDrink.createdAt, "createdAt", file: file, line: line)
        XCTAssertEqual(drinkInDB.rating, newDrink.rating, "rating", file: file, line: line)
        XCTAssertEqual(drinkInDB.location.coordinate.latitude, newDrink.location.coordinate.latitude, "location latitude", file: file, line: line)
        XCTAssertEqual(drinkInDB.location.coordinate.longitude, newDrink.location.coordinate.longitude, "location longitude", file: file, line: line)
        XCTAssertEqual(drinkInDB.category, newDrink.category, "category", file: file, line: line)
        XCTAssertEqual(drinkInDB.photoURL, newDrink.photoURL, "photo URL", file: file, line: line)
        XCTAssertEqual(drinkInDB.name, newDrink.name, "name", file: file, line: line)
        XCTAssertEqual(drinkInDB.comment, newDrink.comment, "comment", file: file, line: line)
    }
    
    func verifyDrinkDeletion(file: StaticString = #file, line: UInt = #line) {
        let results = fetch(with: Drink.all)
        XCTAssertEqual(results.count, 0, "results count", file: file, line: line)
    }
}
