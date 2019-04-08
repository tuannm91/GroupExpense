//
//  GroupCellViewModel.swift
//  GroupExpense
//
//  Created by Minh Tuan on 4/8/19.
//  Copyright © 2019 Minh Tuan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GroupCellViewModel {
    
    let title: Driver<String>
    let detail: Driver<String>
    let group: Group
    
    init(with group: Group) {
        self.group = group
        title = Driver.just(group.name)
        detail = Driver.just(group.groupDescription)
    }
}


extension GroupCellViewModel: Equatable {
    static func == (lhs: GroupCellViewModel, rhs: GroupCellViewModel) -> Bool {
        return lhs.group == rhs.group
    }
}
