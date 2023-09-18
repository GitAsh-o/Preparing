//
//  Event.swift
//  Preparing
//
//  Created by 大沼朝陽 on 2023/09/16.
//

import Foundation
import RealmSwift

class Event: Object{
    @Persisted var title: String = ""
    @Persisted var color: String = ""
}
