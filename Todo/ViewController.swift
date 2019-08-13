//
//  ViewController.swift
//  Todo
//
//  Created by zhm on 2019/8/12.
//  Copyright © 2019 zhm. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let itemArray = ["find out", "listen music", "buy eggs"]

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



}

