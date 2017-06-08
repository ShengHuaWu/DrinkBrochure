//
//  DrinkViewModel.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 27/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit
import CoreLocation

final class DrinkViewModel {
    // MARK: Properties
    private(set) var state: DrinkState {
        didSet {
            callback(state)
        }
    }
    
    private let callback: (DrinkState) -> ()
    private let database: Database
    private let imageProvider: ImageProvider
    
    // MARK: Designated Initializer
    init(state: DrinkState, database: Database = Database(), imageProvider: ImageProvider = ImageProvider(), callback: @escaping (DrinkState) -> ()) {
        self.state = state
        self.database = database
        self.imageProvider = imageProvider
        self.callback = callback
        
        self.callback(self.state)
    }
    
    // MARK: Public Methods
    func switchToPresentation() {
        state = .presentation
    }
    
    func switchToEditing() {
        state = .editing
    }
    
    func createDrink(with image: UIImage) {
        let newDrink = Drink(rating: .notRecommended, location: CLLocation(latitude: 0, longitude: 0), category: .beer)
        database.createOrUpdate(model: newDrink, with: DrinkObject.init)
        
        do {
            try imageProvider.save(image, to: newDrink.photoURL())
        } catch {
            print(error.localizedDescription)
        }
    }
}
