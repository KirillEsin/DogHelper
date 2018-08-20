//
//  AuthCoordinator.swift
//  FlowTestController
//
//  Created by Кирилл on 16.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

class AuthCoordinator: BaseCoordinator, AuthCoordinatorOutput {
    var finishFlow: (() -> Void)?
    var dismissFlow: (() -> Void)?
    
    private let factory: AuthModuleFactory
    private let router: Router
    private var signUpView: SignUpView?
    
    init(router: Router, factory: AuthModuleFactory) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showSignIn()
    }
    
    private func showSignIn() {
        let loginOutput = factory.makeLoginOutput()
        loginOutput.onCompleteAuth = { [weak self] in
            self?.finishFlow?()
            UserManager.shared.saveToken()
        }
        
        loginOutput.onSignUpButtonTap = { [weak self] in
            self?.showSignUp()
        }
        
        loginOutput.onDismissTap = {[weak self] in
            self?.dismissFlow?()
        }
        
        router.setRootModule(loginOutput, hideBar: false)
    }
    
    private func showSignUp() {        
        signUpView = factory.makeSignUpHandler()
        signUpView?.onSignUpComplete = { [weak self] in
            self?.finishFlow?()
        }
        router.push(signUpView, animated: true)
    }

}
