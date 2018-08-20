//
//  ChatVieModel.swift
//  Lets swap
//
//  Created by Кирилл on 15.03.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

class ChatViewModel: BaseViewModel {
    
    var model: ChatModel
    
    init(model: ChatModel) {
        self.model = model
        super.init()
        bindModel()
    }
    
    override func bindModel() {
        model.didUpdate = {[weak self] in
            self?.didUpdate?()
        }
    }
    
    var messagesCount: Int {
        return model.messagesCount
    }
    
    func message(at index: Int) -> Message? {
        return model.message(at: index)
    }
    
    func sendMessage(text: String?) {
        let trimmedText = text?.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let text = trimmedText, !text.isEmpty else {
            return
        }
        
        model.sendMessage(text: text)
    }
}
