//
//  UserProfileOutput.swift
//  Malmo
//
//  Created by Кирилл on 29.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol UserProfileCoordinatorOutput {
    var finishFlow: (() -> ())? { get set }
}
