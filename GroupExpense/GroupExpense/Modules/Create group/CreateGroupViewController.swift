//
//  CreateGroupViewController.swift
//  GroupExpense
//
//  Created by Minh Tuan on 4/8/19.
//  Copyright © 2019 Minh Tuan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CreateGroupViewController: ViewController {

    lazy var doneBarButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "Done", style: .done, target: nil, action: nil)
        return view
    }()
    
    lazy var goBackBarButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "Cancel", style: .done, target: nil, action: nil)
        return view
    }()
    
    @IBOutlet weak var groupNameTF: UITextField!
    @IBOutlet weak var groupDesTF: UITextField!
    
    var viewModel: CreateGroupViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        bindViewModel()
    }
    
    func makeUI() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "Create a group"
        navigationItem.rightBarButtonItem = doneBarButton
        navigationItem.leftBarButtonItem = goBackBarButton
    }
    
    func bindViewModel() {
        goBackBarButton.rx.tap.asObservable().subscribe(onNext: { [weak self] () in
            self?.navigator.dismiss(sender: self)
        }).disposed(by: disposeBag)
        
        groupNameTF.rx.text.orEmpty.asObservable().map {
            return $0.count > 0
        }.bind(to: doneBarButton.rx.isEnabled).disposed(by: disposeBag)
        
        let input = CreateGroupViewModel.Input(doneTrigger: doneBarButton.rx.tap.asDriver(),
                                               cancelTrigger: goBackBarButton.rx.tap.asDriver(),
                                               groupNameTrigger: groupNameTF.rx.text.orEmpty.asDriver(),
                                               groupDesTrigger: groupDesTF.rx.text.orEmpty.asDriver())
        
        let output = viewModel.transform(input: input)
        output.group.subscribe(onNext: { [weak self] group in
            self?.navigator.dismiss(sender: self)
        }).disposed(by: disposeBag)
        
        
    }
    
}
