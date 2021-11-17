//
//  ShoppingListDataProvider.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 17/11/21.
//

import Foundation
import CoreData

protocol ShoppingListDataProviderDelegate: class {
    func shoppingListDataInsert(at indexPaths: [IndexPath])
}

class ShoppingListDataProvider: NSObject, NSFetchedResultsControllerDelegate {
    
    let fetchResultsController: NSFetchedResultsController<ShoppingList>!
    weak var providerDelegate: ShoppingListDataProviderDelegate!
    
    var sections: [NSFetchedResultsSectionInfo]? {
        return fetchResultsController.sections
    }
    
    init(managedObjectContext: NSManagedObjectContext) {
        let request = NSFetchRequest<ShoppingList>(entityName: "ShoppingList")
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        fetchResultsController.delegate = self
        try! fetchResultsController.performFetch()
    }
    
    func object(at indexPath: IndexPath) -> ShoppingList {
        return fetchResultsController.object(at: indexPath)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        providerDelegate.shoppingListDataInsert(at: [newIndexPath!])
    }
}
