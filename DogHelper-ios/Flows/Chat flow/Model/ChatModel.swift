//
//  ChatModel.swift
//  Lets swap
//
//  Created by Кирилл on 15.03.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

class ChatModel: BaseModel {

    var chat: Chat {
        didSet {
            getMessages()
        }
    }
    
    var messages: [Message] = [] {
        didSet {
            didUpdate?()
        }
    }
    
    override init(dataManager: DataManagerProtocol) {
        self.chat = Chat()
        super.init(dataManager: dataManager)
        getMessages()
    }

    func message(at index: Int) -> Message? {
        guard index >= 0 && index < messagesCount else {
            debugPrint("index is nil")
            return nil
        }
        return messages[index]
    }
    
    var messagesCount: Int {
        return messages.count
    }
    
    func getMessages() {
    }
    
    func sendMessage(text: String) {
        let question = Message(text: text, id: 0, messageType: .question)
        messages.append(question)
        
        dataManager.sendQuestion(question: text) {[weak self] (result) in
            switch result {
            case .success(let messages):
                messages.map{ self?.messages.append($0)}
            case .failure(_):
                break
            }
        }
    }
}
