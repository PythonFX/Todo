//
//  CategoryViewController.swift
//  Todo
//
//  Created by zhm on 2019/8/16.
//  Copyright © 2019 zhm. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
		loadCategories()
    }

    // MARK: - TableView Data Source
    
    // init table view with data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name 
        return cell
    }

    // determine table view size 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }
    
    // row response on tapping
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(categoryArray[indexPath.row].name)
    }

    // MARK: - Data Manipulation

    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("save cateogries error: \(error)")
        }
    }

    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            try categoryArray=context.fetch(request)
        } catch {
            print("load categories error \(error)")
        }
    }



    // MARK: - Add New Categories

    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        print("add btn press")
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "Add New Category", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Category"
            textField = alertTextField
        }
        let action = UIAlertAction(title: "New", style: .default) { (action) in
            if textField.text!.count > 0 {
                let category = Category()
                category.name = textField.text!
                self.categoryArray.append(category)
                self.saveCategories()
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }


    // MARK: TableView Delegate

}
