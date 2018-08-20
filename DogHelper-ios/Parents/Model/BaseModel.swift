//
//  BaseModel.swift
//  MVVM
//
//  Created by Кирилл on 10.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol Model {
    var didUpdate: (() -> Void)? {get set}
}

class BaseModel: NSObject, Model {
    var didUpdate: (() -> Void)?
    var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
        super.init()
    }
}
