//
//  Item.swift
//  To Do List 2
//
//  Created by Ali  on 20/11/2020.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var name:String = ""
    @objc dynamic var checked:Bool = false
    let parent = LinkingObjects(fromType:Category.self,property:"items")
}
