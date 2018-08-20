//
//  SignUpViewModel.swift
//  Malmo
//
//  Created by Кирилл on 25.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol SignUpViewModelProtocol {
    var didSignUpCallback: (() -> Void)? { get set }
    var didValidationCallback: ((_ isValid: Bool) -> Void)? { get set }
    func validate(email: String?, username: String?, password: String?)
    func set(avatarImage: UIImage)
}

class SignUpViewModel: BaseViewModel, SignUpViewModelProtocol {
    
    var didSignUpCallback: (() -> Void)?
    var didValidationCallback: ((Bool) -> Void)?
    
    private var model: SignUpModel
    
    init(model: SignUpModel) {
        self.model = model
        super.init()
        
        self.model.didSignUp = { [weak self] in
            self?.didSignUpCallback?()
        }
        
        self.model.isValidCallback = { [weak self] isValid in
            self?.didValidationCallback?(isValid)
        }
        
    }
    
    func validate(email: String?, username: String?, password: String?) {
        model.email = email
        model.username = username
        model.password = password
    }
    
    func set(avatarImage: UIImage) {
        model.avatarImage = avatarImage
    }
    
    
}
