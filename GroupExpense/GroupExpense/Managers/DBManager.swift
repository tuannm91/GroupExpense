//
//  DBManager.swift
//  GroupExpense
//
//  Created by Minh Tuan on 4/8/19.
//  Copyright © 2019 Minh Tuan. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

final class DBManager {
    private let database: Realm
    static let shared = DBManager()
    
    private init() {
        database = try! Realm()
    }
    
    func getAllGroup() -> Single<[Group]> {
        let results: Results<Group> = database.objects(Group.self)
        return Single.just(Array(results).sorted(by: {
            return $0.createDate > $1.createDate
        }))
    }
    
    func addGroup(object: Group) {
        try! database.write {
            database.add(object, update: true)
            print("Added new object")
        }
    }

}
