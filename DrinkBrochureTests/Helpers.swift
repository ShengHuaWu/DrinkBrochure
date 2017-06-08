//
//  Helpers.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 15/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation
import CoreLocation
@testable import DrinkBrochure

// MARK: - Seed Data
extension Drink {
    static let beer = Drink(rating: .good, location: CLLocation(latitude: 0.0, longitude: 0.0), category: .beer, name: "Good Beer", comment: "This is beer.")
    static let wine = Drink(rating: .mediocre, location: CLLocation(latitude: 20.0, longitude: 100.0), category: .wine, comment: "This is wine.")
    static let whiskey = Drink(rating: .notRecommended, location: CLLocation(latitude: 5.0, longitude: 70.0), category: .whiskey, name: "Not Recommended")
    static let sake = Drink(rating: .veryGood, location: CLLocation(latitude: 10.0, longitude: 30.0), category: .sake, name: "Sake", comment: "This is very good.")
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
