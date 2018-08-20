//
//  UserManager.swift
//  Malmo
//
//  Created by Кирилл on 19.02.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

typealias TokenCompletion = ((String?) -> Void)

final class UserManager {
    fileprivate init() {}
    static let shared = UserManager()
    
    fileprivate var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    fileprivate var keys: Constants.Settings.Type {
        return Constants.Settings.self
    }
    
    var userUid: String? {
        print("👑")
        return Auth.auth().currentUser?.uid
    }
    
    var isLogin: Bool {
        guard let _ = Auth.auth().currentUser?.uid else {
            return false
        }
        return true
    }
    
    var userAvatarUrl: URL? {
        return Auth.auth().currentUser?.photoURL
    }
    
    var userToken: String? {
        return userDefaults.string(forKey: keys.token)
    }
    
    var userID: String? {
        set(newValue) {
            userDefaults.set(newValue, forKey: keys.userID)
        }
        get {
            return userDefaults.string(forKey: keys.userID)
        }
    }
    
    func logout() {
        userDefaults.removeObject(forKey: keys.userID)
        userDefaults.removeObject(forKey: keys.token)
    }
    
    func getToken(completion: @escaping TokenCompletion) {
        Auth.auth().currentUser?.getIDToken(completion: { (token, error) in
            if let error = error {
                print(error)
                return
            }
            print("token \(token)")
            completion(token)
        })
    }
    
    func saveToken() {
        Auth.auth().currentUser?.getIDToken(completion: {[weak self] (token, error) in
            if let error = error {
                print(error)
                return
            }
            self?.userDefaults.set(token, forKey: "token")
        })
    }
}

