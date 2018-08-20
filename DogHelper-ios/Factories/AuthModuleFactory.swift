//
//  AuthModuleFactory.swift
//  FlowTestController
//
//  Created by Кирилл on 16.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

protocol AuthModuleFactory {
    func makeLoginOutput() -> LoginView
    func makeSignUpHandler() -> SignUpView
}
