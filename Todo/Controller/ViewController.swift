//
//  ViewController.swift
//  Todo
//
//  Created by zhm on 2019/8/12.
//  Copyright © 2019 zhm. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        // searchbar.delegate = self
        loadItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        // let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoCell")
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        cell.textLabel?.text = itemArray[indexPath.row].title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // delete item
        // context.delete(itemArray[indexPath.row])
        // itemArray.remove(at: indexPath.row)

        // another way to update data
        // itemArray[indexPath.row].setValue("Completed", forKey: "title")
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
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
                let item = Item(context: self.context)
                item.title = textField.text!
                item.done = false
                self.itemArray.append(item)
                self.saveItems()
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func saveItems() {
        do {
            try context.save()
        } catch {
            print(error)
        }
        tableView.reloadData()
    }

    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("fetch error \(error)")
        }
        tableView.reloadData()
    }



}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let text = searchBar.text!
        // predicate: description for how to query database
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", text)
        request.predicate = predicate
		let sortDiscriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDiscriptor]
        loadItems(with: request)
    }
}
