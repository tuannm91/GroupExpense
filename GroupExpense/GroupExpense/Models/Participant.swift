//
//  Participant.swift
//  GroupExpense
//
//  Created by Minh Tuan on 4/8/19.
//  Copyright © 2019 Minh Tuan. All rights reserved.
//

import Foundation
import RealmSwift

final class Participant: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    let group = LinkingObjects(fromType: Group.self, property: "participants")
    
    override static func primaryKey() -> String? {
        return "id"
    }

}
