//
//  Drink.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 12/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation
import CoreLocation

struct Drink {
    enum RatingScale {
        case notRecommended
        case mediocre
        case good
        case veryGood
        case outstanding
    }
    
    enum Category {
        case beer
        case wine
        case whisky
        case sake
        case other(name: String)
    }
    
    let UUID: String
    let createdAt: Date
    let rating: RatingScale
    let location: CLLocation
    let category: Category
    let photoURL: URL
    let name: String
    let comment: String
}
