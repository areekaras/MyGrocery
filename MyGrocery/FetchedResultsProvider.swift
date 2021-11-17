//
//  FetchedResultsProvider.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 17/11/21.
//

import Foundation
import CoreData

protocol FetchedResultsProviderDelegate: class {
    func fetchedResultsProviderDidInsert(at indexPath: IndexPath)
    func fetchedResultsProviderDidDelete(at indexPath: IndexPath)
}

class FetchedResultsProvider<T: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate where T: ManagedObjectType {
    
    let fetchResultsContoller: NSFetchedResultsController<T>
    let managedObjectContext: NSManagedObjectContext
    weak var delegate: FetchedResultsProviderDelegate!
    
    var sections: [NSFetchedResultsSectionInfo]? {
        return fetchResultsContoller.sections
    }
    
    var numberOfSections: Int {
        return fetchResultsContoller.sections?.count ?? 0
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard let sections = sections else { return 0 }
        
        return sections[section].numberOfObjects
    }
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        
        let request = NSFetchRequest<T>(entityName: T.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        self.fetchResultsContoller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        self.fetchResultsContoller.delegate = self
        try! self.fetchResultsContoller.performFetch()
    }
    
    func object(at indexPath: IndexPath) -> T {
        return self.fetchResultsContoller.object(at: indexPath)
    }
    
    func deleteObject(at indexPath: IndexPath) {
        let object = fetchResultsContoller.object(at: indexPath)
        
        managedObjectContext.delete(object)
        try! managedObjectContext.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if type == .insert {
            delegate.fetchedResultsProviderDidInsert(at: newIndexPath!)
        } else if type == .delete {
            delegate.fetchedResultsProviderDidDelete(at: indexPath!)
        }
    }
}
