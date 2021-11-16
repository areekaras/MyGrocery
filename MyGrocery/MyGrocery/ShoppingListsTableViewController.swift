//
//  ShoppingListsTableViewController.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 16/11/21.
//

import UIKit
import CoreData

class ShoppingListsTableViewController: UITableViewController {

    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initializeCoreDataStack()
    }
    
    func initializeCoreDataStack() {
        guard let bundleUrl = Bundle.main.url(forResource: "MyGroceryDataModel", withExtension: ".momd") else {
            fatalError("Could not find MyGroceryDataModel")
        }
        
        guard let managedObjecModel = NSManagedObjectModel(contentsOf: bundleUrl) else {
            fatalError("Could not create ManagedObjectModel")
        }
        
        let persistantStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjecModel)
        
        let fileManager = FileManager()
        guard let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Could not find Document Url")
        }
        
        let storeUrl = documentUrl.appendingPathComponent("MyGrocery.sqlite")
        
        try! persistantStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: nil)
        
        let concurrencyType = NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: concurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = persistantStoreCoordinator
        
    }
    
    // MARK:- Table View delegates
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44))
        
        let textView = UITextField(frame: headerView.frame)
        textView.placeholder = "Enter Shopping List"
        textView.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textView.leftViewMode = .always
        
        headerView.addSubview(textView)
        
        return headerView
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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
