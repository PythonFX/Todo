//
//  Category.swift
//  Todo
//
//  Created by zhm on 2019/8/20.
//  Copyright © 2019 zhm. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
