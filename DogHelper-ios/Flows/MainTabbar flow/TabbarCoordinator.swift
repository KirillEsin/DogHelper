//
//  TabbarCoordinator.swift
//  FlowTestController
//
//  Created by Кирилл on 16.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import UIKit

class TabbarCoordinator: BaseCoordinator, TabbarCoordinatorOutput {
    var finishFlow: (() -> Void)?
    var runAuthFlow: (() -> Void)?
    
    private let tabbarView: TabbarView!
    private let coordinatorFactory: CoordinatorFactory!
    private let router: Router
    
    init(tabbarView: TabbarView, coordinatorFactory: CoordinatorFactory, router: Router) {
        self.tabbarView = tabbarView
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    override func start() {
        tabbarView.onViewDidLoad = runArticlesFlow()
        tabbarView.onArticlesFlowSelect = runArticlesFlow()
        tabbarView.onUserFlowSelect = runUserProfileFlow()
        tabbarView.onChatFlowSelect = runChatFlow()
        tabbarView.signOutHandler = {[weak self] in
            self?.finishFlow?()
        }
        tabbarView.onAuthFlow = {[weak self] in
            self?.runAuthFlow?()
        }
    }
    
    private func runArticlesFlow() -> ((UINavigationController) -> ()) {
        return { navController in
            if navController.viewControllers.isEmpty == true {
                let articlesCoordinator = self.coordinatorFactory.makeArticlesCoordinator(navController: navController)
                articlesCoordinator.start()
                self.addDependency(articlesCoordinator)
            }
        }
    }
    
    private func runUserProfileFlow() -> ((UINavigationController) -> ()) {
        return { navController in
            if navController.viewControllers.isEmpty == true {
                let userProfileCoordinator = self.coordinatorFactory.makeUserProfileCoordinator(navController: navController)
                userProfileCoordinator.start()
                userProfileCoordinator.parent = self.parent
                self.addDependency(userProfileCoordinator)
            }
        }
    }
    
    private func runChatFlow() -> ((UINavigationController) -> ()) {
        return { navController in
            if navController.viewControllers.isEmpty == true {
                let createPostCoordinator = self.coordinatorFactory.makeChatCoordinator(navController: navController)
                createPostCoordinator.start()
                self.addDependency(createPostCoordinator)
            }
        }
    }
}
