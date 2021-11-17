//
//  ShoppingListDataProvider.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 17/11/21.
//

import Foundation
import CoreData

protocol ShoppingListDataProviderDelegate: class {
    func shoppingListDataProviderDidInsert(at indexPath: IndexPath)
    func shoppingListDataProviderDidDelete(at indexPath: IndexPath)
}

class ShoppingListDataProvider: NSObject, NSFetchedResultsControllerDelegate {
    
    let fetchResultsController: NSFetchedResultsController<ShoppingList>!
    let managedObjectContext: NSManagedObjectContext!
    weak var delegate: ShoppingListDataProviderDelegate!
    
    var sections: [NSFetchedResultsSectionInfo]? {
        return fetchResultsController.sections
    }
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        
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
    
    func deleteObject(at indexPath: IndexPath) {
        let shoppingList = object(at: indexPath)
        
        self.managedObjectContext.delete(shoppingList)
        try! self.managedObjectContext.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if type == .insert {
            delegate.shoppingListDataProviderDidInsert(at: newIndexPath!)
        } else if type == .delete {
            delegate.shoppingListDataProviderDidDelete(at: indexPath!)
        }
        
    }
}
