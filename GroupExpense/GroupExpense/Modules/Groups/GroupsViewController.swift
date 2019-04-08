//
//  ViewController.swift
//  GroupExpense
//
//  Created by Minh Tuan on 4/8/19.
//  Copyright © 2019 Minh Tuan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let reuseIdentifier = "GroupTableViewCell"
class GroupsViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var viewModel: GroupsViewModel!
    let disposeBag = DisposeBag()
    let refreshTrigger = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        bindViewModel()
    }
    
    func makeUI() {
        tableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        addButton.layer.cornerRadius = addButton.bounds.height / 2
        addButton.backgroundColor = AppColor.mainBlueColor
    }
    
    func bindViewModel() {
        let refresh = Observable.of(Observable.just(()), refreshTrigger).merge()
        let input = GroupsViewModel.Input(selection: tableView.rx.modelSelected(GroupCellViewModel.self).asDriver(),
                                          needRefresh: refresh)
        let output = viewModel.transform(input: input)
        output.items.asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: GroupTableViewCell.self)) { tableView, viewModel, cell in
                cell.bind(to: viewModel)
            }.disposed(by: disposeBag)
        
        output.selection.drive(onNext: { text in
            print("===> \(text)")
        }).disposed(by: disposeBag)
        
        addButton.rx.tap.asObservable().subscribe(onNext: { [weak self] () in
            guard let self = self else {return}
            let viewModel = CreateGroupViewModel()
            viewModel.refreshTrigger.subscribe(onNext: {
                self.refreshTrigger.onNext(())
            }).disposed(by: self.disposeBag)
            self.navigator.show(segue: .createGroup(viewModel: viewModel), sender: self, transition: .detail)
        }).disposed(by: disposeBag)
        
    }

}

