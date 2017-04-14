//
//  EntityDescriptor.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 13/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation
import RealmSwift

struct EntityDescriptor<Entity, EntityObject: Object> {
    let primaryKey: String?
    let sortDescriptors: [SortDescriptor]
    let predicate: NSPredicate?
    let transformer: ((Results<EntityObject>) -> Entity)?
    let reverseTransformer: ((Entity) -> EntityObject)?
}

extension EntityDescriptor {
    init(sortDescriptors: [SortDescriptor], transformer: @escaping (Results<EntityObject>) -> Entity) {
        self.primaryKey = nil
        self.sortDescriptors = sortDescriptors
        self.predicate = nil
        self.transformer = transformer
        self.reverseTransformer = nil
    }
    
    init(reverseTransformer: @escaping (Entity) -> EntityObject) {
        self.primaryKey = nil
        self.sortDescriptors = []
        self.predicate = nil
        self.transformer = nil
        self.reverseTransformer = reverseTransformer
    }
    
    init(primaryKey: String) {
        self.primaryKey = primaryKey
        self.sortDescriptors = []
        self.predicate = nil
        self.transformer = nil
        self.reverseTransformer = nil
    }
}

extension SortDescriptor {
    static let createdAt = SortDescriptor(keyPath: "createdAt", ascending: false)
}
