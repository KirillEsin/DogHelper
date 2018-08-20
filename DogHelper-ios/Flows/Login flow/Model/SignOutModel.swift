//
//  SignOutModel.swift
//  Malmo
//
//  Created by Кирилл on 25.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

class SignOutModel: BaseModel {
    var didSignOut: (() -> Void)?
    
    
    func signOut() {
        dataManager.signOut { [weak self] (result) in
            switch result {
            case .success(_):
                self?.didSignOut?()
            case .failure(_):
                break
            }
        }
    }
}
