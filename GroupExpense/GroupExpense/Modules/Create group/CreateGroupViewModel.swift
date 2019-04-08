//
//  CreateGroupViewModel.swift
//  GroupExpense
//
//  Created by Minh Tuan on 4/8/19.
//  Copyright © 2019 Minh Tuan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CreateGroupViewModel: ViewModelType {
   
    let disposeBag = DisposeBag()
    let refreshTrigger = PublishSubject<Void>()
    struct Input {
        let doneTrigger: Driver<Void>
        let cancelTrigger: Driver<Void>
        let groupNameTrigger: Driver<String>
        let groupDesTrigger: Driver<String>
    }
    
    struct Output {
        let group: Observable<Group>
    }
    
    func transform(input: Input) -> Output {
        let group = Observable
            .combineLatest(input.groupNameTrigger.asObservable(), input.groupDesTrigger.asObservable())
            .sample(input.doneTrigger.asObservable())
            .flatMap { [weak self] (name, description) -> Observable<Group> in
                let group = Group()
                group.name = name
                group.groupDescription = description
                DBManager.shared.addGroup(object: group)
                self?.refreshTrigger.onNext(())
                return Observable.just(group)
        }
        return Output(group: group)
    }
    
}
