//
//  ViewController.swift
//  Todo
//
//  Created by zhm on 2019/8/12.
//  Copyright © 2019 zhm. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var itemArray = ["find out", "listen music", "buy eggs"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoCell")
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        let row = tableView.cellForRow(at: indexPath)
        row?.accessoryType = (row?.accessoryType == .checkmark) ? .none : .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todo action", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create New Item"
            textField = alertTextField
        }
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print(textField.text!)
            if textField.text!.count > 0 {
                self.itemArray.append(textField.text!)
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }


}

