//
//  Group.swift
//  GroupExpense
//
//  Created by Minh Tuan on 4/8/19.
//  Copyright © 2019 Minh Tuan. All rights reserved.
//

import Foundation
import RealmSwift

final class Group: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var groupDescription = ""
    @objc dynamic var createDate: Date?
    let participants = List<Participant>()
    let expenses = List<Expense>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
