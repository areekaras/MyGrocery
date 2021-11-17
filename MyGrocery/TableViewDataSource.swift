//
//  TableViewDataSource.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 17/11/21.
//

import UIKit
import CoreData

class TableViewDataSource<Cell: UITableViewCell, Model: NSManagedObject>: NSObject, UITableViewDataSource, FetchedResultsProviderDelegate where Model: ManagedObjectType {
    
    let fetchedResultsProvider: FetchedResultsProvider<Model>
    let configureCell: (Cell, Model) -> Void
    let tableView: UITableView
    let cellIdentifier: String
    
    init(cellIdentifier: String, tableView: UITableView, dataProvider: FetchedResultsProvider<Model>, configureCell: @escaping (Cell, Model) -> Void) {
        self.cellIdentifier = cellIdentifier
        self.fetchedResultsProvider = dataProvider
        self.configureCell = configureCell
        self.tableView = tableView
        
        super.init()
        self.fetchedResultsProvider.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsProvider.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsProvider.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        let model = fetchedResultsProvider.object(at: indexPath)
        configureCell(cell, model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fetchedResultsProvider.deleteObject(at: indexPath)
        }
        
        tableView.isEditing = false
    }
    
    func fetchedResultsProviderDidInsert(at indexPath: IndexPath) {
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func fetchedResultsProviderDidDelete(at indexPath: IndexPath) {
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    
}
