//
//  Item.swift
//  Todo
//
//  Created by zhm on 2019/8/14.
//  Copyright © 2019 zhm. All rights reserved.
//

import Foundation

class Item : Encodable, Decodable {
    var title: String = ""
    var done: Bool = false
    init(itemTitle:String) {
        title = itemTitle
    }
}
