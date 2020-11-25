//
//  Category.swift
//  To Do List 2
//
//  Created by Ali  on 21/11/2020.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name:String = ""
    let items = List<Item>()
}
