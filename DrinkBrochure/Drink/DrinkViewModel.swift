//
//  DrinkViewModel.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 27/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation

final class DrinkViewModel {
    private(set) var state: DrinkState {
        didSet {
            callback(state)
        }
    }
    
    private let callback: (DrinkState) -> ()
    
    init(state: DrinkState, callback: @escaping (DrinkState) -> ()) {
        self.state = state
        self.callback = callback
        
        self.callback(self.state)
    }
}