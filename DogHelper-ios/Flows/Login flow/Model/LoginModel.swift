//
//  LoginModel.swift
//  Malmo
//
//  Created by Кирилл on 25.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

class LoginModel: BaseModel {
    
    var didSignIn: (() -> Void)?
    var isValidCallback: (([AuthorizationErrorField]) -> Void)?
    var errorCallback: ((String) -> Void)?
    
    var email: String? = nil
    var password: String? = nil
    
    var isValid: Bool = false {
        didSet {
            if isValid {
                signIn()
            }
        }
    }
    
    func validation(email: String?, password: String?) {
        var fields: [AuthorizationErrorField] = []
        
        if email == nil || email == "" {
            isValid = false
            fields.append(AuthorizationErrorField.email)
        }
        
        if password == nil || password == "" {
            isValid = false
            fields.append(AuthorizationErrorField.password)
        }
        
        if fields.isEmpty {
            self.email = email
            self.password = password
            isValid = true
        } else {
            isValidCallback?(fields)
        }
        
    }
    
    func signIn() {
        if isValid {
            dataManager.signIn(email: email!, password: password!) { [weak self] (result) in
                switch result {
                case .success(_):
                    self?.didSignIn?()
                case .failure(let error):
                    self?.errorCallback?(error.localizedDescription)
                }
            }
        }
    }
    
}
