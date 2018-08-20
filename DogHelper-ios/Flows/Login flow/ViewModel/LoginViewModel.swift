//
//  LoginViewVodel.swift
//  Malmo
//
//  Created by Кирилл on 25.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol LoginViewModelProtocol {
    var didSignInCallback: (() -> Void)? { get set }
    var didValidationCallback: (([AuthorizationErrorField]) -> Void)? { get set }
    var errorCallback: ((String) -> Void)? { get set }
    func validate(email: String?, password: String?)
}

class LoginViewModel: BaseViewModel, LoginViewModelProtocol {
    
    var didSignInCallback: (() -> Void)?
    var didValidationCallback: (([AuthorizationErrorField]) -> Void)?
    var errorCallback: ((String) -> Void)?
    
    private var model: LoginModel
    
    init(model: LoginModel) {
        self.model = model
        super.init()
        
        self.model.didSignIn = { [weak self] in
            self?.didSignInCallback?()
        }
        self.model.isValidCallback = { [weak self] fields in
            self?.didValidationCallback?(fields)
        }
        
        self.model.errorCallback = { [weak self] error in
            self?.errorCallback?(error)
        }
    }
    
    func validate(email: String?, password: String?) {
        model.validation(email: email, password: password)
    }
}
