//
//  BaseViewModel.swift
//  MVVM
//
//  Created by Кирилл on 10.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import UIKit

protocol ViewModelOutput {
    var didUpdate: (() -> Void)? {get set}
    func bindModel()
}

class BaseViewModel: ViewModelOutput {
    var didUpdate: (() -> Void)?
    func bindModel() {}
}
