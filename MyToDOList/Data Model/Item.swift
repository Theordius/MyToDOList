//
//  Item.swift
//  MyToDOList
//
//  Created by Rafał Gęsior on 28/03/2022.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
