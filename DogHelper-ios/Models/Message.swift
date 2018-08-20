//
//  Message.swift
//  DogHelper-ios
//
//  Created by greecknote on 03.06.18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

class Chat {
    var messages: [Message] = []
    
    init(messages: [Message]) {
        self.messages = messages
    }
    
    init() {
    }
}

class Message: Codable {
    var text: String = ""
    var id: Int = 0
    var messageType: MessageType = .question
    
    enum CodingKeys: String, CodingKey {
        case text = "answer"
        case id = "id"
    }
    
    init(text: String, id: Int, messageType: MessageType) {
        self.text = text
        self.id = id
        self.messageType = messageType
    }
    
    init() {
    }
}

enum MessageType: String, Codable {
    case question = "question"
    case answer = "answer"
}
