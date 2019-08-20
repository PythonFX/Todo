//
//  Item.swift
//  Todo
//
//  Created by zhm on 2019/8/20.
//  Copyright © 2019 zhm. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
