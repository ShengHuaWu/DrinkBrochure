//
//  DrinkObject.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 18/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Drink Realm Object
final class DrinkObject: Object {
    dynamic var drinkID: String = UUID().uuidString
    dynamic var createdAt: Date = Date()
    dynamic var rating: Int = 0
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var category: String = ""
    dynamic var name: String? = nil
    dynamic var comment: String? = nil
    
    override static func primaryKey() -> String? {
        return "drinkID"
    }
    
    override static func indexedProperties() -> [String] {
        return ["createdAt", "rating", "category"]
    }
}

// MARK: - Drink Realm Object Custom Initializer
extension DrinkObject {
    convenience init(drink: Drink) {
        self.init()
        
        if drink.drinkID.characters.count > 0 {
            self.drinkID = drink.drinkID
        }
        
        self.createdAt = drink.createdAt
        self.rating = drink.rating.rawValue
        self.latitude = drink.location.coordinate.latitude
        self.longitude = drink.location.coordinate.longitude
        self.category = drink.category.description
        self.name = drink.name
        self.comment = drink.comment
    }
}
