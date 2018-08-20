//
//  ItemCoordinatorOutput.swift
//  FlowTestController
//
//  Created by Кирилл on 17.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol ArticlesCoordinatorOutput: class {
    var finishFlow: (() -> Void)? { get set }
}
