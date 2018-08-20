//
//  File.swift
//  DogHelper-ios
//
//  Created by Кирилл on 24.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

extension NetworkManager: UserDataManager {
    
    func getUser(uid: String, completion: @escaping UserCompletion) {
        Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            let user = User(uid: uid, dictionary: userDictionary)
            completion(.success(user))
        })
    }
}
