//
//  TabbarCoordinatrorOutput.swift
//  FlowTestController
//
//  Created by Кирилл on 18.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol TabbarCoordinatorOutput: class {
    var finishFlow: (() -> Void)? { get set }
    var runAuthFlow: (() -> Void)? { get set }

}
