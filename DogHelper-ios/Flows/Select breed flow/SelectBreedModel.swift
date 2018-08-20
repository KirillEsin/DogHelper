//
//  SelectBreedModel.swift
//  DogHelper-ios
//
//  Created by Кирилл on 28.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol SelectBreedModelProtocol: Model {
    var didSetBreed: (() -> Void)? { get set }
    
    var itemsCount: Int { get }
    func item(at index: Int) -> BreedProtocol
    func setSelectedBreed(at index: Int)
    func findBreedByName(_ breed: String)
}

class SelectBreedModel: BaseModel, SelectBreedModelProtocol {
    
    var didSetBreed: (() -> Void)?
    
    var breeds: [Breed] {
        didSet {
            didUpdate?()
        }
    }
    
    override init(dataManager: DataManagerProtocol) {
        breeds = []
        super.init(dataManager: dataManager)
        getAllBreed()
    }
    
    var itemsCount: Int {
        return breeds.count
    }
    
    func item(at index: Int) -> BreedProtocol {
        return breeds[index]
    }
    
    func setSelectedBreed(at index: Int) {
        let breed = item(at: index)
        guard let uid = UserManager.shared.userUid else { return }
        dataManager.setSelectedBreed(uid: uid, breed: breed)
    }
    
    func findBreedByName(_ breed: String) {
        guard let uid = UserManager.shared.userUid else { return }
        
        if let index = breeds.index(where: { $0.breed == breed }) {
            dataManager.setSelectedBreed(uid: uid, breed: item(at: index))
            didSetBreed?()
        } else {
            print("eeee")
        }
        
    }
    
    func getAllBreed() {
        dataManager.getAllBreed { [weak self] (result) in
            switch result {
            case .success(let breeds):
                self?.breeds = breeds
            case .failure(_):
                break
            }
        }
    }
}
