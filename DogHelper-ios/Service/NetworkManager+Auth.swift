//
//  NetworkManager+Auth.swift
//  DogHelper-ios
//
//  Created by Кирилл on 24.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

extension NetworkManager: AuthorizationDataManager {
    
    func signIn(email: String, password: String, completion: @escaping SuccessCompletion) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("Failed sign in: \(error)")
                completion(.failure(error))
                return
            }
            
            print("Successfully sign in: \(user?.uid ?? "")")
            completion(.success(true))
        }
    }
    
    func signUp(email: String, username: String, password: String, avatarImage: UIImage, completion: @escaping SuccessCompletion) {

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("Failled to create user: \(error)")
                completion(.failure(error))
                return
            }
            
            print("Successfully create user: \(user?.uid ?? "") ")
            
            guard let uploadData = UIImageJPEGRepresentation(avatarImage, 0.3) else {
                completion(.success(true))
                return
            }
            let filename = NSUUID().uuidString

            Storage.storage().reference().child("profile_images").child(filename).putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if let error = error {
                    print("Failed to upload profile image:", error)
                    completion(.failure(error))
                    return
                }
                
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else {
                    completion(.success(true))
                    return
                }
                
                let uid = user!.uid
                let dictionaryValues = ["username": username, "profileImageUrl": profileImageUrl, "dateRegistered": Date().timeIntervalSince1970] as [String : Any]
                let values = [uid: dictionaryValues]
                
                Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if let error = error {
                        print("Failed to save user info into db:", error)
                        completion(.failure(error))
                        return
                    }
                    print("Successfully saved user info to db")
                    completion(.success(true))
                })
            })
            
        }
    }
    
    func signOut(completion: @escaping SuccessCompletion) {
        do {
            try Auth.auth().signOut()
            completion(.success(true))
        } catch let error {
            print("Failed sign out:", error)
            completion(.failure(error))
        }
    }
}
