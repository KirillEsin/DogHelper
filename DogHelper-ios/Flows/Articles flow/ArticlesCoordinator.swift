//
//  ItemCoordinator.swift
//  FlowTestController
//
//  Created by Кирилл on 17.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import CoreLocation

class ArticlesCoordinator: BaseCoordinator, ArticlesCoordinatorOutput {
    var finishFlow: (() -> Void)?
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    private let factory: ArticleModuleFactory
    
    init(coordinatorFactory: CoordinatorFactory, factory: ArticleModuleFactory, router: Router) {
        self.coordinatorFactory = coordinatorFactory
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showProducts()
    }
    
//    private func runAuthFlow() {
//        let (coordinator, module) = coordinatorFactory.makeAuthCoordinatorBox()
//        coordinator.dismissFlow = {[weak self] in
//            self?.router.dismissModule()
//        }
//
//        coordinator.finishFlow = {[weak self] in
//            self?.router.dismissModule()
//        }
//
//        router.present(module)
//        addDependency(coordinator)
//        coordinator.start()
//    }
    
    private func showProducts() {
        let articlesOutput = factory.makeArticlesOutput()

        router.setRootModule(articlesOutput, hideBar: false)
    }
    
}
