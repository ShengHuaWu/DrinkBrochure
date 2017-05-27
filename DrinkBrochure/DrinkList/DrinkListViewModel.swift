//
//  DrinkListViewModel.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 27/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation

final class DrinkListViewModel {
    private(set) var state: DrinkListState {
        didSet {
            callback(state)
        }
    }
    
    private let callback: (DrinkListState) -> ()
    
    init(state: DrinkListState, callback: @escaping (DrinkListState) -> ()) {
        self.state = state
        self.callback = callback
        
        self.callback(self.state)
    }
}
