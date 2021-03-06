//
//  ShoppingListDataSource.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 17/11/21.
//

import UIKit

class ShoppingListDataSource: NSObject, UITableViewDataSource, ShoppingListDataProviderDelegate {
    
    let dataProvider: ShoppingListDataProvider!
    let tableView: UITableView!
    let cellIdentifier: String
    
    init(cellIdentifier: String, tableView: UITableView, dataProvider: ShoppingListDataProvider) {
        self.cellIdentifier = cellIdentifier
        self.tableView = tableView
        self.dataProvider = dataProvider
        
        super.init()
        self.dataProvider.delegate = self
    }
    
    func shoppingListDataProviderDidInsert(at indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func shoppingListDataProviderDidDelete(at indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = dataProvider.sections else {
            return 0
        }
        
        return sections[section].numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let shoppingList = dataProvider.object(at: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        cell.textLabel?.text = shoppingList.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataProvider.deleteObject(at: indexPath)
        }
        
        tableView.isEditing = false
    }
}
