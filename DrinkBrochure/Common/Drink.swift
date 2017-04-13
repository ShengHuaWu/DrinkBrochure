//
//  Drink.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 12/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwift

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
    let photoURL: URL
    let name: String?
    let comment: String?
}

final class DrinkObject: Object {
    dynamic var drinkID: String = UUID().uuidString
    dynamic var createdAt: Date = Date()
    dynamic var rating: Int = 0
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var category: String = ""
    dynamic var photoURLString: String = ""
    dynamic var name: String? = nil
    dynamic var comment: String? = nil
    
    override static func primaryKey() -> String? {
        return "drinkID"
    }
    
    override static func indexedProperties() -> [String] {
        return ["createdAt", "rating", "category"]
    }
}
