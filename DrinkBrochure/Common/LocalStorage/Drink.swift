//
//  Drink.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 12/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: - Drink
struct Drink {
    enum RatingScale: Int {
        case notRecommended = 0
        case mediocre
        case good
        case veryGood
        case outstanding
    }
    
    enum Category {
        case beer
        case wine
        case whiskey
        case sake
        case other(name: String)
    }
    
    let drinkID: String
    let createdAt: Date
    let rating: RatingScale
    let location: CLLocation
    let category: Category
    let name: String?
    let comment: String?
}

// MARK: - Drink Category Extension
extension Drink.Category: CustomStringConvertible {
    var description: String {
        switch self {
        case .beer:
            return "beer"
        case .wine:
            return "wine"
        case .whiskey:
            return "whiskey"
        case .sake:
            return "sake"
        case let .other(name):
            return name
        }
    }
    
    init(name: String) {
        switch name {
        case "beer":
            self = .beer
        case "wine":
            self = .wine
        case "whiskey":
            self = .whiskey
        case "sake":
            self = .sake
        default:
            self = .other(name: name)
        }
    }
}

// MARK: - Drink Custom Initializer
extension Drink {
    // TODO: Throw error?
    init(object: DrinkObject) {
        guard let rating = RatingScale(rawValue: object.rating) else {
            fatalError("Rating is invalid")
        }
        
        let location = CLLocation(latitude: object.latitude, longitude: object.longitude)
        let category = Category(name: object.category)
        
        self.drinkID = object.drinkID
        self.createdAt = object.createdAt
        self.rating = rating
        self.location = location
        self.category = category
        self.name = object.name
        self.comment = object.comment
    }
}
