//
//  NetworkManager+Chat.swift
//  DogHelper-ios
//
//  Created by greecknote on 03.06.18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import SwiftyJSON

extension NetworkManager: ChatDataManager {
    
    func sendQuestion(question: String, completion: @escaping MessageCompletion) {
        provider.request(.sendQuestion(question: question)) { (result) in
            switch result {
            case .success(let response):
                let json = JSON(response.data)
                var messages: [Message] = []
                
                let answers = json["answers"].arrayValue
                answers.forEach { json in
                    let id = json["id"].intValue
                    let text = json["answer"].stringValue
                    let message = Message(text: text, id: id, messageType: .answer)
                    messages.append(message)
                }
                
                completion(.success(messages))
            case .failure(let error):
                print(error)
            }
        }
    }
}
