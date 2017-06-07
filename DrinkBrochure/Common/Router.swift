//
//  Router.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 11/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

struct Router {
    func configure(_ window: UIWindow?) {
        let drinkListVC = DrinkListViewController()
        let navigationController = UINavigationController(rootViewController: drinkListVC)
        configure(drinkListVC, in: navigationController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func configure(_ drinkListViewController: DrinkListViewController, in navigationController: UINavigationController) {
        let viewModel = DrinkListViewModel(state: .normal) { [weak viewController = drinkListViewController] (state) in
            viewController.flatMap { $0.updateUI(with: state) }
        }
        drinkListViewController.viewModel = viewModel
        
        drinkListViewController.addDrink = { [weak viewController = drinkListViewController] in
            guard let strongDrinkListVC = viewController else { return }
            
            let drinkVC = DrinkViewController()
            self.configure(drinkVC, with: .creation)
            let navigationController = UINavigationController(rootViewController: drinkVC)
            strongDrinkListVC.present(navigationController, animated: true, completion: nil)
        }
        
        drinkListViewController.didSelect = {
            let drinkVC = DrinkViewController()
            self.configure(drinkVC, with: .presentation)
            navigationController.pushViewController(drinkVC, animated: true)
        }
    }
    
    func configure(_ drinkViewController: DrinkViewController, with state: DrinkState) {
        let viewModel = DrinkViewModel(state: state) { [weak viewController = drinkViewController] (state) in
            viewController.flatMap { $0.updateUI(with: state) }
        }
        drinkViewController.viewModel = viewModel
        
        drinkViewController.presentCamera = { [weak viewController = drinkViewController] in
            guard let strongDrinkVC = viewController,
                let imagePicker = UIImagePickerController(config: UIImagePickerController.cameraImage) else { return }
            
            imagePicker.delegate = strongDrinkVC
            strongDrinkVC.present(imagePicker, animated: true, completion: nil)
        }
        
        drinkViewController.presentPhotoLibrary = { [weak viewController = drinkViewController] in
            guard let strongDrinkVC = viewController,
                let imagePicker = UIImagePickerController(config: UIImagePickerController.photoLibraryImage) else { return }
            
            imagePicker.delegate = strongDrinkVC
            strongDrinkVC.present(imagePicker, animated: true, completion: nil)
        }
        
        drinkViewController.didSelectImage = { [weak viewController = drinkViewController] in
            guard let strongDrinkVC = viewController else { return }
            
            let actionSheet = UIAlertController.makeImagePickerActionSheet(cameraHandler: strongDrinkVC.presentCamera!, photoLibraryHandler: strongDrinkVC.presentPhotoLibrary!)
            strongDrinkVC.present(actionSheet, animated: true, completion: nil)
        }
    }
}
