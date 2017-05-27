//
//  DrinkListState.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 27/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation

enum DrinkListState {
    case empty
    case normal
}

extension DrinkListState {
    var count: Int {
        return 20
    }
}
