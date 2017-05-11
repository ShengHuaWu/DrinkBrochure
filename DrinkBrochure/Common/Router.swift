//
//  Router.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 11/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

final class Router {
    func configure(window: UIWindow) {
        let drinkListVC = DrinkListViewController()
        let navigationController = UINavigationController(rootViewController: drinkListVC)
        configure(drinkListViewController: drinkListVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func configure(drinkListViewController: DrinkListViewController) {
        drinkListViewController.mode = .normal
        drinkListViewController.addDrink = { [weak viewController = drinkListViewController, weak self] in
            guard let strongDrinkListVC = viewController,
                let strongSelf = self else { return }
            
            let drinkVC = DrinkViewController(mode: .creation)
            strongSelf.configure(drinkViewController: drinkVC)
            let navigationController = UINavigationController(rootViewController: drinkVC)
            strongDrinkListVC.present(navigationController, animated: true, completion: nil)
        }
        drinkListViewController.didSelect = { [weak viewController = drinkListViewController, weak self] in
            guard let strongDrinkListVC = viewController,
                let strongSelf = self else { return }
            
            let drinkVC = DrinkViewController(mode: .presentation)
            strongSelf.configure(drinkViewController: drinkVC)
            strongDrinkListVC.navigationController?.pushViewController(drinkVC, animated: true)
        }
    }
    
    func configure(drinkViewController: DrinkViewController) {
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
