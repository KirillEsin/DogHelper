//
//  SignUpView.swift
//  FlowTestController
//
//  Created by Кирилл on 16.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

protocol SignUpView: BaseView {
    
    var onSignUpComplete: (() -> Void)? { get set }
    
}
