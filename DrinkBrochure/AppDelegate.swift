//
//  AppDelegate.swift
//  DrinkBrochure
//
//  Created by ShengHua Wu on 12/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        let router = RootRouter()
        router.configure(window: window!)
        
        return true
    }
}

final class RootRouter {
    func configure(window: UIWindow) {
        let drinkListVC = DrinkListViewController()
        let navigationController = UINavigationController(rootViewController: drinkListVC)
        configure(drinkListViewController: drinkListVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func configure(drinkListViewController: DrinkListViewController) {
        drinkListViewController.mode = .normal
        drinkListViewController.onCreate = { [weak viewController = drinkListViewController] in
            guard let strongDrinkListVC = viewController else { return }
            
            let drinkVC = DrinkViewController(mode: .creation)
            let navigationController = UINavigationController(rootViewController: drinkVC)
            strongDrinkListVC.present(navigationController, animated: true, completion: nil)
        }
        drinkListViewController.didSelect = { [weak viewController = drinkListViewController] in
            guard let strongDrinkListVC = viewController else { return }

            let drinkVC = DrinkViewController(mode: .presentation)
            strongDrinkListVC.navigationController?.pushViewController(drinkVC, animated: true)
        }
    }
}
