//
//  Breed.swift
//  DogHelper-ios
//
//  Created by Кирилл on 28.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol BreedProtocol {
    var id: String { get set }
    var breed: String { get set }
    
//    func showDogBreed() -> String
}

extension BreedProtocol {
//    func showDogBreed() -> String {
//        return "Your dog breed: \(breed)"
//    }
}

class Breed: BreedProtocol {
    var id: String
    var breed: String
    
    init(id: Int, dictionary: [String: Any]) {
        self.id = "\(id)"
        self.breed = dictionary["breed"] as? String ?? ""
    }
}
