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
}
