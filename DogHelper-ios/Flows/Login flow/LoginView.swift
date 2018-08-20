//
//  LoginView.swift
//  FlowTestController
//
//  Created by Кирилл on 16.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

protocol LoginView: BaseView {
    var onCompleteAuth: (() -> Void)? { get set }
    var onSignUpButtonTap: (() -> Void)? { get set }
    var onDismissTap: (() -> Void)? { get set }
}
