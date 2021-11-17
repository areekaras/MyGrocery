//
//  ShoppingListDataProvider.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 17/11/21.
//

import Foundation
import CoreData

class ShoppingListDataProvider: NSObject, NSFetchedResultsControllerDelegate {
    
    var fetchResultsController: NSFetchedResultsController<ShoppingList>!
    
    var sections: [NSFetchedResultsSectionInfo]? {
        return fetchResultsController.sections
    }
    
    init(managedObjectContext: NSManagedObjectContext) {
        super.init()
        
        let request = NSFetchRequest<ShoppingList>(entityName: "ShoppingList")
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self
        try! fetchResultsController.performFetch()
    }
    
    func object(at indexPath: IndexPath) -> ShoppingList {
        return fetchResultsController.object(at: indexPath)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    }
}
