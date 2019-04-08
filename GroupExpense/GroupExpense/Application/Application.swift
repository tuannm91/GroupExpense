//
//  Application.swift
//  GroupExpense
//
//  Created by Minh Tuan on 4/8/19.
//  Copyright © 2019 Minh Tuan. All rights reserved.
//

import UIKit

class Application: NSObject {
    static let shared = Application()
    var window: UIWindow?
    let navigator: Navigator
    
    private override init() {
        navigator = Navigator.default
        super.init()
    }
    
    func presentInitialScreen(in window: UIWindow?) {
        guard let window = window else { return }
        self.window = window
        let viewModel = GroupsViewModel()
        self.navigator.show(segue: .groups(viewModel: viewModel), sender: nil, transition: .root(in: window))
    }
    
}
