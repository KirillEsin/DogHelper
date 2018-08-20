//
//  SignUpModel.swift
//  Malmo
//
//  Created by Кирилл on 25.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

class SignUpModel: BaseModel {
 
    var didSignUp: (() -> Void)?
    var isValidCallback: ((_ isValid: Bool) -> Void)?
    
    var avatarImage: UIImage?
    
    var email: String? = nil {
        didSet {
            validation()
        }
    }
    
    var username: String? = nil {
        didSet {
            validation()
        }
    }
    
    var password: String? = nil {
        didSet {
            validation()
        }
    }
    
    var isValid: Bool = false {
        didSet {
            isValidCallback?(isValid)
            if isValid {
                signUp()
            }
        }
    }

    private func validation() {
        guard let email = email, let password = password, let username = username else {
            isValid = false
            return
        }
        
        isValid = !email.isEmpty && !password.isEmpty && !username.isEmpty
    }
    
    func signUp() {
        if isValid {
            if avatarImage == nil {
                avatarImage = #imageLiteral(resourceName: "user_avatar_placeholder")
            }
            
            dataManager.signUp(email: email!, username: username!, password: password!, avatarImage: avatarImage!, completion: { [weak self] (result) in
                switch result {
                case .success(_):
                    self?.didSignUp?()
                case .failure(_):
                    break
                }
            })
        }
    }
}
