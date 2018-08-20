import UIKit
import Foundation

fileprivate var onboardingWasShown = false
fileprivate var isAutorized = false

fileprivate enum LaunchInstructor {
  case main, auth, onboarding
  
  static func configure(
    tutorialWasShown: Bool = onboardingWasShown,
    isAutorized: Bool = isAutorized) -> LaunchInstructor {
    
    switch (tutorialWasShown, isAutorized) {
      case (true, false), (false, false): return .auth
      case (false, true): return .onboarding
      case (true, true): return .main
    }
  }
}

final class ApplicationCoordinator: BaseCoordinator {
  
  private let coordinatorFactory: CoordinatorFactory
  private let router: Router
  
  private var instructor: LaunchInstructor {
    return LaunchInstructor.configure()
  }
  
  init(router: Router, coordinatorFactory: CoordinatorFactory) {
    self.router = router
    self.coordinatorFactory = coordinatorFactory
  }
  
    override func start() {
        runMainFlow()
    }
  
    private func runAuthFlow() {
        let (coordinator, module) = coordinatorFactory.makeAuthCoordinatorBox()
        coordinator.dismissFlow = {[weak self] in
            self?.router.dismissModule()
        }
        
        coordinator.finishFlow = {[weak self] in
            self?.router.dismissModule()
        }
        
        router.present(module)
        addDependency(coordinator)
        coordinator.start()
    }
  
  private func runOnboardingFlow() {
//    let coordinator = coordinatorFactory.makeOnboardingCoordinator(router: router)
//    coordinator.finishFlow = { [weak self, weak coordinator] in
//      onboardingWasShown = true
//      self?.start()
//      self?.removeDependency(coordinator)
//    }
//    addDependency(coordinator)
//    coordinator.start()
  }
  
    private func runMainFlow() {
        let (coordinator, module) = coordinatorFactory.makeTabbarCoordinator()
        //        coordinator.finishFlow = {[weak self] in
        //            isAutorized = false
        //            self?.start()
        //            self?.removeDependency(coordinator)
        //        }
        coordinator.runAuthFlow = {[weak self] in
            self?.runAuthFlow()
        }
        coordinator.parent = self
        addDependency(coordinator)
        router.setRootModule(module, hideBar: true)
        coordinator.start()
    }
}
