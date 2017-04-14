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
        let object = descriptor.reverseTransformer(entity)
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
        
        return descriptor.transformer(results)
    }
    
    func delete<Entity, EntityObject>(with descriptor: EntityDescriptor<Entity, EntityObject>) {
        let object = realm.object(ofType: EntityObject.self, forPrimaryKey: descriptor.primaryKey)
        if let object = object {
            try! realm.write {
                realm.delete(object)
            }
        }
    }
}
