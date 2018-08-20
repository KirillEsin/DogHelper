//
//  User.swift
//  DogHelper-ios
//
//  Created by Кирилл on 22.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol UserProtocol {
    var profileImageUrl: String { get set }
    var id: String { get set }
    var username: String { get set }
    var dateRegistered: Double { get set }
    var dogBreed: Breed? { get }
}

class User: UserProtocol {
    
    var profileImageUrl: String = ""
    var id: String = ""
    var username: String = ""
    var dateRegistered: Double = 0.0
    var dogBreed: Breed?
    
    init(uid: String, dictionary: [String: Any]) {
        self.id = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
        self.dateRegistered = dictionary["dateRegistered"] as? Double ?? 0
        if let breedAnyObject = dictionary["breed"], let breedDict = breedAnyObject as? [String: Any] {
            let breedId = breedDict["id"] as? Int ?? 0
            self.dogBreed = Breed(id: breedId, dictionary: breedDict)
        }
    }
    
    init() {
    }
}
