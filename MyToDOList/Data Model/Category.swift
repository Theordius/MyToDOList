//
//  Category.swift
//  MyToDOList
//
//  Created by Rafał Gęsior on 28/03/2022.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
    
}


