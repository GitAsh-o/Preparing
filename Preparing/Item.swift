//
//  Item.swift
//  Preparing
//
//  Created by 大沼朝陽 on 2023/09/17.
//

import Foundation
import RealmSwift

class Item: Object{
    @Persisted var title: String = ""
    @Persisted var event: Event!
}
