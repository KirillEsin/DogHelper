//
//  TabbarView.swift
//  FlowTestController
//
//  Created by Кирилл on 17.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import UIKit

protocol TabbarView: class {
    var onArticlesFlowSelect: ((UINavigationController) -> ())? { get set }
    var onUserFlowSelect: ((UINavigationController) -> ())? { get set }
    var onChatFlowSelect: ((UINavigationController) -> ())? { get set }
    var onViewDidLoad: ((UINavigationController) -> ())? { get set }
    var onAuthFlow: (() -> Void)? { get set }
    var signOutHandler: (() -> Void)? { get set }
}
