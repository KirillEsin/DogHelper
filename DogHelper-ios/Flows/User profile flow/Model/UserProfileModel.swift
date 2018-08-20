//
//  UserProfileModel.swift
//  DogHelper-ios
//
//  Created by Кирилл on 25.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol UserProfileModelProtocol: Model {
    var user: User { get }
}

class UserProfileModel: BaseModel, UserProfileModelProtocol {
    
    var user: User {
        didSet {
            didUpdate?()
        }
    }
    
    override init(dataManager: DataManagerProtocol) {
        self.user = User()
        super.init(dataManager: dataManager)
        getUser()
    }
    
    func getUser() {
        guard let uid = UserManager.shared.userUid else { return }
        dataManager.getUser(uid: uid) { [weak self] (result) in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(_):
                break
            }
        }
    }
    
}
