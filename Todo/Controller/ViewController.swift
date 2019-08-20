//
//  ViewController.swift
//  Todo
//
//  Created by zhm on 2019/8/12.
//  Copyright © 2019 zhm. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {

    let realm = try! Realm()
    var items: Results<Item>?
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        if let item = items?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("inside did select row")
        if let item = items?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
                tableView.reloadData()
            } catch {
                print("error saving done status \(error)")
            }
        } else {
            print("clicked item error")
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todo action", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text!.count > 0 {
                if let currentCategory = self.selectedCategory {
                    let item = Item()
                    item.title = textField.text!
                    item.dateCreated = Date()
                    self.save(with: item, into: currentCategory)
                }
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func save(with item: Item, into category: Category) {
        do {
            try realm.write {
                category.items.append(item)
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
    }

    func loadItems() {
        items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }



}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        items = items?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            // switch to main thread to respond faster
            DispatchQueue.main.async {
                // no longer to be in focus
                searchBar.resignFirstResponder()
            }

        }
    }
}
