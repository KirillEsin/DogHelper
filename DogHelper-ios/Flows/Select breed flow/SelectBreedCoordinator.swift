//
//  SelectBreedCoordinator.swift
//  DogHelper-ios
//
//  Created by Кирилл on 28.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol SelectBreedCoordinatorOutput: class {
    var finishFlow: (() -> ())? { get set }
    var didSelectBreed: ((BreedProtocol) -> Void)? { get set }
}

class SelectBreedCoordinator: BaseCoordinator, SelectBreedCoordinatorOutput {
    
    var finishFlow: (() -> ())?
    var didSelectBreed: ((BreedProtocol) -> Void)?
    
    private let factory: SelectBreedModuleFactory
    private let router: Router
    var showSelectBreedOutput: SelectBreedView?
    
    init(factory: SelectBreedModuleFactory, router: Router) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showSelectBreed()
    }
    
    private func showSelectBreed () {
        let showSelectBreedOutput = factory.makeSelectBreedOutput()
        self.showSelectBreedOutput = showSelectBreedOutput
        showSelectBreedOutput.onDismissTap = {[weak self] in
            self?.finishFlow?()
        }
        
        showSelectBreedOutput.didSelectBreed = {[weak self] breed in
            self?.didSelectBreed?(breed)
        }
        
        showSelectBreedOutput.onDetectBreedTap = {[weak self] in
            self?.showDetectPhotoOutput()
        }
        
        router.setRootModule(showSelectBreedOutput, hideBar: false)
    }
    
    private func showDetectPhotoOutput() {
        let makeMLBreedOutput = factory.makeMLBreedOutput()
        makeMLBreedOutput.didSelectBreed = {[weak self] breedName in
            self?.showSelectBreedOutput?.setDetectedBreed(breedName)
            self?.showSelectBreedOutput?.onDismissTap = {[weak self] in
                self?.finishFlow?()
            }
        }
        
        router.push(makeMLBreedOutput)
    }
}
