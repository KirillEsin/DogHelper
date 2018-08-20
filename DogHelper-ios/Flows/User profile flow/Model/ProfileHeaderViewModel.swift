//
//  ProfileHeaderViewModel.swift
//  DogHelper-ios
//
//  Created by Кирилл on 25.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol ProfileHeaderProtocol {
    var username: String { get }
    var dateString: String { get }
    var imageUrl: URL? { get }
    var dogBreed: Breed? { get }
    var dogTypeString: String { get }
}

class ProfileHeaderViewModel: ProfileHeaderProtocol {
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var username: String {
        return "\(user.username)"
    }
    
    var uid: String {
        return user.id
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        //let dateString = dateFormatter.string(from: user.registrationDate)
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
    
    var imageUrl: URL? {
        guard let url = URL(string: user.profileImageUrl) else {
            return nil
        }
        return url
    }
    
    var dogBreed: Breed? {
        return user.dogBreed
    }
    
    var dogTypeString: String {
        if let breed = dogBreed {
            return "Your dog breed: \(breed.breed)"
        }
        return "Add your breed of dog"
    }
}
