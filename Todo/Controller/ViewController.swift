//
//  ViewController.swift
//  Todo
//
//  Created by zhm on 2019/8/12.
//  Copyright © 2019 zhm. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var itemArray = [Item]()
//    var userDefault = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        // let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoCell")
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        cell.textLabel?.text = itemArray[indexPath.row].title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let row = tableView.cellForRow(at: indexPath)
        // row?.accessoryType = (row?.accessoryType == .checkmark) ? .none : .checkmark
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
                self.itemArray.append(Item(itemTitle: textField.text!))
//                self.userDefault.set(self.itemArray, forKey: "TodoItemArray")
				self.saveItems()
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func saveItems() {
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!) {
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("decode error: \(error)")
            }
        }
    }

}

