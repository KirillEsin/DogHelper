//
//  AuthCoordinatroOutput.swift
//  FlowTestController
//
//  Created by Кирилл on 16.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

protocol AuthCoordinatorOutput: class {
    var finishFlow: (() -> Void)? { get set }
    var dismissFlow: (() -> Void)? { get set }
}
