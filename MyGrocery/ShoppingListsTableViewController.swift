//
//  ShoppingListsTableViewController.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 16/11/21.
//

import UIKit
import CoreData

class ShoppingListsTableViewController: UITableViewController, UITextFieldDelegate {

    var managedObjectContext: NSManagedObjectContext!
    var dataProvider: FetchedResultsProvider<ShoppingList>!
    var dataSource: TableViewDataSource<UITableViewCell, ShoppingList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.populateShoppingLists()
    }
    
    private func populateShoppingLists() {
        self.dataProvider = FetchedResultsProvider(managedObjectContext: self.managedObjectContext)
        self.dataSource = TableViewDataSource(cellIdentifier: "ShoppingListTableViewCell", tableView: self.tableView, dataProvider: self.dataProvider) { (cell, shoppingList) in
            cell.textLabel?.text = shoppingList.title
        }
        self.tableView.dataSource = self.dataSource
    }
    
    private func addNewShoppingList(title: String) {
        let shoppingList = NSEntityDescription.insertNewObject(forEntityName: "ShoppingList", into: self.managedObjectContext) as! ShoppingList
        shoppingList.title = title
        try! self.managedObjectContext.save()
    }
        
    // MARK:- Table View delegates
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let addItemView = AddNewItemView(controller: self, placeholder: "Enter Shopping List") { [weak self] title in
            self?.addNewShoppingList(title: title)
        }
        return addItemView
    }

    
}
