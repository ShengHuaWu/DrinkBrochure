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

// MARK: - Seed Data
extension Drink {
    static let beer = Drink(drinkID: "", createdAt: Date(), rating: .good, location: CLLocation(latitude: 0.0, longitude: 0.0), category: .beer, photoURL: URL(string: "https://developer.apple.com")!, name: "Good Beer", comment: "This is beer.")
    static let wine = Drink(drinkID: "", createdAt: Date(), rating: .mediocre, location: CLLocation(latitude: 20.0, longitude: 100.0), category: .wine, photoURL: URL(string: "https://developer.apple.com")!, name: nil, comment: "This is wine.")
    static let whiskey = Drink(drinkID: "", createdAt: Date(), rating: .notRecommended, location: CLLocation(latitude: 5.0, longitude: 70.0), category: .whiskey, photoURL: URL(string: "https://developer.apple.com")!, name: "Not Recommended", comment: "This is bad whiskey.")
    static let sake = Drink(drinkID: "", createdAt: Date(), rating: .veryGood, location: CLLocation(latitude: 10.0, longitude: 30.0), category: .sake, photoURL: URL(string: "https://developer.apple.com")!, name: "Sake", comment: "This is very good.")
    static let many = [beer, wine, whiskey, sake]
}

// MARK: - Drink Category Extension
extension Drink.Category: Equatable {
    public static func ==(lhs: Drink.Category, rhs: Drink.Category) -> Bool {
        switch (lhs, rhs) {
        case (.beer, .beer):
            return true
        case (.wine, .wine):
            return true
        case (.whiskey, .whiskey):
            return true
        case (.sake, .sake):
            return true
        case let (.other(leftName), .other(rightName)):
            return leftName == rightName
        default:
            return false
        }
    }
}
