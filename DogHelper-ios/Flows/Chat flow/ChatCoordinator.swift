//
//  ChatCoordinator.swift
//  Lets swap
//
//  Created by Кирилл on 13.03.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol ChatModuleFactory {
    func makeChatOutput() -> ChatView
}

class ChatCoordinator: BaseCoordinator {
    private let router: Router
    private let factory: ChatModuleFactory
    
    init(factory: ChatModuleFactory, router: Router) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showChat()
    }
    
    private func showChat() {
        let chatOutput = factory.makeChatOutput()
        router.setRootModule(chatOutput, hideBar: false)
    }
    

}
