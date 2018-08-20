//
//  UserProfileViewModel.swift
//  DogHelper-ios
//
//  Created by Кирилл on 25.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol UserProfileViewModelProtocol: ViewModelOutput {
    var headerViewModel: ProfileHeaderProtocol { get }
    var navigationTitle: String { get }
}

class UserProfileViewModel: BaseViewModel, UserProfileViewModelProtocol {
    
    var model: UserProfileModelProtocol
    
    init(model: UserProfileModelProtocol) {
        self.model = model
        super.init()
        bindModel()
    }
    
    override func bindModel() {
        model.didUpdate = {[weak self] in
            self?.didUpdate?()
        }
    }
    
    var headerViewModel: ProfileHeaderProtocol {
        return ProfileHeaderViewModel(user: model.user)
    }
    
    var navigationTitle: String {
        return "My profile"
    }
    
    
}
