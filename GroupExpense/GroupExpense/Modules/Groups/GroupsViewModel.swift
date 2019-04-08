//
//  GroupsViewModel.swift
//  GroupExpense
//
//  Created by Minh Tuan on 4/8/19.
//  Copyright © 2019 Minh Tuan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GroupsViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    struct Input {
        let selection: Driver<GroupCellViewModel>
        let needRefresh: Observable<Void>
    }
    
    struct Output {
        let items: BehaviorRelay<[GroupCellViewModel]>
        let selection: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let elements = BehaviorRelay<[GroupCellViewModel]>(value: [])
        
        input.needRefresh.flatMapLatest({ [weak self] () -> Observable<[GroupCellViewModel]> in
            guard let self = self else { return Observable.just([]) }
            return self.getGroupsFromDB()
        }).subscribe(onNext: { (items) in
            elements.accept(items)
        }).disposed(by:disposeBag)
        
        getGroupsFromDB().subscribe(onNext: { (items) in
            elements.accept(items)
        }).disposed(by: disposeBag)
        
        let groupDetails = input.selection.map {_ in 
            return ""
        }
        
        return Output(items: elements, selection: groupDetails)
    }
    
    func getGroupsFromDB() -> Observable<[GroupCellViewModel]> {
        return DBManager.shared.getAllGroup()
            .asObservable()
            .map{$0.map{GroupCellViewModel(with: $0)}}
    }

}
