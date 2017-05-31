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
        
        database.createOrUpdate(model: beer, with: DrinkObject.init)
        
        database.verifyDrinkCreationOrUpdating(newDrink: beer)
    }
    
    func testDrinkDeletion() {
        let wine = Drink.wine
        database.createOrUpdate(model: wine, with: DrinkObject.init)
        let wineInDB = database.fetch(with: Drink.all).first!

        database.delete(type: DrinkObject.self, with: wineInDB.drinkID)
        
        database.verifyDrinkDeletion()
    }
    
    func testDrinkUpdating() {
        let whiskey = Drink.whiskey
        database.createOrUpdate(model: whiskey, with: DrinkObject.init)
        let whiskeyInDB = database.fetch(with: Drink.all).first!
        
        let newDrink = Drink(drinkID: whiskeyInDB.drinkID, createdAt: whiskeyInDB.createdAt, rating: .outstanding, location: whiskeyInDB.location, category: .other(name: "unknown"), name: nil, comment: "Excellent!")
        database.createOrUpdate(model: newDrink, with: DrinkObject.init)
        
        database.verifyDrinkCreationOrUpdating(newDrink: newDrink)
    }
    
    func testDrinkFetchingWithName() {
        Drink.many.forEach { database.createOrUpdate(model: $0, with: DrinkObject.init) }
        
        let results = database.fetch(with: Drink.name("sa"))
        
        database.verifyDrinkFetching(results: results, expectedDrink: Drink.sake)
    }
    
    func testDrinkFetchingWithRating() {
        Drink.many.forEach { database.createOrUpdate(model: $0, with: DrinkObject.init) }

        let results = database.fetch(with: Drink.rating(.mediocre))
        
        database.verifyDrinkFetching(results: results, expectedDrink: Drink.wine)
    }
    
    func testDrinkFetchingWithCategory() {
        Drink.many.forEach { database.createOrUpdate(model: $0, with: DrinkObject.init) }

        let results = database.fetch(with: Drink.category(.whiskey))
        
        database.verifyDrinkFetching(results: results, expectedDrink: Drink.whiskey)
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
        XCTAssertEqual(drinkInDB.name, newDrink.name, "name", file: file, line: line)
        XCTAssertEqual(drinkInDB.comment, newDrink.comment, "comment", file: file, line: line)
    }
    
    func verifyDrinkDeletion(file: StaticString = #file, line: UInt = #line) {
        let results = fetch(with: Drink.all)
        XCTAssertEqual(results.count, 0, "results count", file: file, line: line)
    }
    
    func verifyDrinkFetching(results: [Drink], expectedDrink: Drink, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(results.count, 1, "results count", file: file, line: line)
        
        let drinkInDB = results.first!
        XCTAssert(drinkInDB.drinkID.characters.count > 0, "drink ID is empty", file: file, line: line)
        XCTAssertEqual(drinkInDB.createdAt, expectedDrink.createdAt, "createdAt", file: file, line: line)
        XCTAssertEqual(drinkInDB.rating, expectedDrink.rating, "rating", file: file, line: line)
        XCTAssertEqual(drinkInDB.location.coordinate.latitude, expectedDrink.location.coordinate.latitude, "location latitude", file: file, line: line)
        XCTAssertEqual(drinkInDB.location.coordinate.longitude, expectedDrink.location.coordinate.longitude, "location longitude", file: file, line: line)
        XCTAssertEqual(drinkInDB.category, expectedDrink.category, "category", file: file, line: line)
        XCTAssertEqual(drinkInDB.name, expectedDrink.name, "name", file: file, line: line)
        XCTAssertEqual(drinkInDB.comment, expectedDrink.comment, "comment", file: file, line: line)
    }
}
