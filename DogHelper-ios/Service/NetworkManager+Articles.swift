//
//  DataManager+Articles.swift
//  DogHelper-ios
//
//  Created by Кирилл on 22.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

struct NetworkManager: DataManagerProtocol {
    
    let provider = MoyaProvider<APIEndpoint>()
    
    func getArticles(lastId: String, completion: @escaping ArticlesCompletion) {
        
        Database.database().reference().child("articles").observe(.value, with: { (snapshot) in
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            var articles: [Article] = []
            
            allObjects.forEach { snapshot in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                articles.append(Article(dictionary: dictionary))
            }
            completion(.success(articles))
        })
    } 
    
    
}
