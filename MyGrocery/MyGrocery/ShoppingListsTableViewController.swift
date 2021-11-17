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
    var dataProvider: ShoppingListDataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.populateShoppingLists()
    }
    
    private func populateShoppingLists() {
        self.dataProvider = ShoppingListDataProvider(managedObjectContext: self.managedObjectContext)
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let shoppingList = NSEntityDescription.insertNewObject(forEntityName: "ShoppingList", into: self.managedObjectContext) as! ShoppingList
        shoppingList.title = textField.text
        try! self.managedObjectContext.save()
        textField.text = ""
        
        return textField.resignFirstResponder()
    }
    
    // MARK:- Table View delegates
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44))
        headerView.backgroundColor = .lightText
        
        let textField = UITextField(frame: headerView.frame)
        textField.placeholder = "Enter Shopping List"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.delegate = self
        
        headerView.addSubview(textField)
        
        return headerView
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = dataProvider.sections else {
            return 0
        }
        
        return sections[section].numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let shoppingList = dataProvider.object(at: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = shoppingList.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let shoppingList = dataProvider.object(at: indexPath)
            
            self.managedObjectContext.delete(shoppingList)
            try! self.managedObjectContext.save()
        }
        
        tableView.isEditing = false
    }
    
}
