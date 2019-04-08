//
//  GroupTableViewCell.swift
//  GroupExpense
//
//  Created by Minh Tuan on 4/8/19.
//  Copyright © 2019 Minh Tuan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GroupTableViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(to viewModel: GroupCellViewModel) {
        viewModel.title.drive(titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.detail.drive(detailLabel.rx.text).disposed(by: disposeBag)
    }
    
}
