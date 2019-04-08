//
//  ViewModelType.swift
//  GroupExpense
//
//  Created by Minh Tuan on 4/8/19.
//  Copyright © 2019 Minh Tuan. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
