//
//  EntityDescriptor.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 13/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation
import RealmSwift

enum EntityDescriptor<Entity, EntityObject: Object> {
    typealias Transformer = (Results<EntityObject>) -> Entity
    typealias ReverseTransformer = (Entity) -> EntityObject
    
    case createOrUpdate(reverseTransformer: ReverseTransformer)
    case fetch(predicate: NSPredicate?, sortDescriptors: [SortDescriptor], transformer: Transformer)
    case delete(primaryKey: String)
}

extension EntityDescriptor {
    var reverseTransformer: ReverseTransformer {
        switch self {
        case let .createOrUpdate(reverseTransformer):
            return reverseTransformer
        default:
            fatalError("fetch and delete do NOT have reverse transformer function.")
        }
    }
    
    var predicate: NSPredicate? {
        switch self {
        case let .fetch(predicate, _, _):
            return predicate
        default:
            fatalError("createOrUpdate and delete do NOT have predicate.")
        }
    }
    
    var sortDescriptors: [SortDescriptor] {
        switch self {
        case let .fetch(_, sortDescriptors, _):
            return sortDescriptors
        default:
            fatalError("createOrUpdate and delete do NOT have sort descriptors.")
        }
    }
    
    var transformer: Transformer {
        switch self {
        case let .fetch(_, _, transformer):
            return transformer
        default:
            fatalError("createOrUpdate and delete do NOT have tranformer function.")
        }
    }
    
    var primaryKey: String {
        switch self {
        case let .delete(primaryKey):
            return primaryKey
        default:
            fatalError("createOrUpdate and fetch do NOT have primary key.")
        }
    }
}

extension SortDescriptor {
    static let createdAt = SortDescriptor(keyPath: "createdAt", ascending: false)
}
