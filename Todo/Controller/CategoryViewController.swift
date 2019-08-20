//
//  CategoryViewController.swift
//  Todo
//
//  Created by zhm on 2019/8/16.
//  Copyright © 2019 zhm. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    // MARK: - TableView Data Source

    // init table view with data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        return cell
    }

    // determine table view size
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }

    // row response on tapping
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("inside did select row")
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }

    // MARK: - Data Manipulation

    func save(with category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("save cateogries error: \(error)")
        }
        tableView.reloadData()
    }

    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }



    // MARK: - Add New Categories

    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        print("add btn press")
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new category"
            textField = alertTextField
        }
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if textField.text!.count > 0 {
                let category = Category()
                category.name = textField.text!
                self.save(with: category)
            }
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }



}
