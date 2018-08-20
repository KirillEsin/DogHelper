//
//  NetworkManager.swift
//  DogHelper-ios
//
//  Created by Кирилл on 28.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

extension NetworkManager: DogDataManager {
    func creatDogsBreed() {
        var arrayOfStrings: [String] = []
        do {
            if let path = Bundle.main.path(forResource: "dog_names", ofType: "txt"){
                let data = try! String(contentsOfFile:path, encoding: String.Encoding.utf8)
                arrayOfStrings = data.components(separatedBy: "\n")
            }
        }

        for (index, element) in arrayOfStrings.enumerated() {
            Database.database().reference().child("breeds").child("\(index)").updateChildValues(["breed": element])
        }
        
    }
    
    func getAllBreed(completion: @escaping BreedsCompletion) {
        Database.database().reference().child("breeds").observeSingleEvent(of: .value) { (snapshot) in
            let allObjects = snapshot.value as! [[String: Any]]
            var breeds: [Breed] = []
            
            for (index, element) in allObjects.enumerated() {
                breeds.append(Breed(id: index, dictionary: element))
            }
            completion(.success(breeds))
        }
    }
    
    func setSelectedBreed(uid: String, breed: BreedProtocol) {
        let dict = ["id": breed.id, "breed": breed.breed]
        Database.database().reference().child("users").child(uid).child("breed").updateChildValues(dict)
    }
}
