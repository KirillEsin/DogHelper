//
//  SignOutProtocol.swift
//  Malmo
//
//  Created by Кирилл on 25.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol SignOutViewModelProtocol {
    var didSignOutCallback: (() -> Void)? { get set }
    func handleSignOut()
}

class SignOutViewModel: BaseViewModel, SignOutViewModelProtocol {
    var didSignOutCallback: (() -> Void)?
    
    private var model: SignOutModel
    
    init(model: SignOutModel) {
        self.model = model
        super.init()
        
        self.model.didSignOut = { [weak self] in
            self?.didSignOutCallback?()
        }
    }
    
    func handleSignOut() {
        model.signOut()
    }
}
