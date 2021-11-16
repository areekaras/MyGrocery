//
//  ShoppingListsTableViewController.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 16/11/21.
//

import UIKit
import CoreData

class ShoppingListsTableViewController: UITableViewController, UITextFieldDelegate, NSFetchedResultsControllerDelegate {

    var managedObjectContext: NSManagedObjectContext!
    var fetchResultsController: NSFetchedResultsController<ShoppingList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initializeCoreDataStack()
        self.populateShoppingLists()
    }
    
    func initializeCoreDataStack() {
        guard let bundleUrl = Bundle.main.url(forResource: "MyGroceryDataModel", withExtension: ".momd") else {
            fatalError("Could not find MyGroceryDataModel")
        }
        
        guard let managedObjecModel = NSManagedObjectModel(contentsOf: bundleUrl) else {
            fatalError("Unable to initialize managedObjectModel")
        }
        
        let persistantStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjecModel)
        
        let fileManager = FileManager()
        guard let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to get Document Url")
        }
        
        let storeUrl = documentUrl.appendingPathComponent("MyGrocery.sqlite")
        
        print(storeUrl)
        
        try! persistantStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: nil)
        
        let concurrencyType = NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: concurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = persistantStoreCoordinator
        
    }
    
    private func populateShoppingLists() {
        let request = NSFetchRequest<ShoppingList>(entityName: "ShoppingList")
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self
        try! fetchResultsController.performFetch()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            self.tableView.insertRows(at: [newIndexPath!], with: .automatic)
        } else  if type == .delete {
            self.tableView.deleteRows(at: [indexPath!], with: .automatic)
        }
        
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
        headerView.backgroundColor = .lightGray
        
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
        guard let sections = fetchResultsController.sections else {
            return 0
        }
        
        return sections[section].numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let shoppingList = fetchResultsController.object(at: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = shoppingList.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let shoppingList = fetchResultsController.object(at: indexPath)
            
            self.managedObjectContext.delete(shoppingList)
            try! self.managedObjectContext.save()
        }
        
        tableView.isEditing = false
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
