//
//  NetworkManagerProtocol.swift
//  Malmo
//
//  Created by Кирилл on 25.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}

typealias SuccessCompletion = (Result<Bool, Error>) -> Void
typealias ArticlesCompletion = (Result<[Article], Error>) -> Void
typealias MessageCompletion = (Result<[Message], Error>) -> Void
typealias UserCompletion = (Result<User, Error>) -> Void
typealias BreedsCompletion = (Result<[Breed], Error>) -> Void
//typealias CategoryCompletion = (Result<[Category], Error>) -> Void
//typealias MessageCompletion = (Result<[Message], Error>) -> Void
//typealias MessageListCompletion = (Result<[MessageList], Error>) -> Void
//typealias WriteMesageCompletion = (Result<String, Error>) -> Void

protocol DataManagerProtocol:
    ArticlesDataManager,
    AuthorizationDataManager,
    UserDataManager,
    DogDataManager,
    ChatDataManager {}

protocol FirebaseDataManagerProtocol: AuthorizationDataManager {
}

protocol AuthorizationDataManager {
    func signIn(email: String, password: String, completion: @escaping SuccessCompletion)
    func signUp(email: String, username: String, password: String, avatarImage: UIImage, completion: @escaping SuccessCompletion)
    func signOut(completion: @escaping SuccessCompletion)
}

protocol ArticlesDataManager {
    func getArticles(lastId: String, completion: @escaping ArticlesCompletion)
}

protocol UserDataManager {
    func getUser(uid: String, completion: @escaping UserCompletion)
}

protocol DogDataManager {
    func creatDogsBreed()
    func getAllBreed(completion: @escaping BreedsCompletion)
    func setSelectedBreed(uid: String, breed: BreedProtocol)
}

protocol ChatDataManager {
    func sendQuestion(question: String, completion: @escaping MessageCompletion)
}


