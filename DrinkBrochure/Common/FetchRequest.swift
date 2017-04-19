//
//  FetchRequest.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 18/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Fetch Request
struct FetchRequest<Model, RealmObject: Object> {
    let predicate: NSPredicate?
    let sortDescriptors: [SortDescriptor]
    let transformer: (Results<RealmObject>) -> Model
}

// MARK: - Sort Descriptor Extension
extension SortDescriptor {
    static let createdAt = SortDescriptor(keyPath: "createdAt", ascending: false)
}

// MARK: - Drink Request
extension Drink {
    static let all = FetchRequest<[Drink], DrinkObject>(predicate: nil, sortDescriptors: [SortDescriptor.createdAt], transformer: { $0.map(Drink.init) })
    
    static func name(_ name: String) -> FetchRequest<[Drink], DrinkObject> {
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
        return FetchRequest(predicate: predicate, sortDescriptors: [SortDescriptor.createdAt], transformer: { $0.map(Drink.init) })
    }
    
    static func rating(_ rating: RatingScale) -> FetchRequest<[Drink], DrinkObject> {
        let predicate = NSPredicate(format: "rating == %i", rating.rawValue)
        return FetchRequest(predicate: predicate, sortDescriptors: [SortDescriptor.createdAt], transformer: { $0.map(Drink.init) })
    }
    
    static func category(_ category: Category) -> FetchRequest<[Drink], DrinkObject> {
        let predicate = NSPredicate(format: "category == %@", category.description)
        return FetchRequest(predicate: predicate, sortDescriptors: [SortDescriptor.createdAt], transformer: { $0.map(Drink.init) })
    }
}
