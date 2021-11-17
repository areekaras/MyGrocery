//
//  ShoppingListsTableViewController.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 16/11/21.
//

import UIKit
import CoreData

class ShoppingListsTableViewController: UITableViewController, UITextFieldDelegate, AddNewItemViewDelegate {

    var managedObjectContext: NSManagedObjectContext!
    var dataProvider: ShoppingListDataProvider!
    var dataSource: ShoppingListDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.populateShoppingLists()
    }
    
    private func populateShoppingLists() {
        self.dataProvider = ShoppingListDataProvider(managedObjectContext: self.managedObjectContext)
        self.dataSource = ShoppingListDataSource(cellIdentifier: "ShoppingListTableViewCell", tableView: self.tableView, dataProvider: self.dataProvider)
        self.tableView.dataSource = self.dataSource
    }
    
    func addNewItemViewDidAddNewText(text: String) {
        addNewShoppingList(title: text)
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
        let addItemView = AddNewItemView(controller: self, placeholder: "Enter Shopping List")
        addItemView.delegate = self
        return addItemView
    }

    
}
