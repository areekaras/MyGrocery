//
//  SceneDelegate.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 16/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let coreDataManager = CoreDataManager()
        coreDataManager.initializeCoreDataStack()
        
        guard let nc = self.window?.rootViewController as? UINavigationController else {
            fatalError("RootViewController cannot found!")
        }
        
        guard let shoppingListVC = nc.viewControllers.first as? ShoppingListsTableViewController else {
            fatalError("ShoppingListsTableViewController cannot found")
        }
        
        shoppingListVC.managedObjectContext = coreDataManager.managedObjectContext
    }

}

