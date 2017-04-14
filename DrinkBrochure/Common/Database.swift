//
//  Database.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 13/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation
import RealmSwift

final class Database {
    private let realm: Realm
    
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
    
    // TODO: Throw errors
    func createOrUpdate<Entity, EntityObject>(with descriptor: EntityDescriptor<Entity, EntityObject>, for entity: Entity) {
        guard let reverseTransformer = descriptor.reverseTransformer else {
            fatalError("Reverse transformer function should NOT be empty.")
        }
        
        let object = reverseTransformer(entity)
        try! realm.write {
            realm.add(object, update: true)
        }
    }
    
    func fetch<Entity, EntityObject>(with descriptor: EntityDescriptor<Entity, EntityObject>) -> Entity {
        var results = realm.objects(EntityObject.self)
        if let predicate = descriptor.predicate {
            results = results.filter(predicate)
        }
        
        if descriptor.sortDescriptors.count > 0 {
            results = results.sorted(by: descriptor.sortDescriptors)
        }
        
        guard let transformer = descriptor.transformer else {
            fatalError("Transformer function should NOT be empty.")
        }
        
        return transformer(results)
    }
    
    func delete<Entity, EntityObject>(with descriptor: EntityDescriptor<Entity, EntityObject>) {
        guard let primaryKey = descriptor.primaryKey else {
            fatalError("Primary key should NOT be empty.")
        }
        
        let object = realm.object(ofType: EntityObject.self, forPrimaryKey: primaryKey)
        if let object = object {
            try! realm.write {
                realm.delete(object)
            }
        }
    }
}
