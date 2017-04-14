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

// MARK: - Drink
struct Drink {
    enum RatingScale: Int {
        case notRecommended = 0
        case mediocre
        case good
        case veryGood
        case outstanding
    }
    
    enum Category: CustomStringConvertible {
        case beer
        case wine
        case whiskey
        case sake
        case other(name: String)
        
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
        
        init(string: String) {
            switch string {
            case "beer":
                self = .beer
            case "wine":
                self = .wine
            case "whiskey":
                self = .whiskey
            case "sake":
                self = .sake
            default:
                self = .other(name: string)
            }
        }
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

// MARK: - Drink Realm Object
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

// MARK: - Drink Custom Initializer
extension Drink {
    // TODO: Perhaps throw error?
    init(object: DrinkObject) {
        guard let rating = RatingScale(rawValue: object.rating) else {
            fatalError("Rating is invalid")
        }
        
        let location = CLLocation(latitude: object.latitude, longitude: object.longitude)
        let category = Category(string: object.category)
        
        guard let url = URL(string: object.photoURLString) else {
            fatalError("Photo URL is invalid")
        }
        
        self.drinkID = object.drinkID
        self.createdAt = object.createdAt
        self.rating = rating
        self.location = location
        self.category = category
        self.photoURL = url
        self.name = object.name
        self.comment = object.comment
    }
}

// MARK: - Drink Realm Object Custom Initializer
extension DrinkObject {
    convenience init(drink: Drink) {
        self.init()
        
        self.createdAt = drink.createdAt
        self.rating = drink.rating.rawValue
        self.latitude = drink.location.coordinate.latitude
        self.longitude = drink.location.coordinate.longitude
        self.category = drink.category.description
        self.photoURLString = drink.photoURL.absoluteString
        self.name = drink.name
        self.comment = drink.comment
    }
}

// MARK: - Drink Descriptors
extension Drink {
    static let all: EntityDescriptor<[Drink], DrinkObject> = .fetch(predicate: nil, sortDescriptors: [SortDescriptor.createdAt], transformer: { $0.map(Drink.init) })
    
    static let createOrUpdate: EntityDescriptor<Drink, DrinkObject> = .createOrUpdate(reverseTransformer: { DrinkObject(drink: $0) })
    
    var delete: EntityDescriptor<Drink, DrinkObject> {
        return .delete(primaryKey: drinkID)
    }
}
