//
//  UserProfileCoordinator.swift
//  Malmo
//
//  Created by Кирилл on 29.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

class UserProfileCoordinator: BaseCoordinator, UserProfileCoordinatorOutput {
    
    var finishFlow: (() -> ())?
    
    private let factory: UserProfileModuleFactory
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    var userProfileOutput: UserProfileView?
    
    init(factory: UserProfileModuleFactory, router: Router, coordinatorFactory: CoordinatorFactory) {
        self.factory = factory
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showUserProfile()
    }
    
    private func showUserProfile() {
        let userProfileOutput = factory.makeUserProfileOutput()
        self.userProfileOutput = userProfileOutput
        userProfileOutput.didTapOnSelectBreed = {[weak self] in
            self?.showSelectBreed()
        }
        
        router.setRootModule(userProfileOutput, hideBar: false)
    }
    
    private func showSelectBreed() {
        var (coordinator, module) = coordinatorFactory.makeSelectBreedBox()
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.router.dismissModule()
            self?.removeDependency(coordinator)
        }
        
        coordinator.didSelectBreed = {[weak self, weak coordinator] breed in
            self?.router.dismissModule()
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        router.present(module)
        coordinator.start()
    }
}
    
    

