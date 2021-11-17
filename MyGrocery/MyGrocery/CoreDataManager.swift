//
//  CoreDataManager.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 16/11/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    var managedObjectContext: NSManagedObjectContext!
    
    func initializeCoreDataStack() {
        guard let dataModelUrl = Bundle.main.url(forResource: "MyGroceryDataModel", withExtension: ".momd") else {
            fatalError("Unable to find MyGroceryDataModel")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: dataModelUrl) else {
            fatalError("Unable to initialize managedObjectModel")
        }
        let persistantStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let fileManager = FileManager()
        guard let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to find Document Url")
        }
        let storeUrl = documentUrl.appendingPathComponent("MyGrocery.sqlite")
//        print(storeUrl)
        
        try! persistantStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: nil)
        
        let concurrencyType = NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType
        managedObjectContext = NSManagedObjectContext(concurrencyType: concurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistantStoreCoordinator
        
    }
}
