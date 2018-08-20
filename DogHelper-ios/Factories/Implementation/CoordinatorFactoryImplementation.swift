import UIKit
import Foundation

final class CoordinatorFactoryImplementation: CoordinatorFactory {
  
    func makeTabbarCoordinator() -> (configurator: Coordinator & TabbarCoordinatorOutput, toPresent: Presentable?) {
        let controller = TabbarController()
        let coordinator = TabbarCoordinator(tabbarView: controller, coordinatorFactory: CoordinatorFactoryImplementation(), router: router(nil))
        return (coordinator, controller)
    }
    
    func makeArticlesCoordinator() -> Coordinator {
        return makeArticlesCoordinator(navController: nil)
    }
    
    func makeArticlesCoordinator(navController: UINavigationController?) -> Coordinator {
        let coordinator = ArticlesCoordinator(coordinatorFactory: CoordinatorFactoryImplementation(), factory: ModuleFactoryImplementation(), router: router(navController))
        return coordinator
    }
    
    func makeAuthCoordinatorBox() -> (configurator: AuthCoordinatorOutput & Coordinator, toPresent: Presentable?) {
        return makeAuthCoordinatorBox(navController: navigationController(nil))
    }
    
    func makeAuthCoordinatorBox(navController: UINavigationController?) -> (configurator: AuthCoordinatorOutput & Coordinator, toPresent: Presentable?) {
        let router = self.router(navController)
        //let controller = LoginController()
        let coordinator = AuthCoordinator(router: router, factory: ModuleFactoryImplementation())
        return (coordinator, router)
    }
  
    func makeUserProfileCoordinator(navController: UINavigationController?) -> Coordinator & UserProfileCoordinatorOutput {
        let coordinator = UserProfileCoordinator(factory: ModuleFactoryImplementation(), router: router(navController), coordinatorFactory: CoordinatorFactoryImplementation())
        return coordinator
    }
    
    func makeChatCoordinator(navController: UINavigationController?) -> Coordinator {
        let coordinator = ChatCoordinator(factory: ModuleFactoryImplementation(), router: router(navController))
        return coordinator
    }
    
    func makeSelectBreedBox() ->
        (configurator: Coordinator & SelectBreedCoordinatorOutput,
        toPresent: Presentable?) {
            
            return makeSelectBreedBox(navController: navigationController(nil))
    }
    
    func makeSelectBreedBox(navController: UINavigationController?) ->
        (configurator: Coordinator & SelectBreedCoordinatorOutput,
        toPresent: Presentable?) {
            
            let router = self.router(navController)
            let coordinator = SelectBreedCoordinator(factory: ModuleFactoryImplementation(), router: router)
            return (coordinator, router)
    }
    
//  func makeAuthCoordinatorBox(router: Router) -> Coordinator & AuthCoordinatorOutput {
//
//    let coordinator = AuthCoordinator(router: router, factory: ModuleFactoryImp())
//    return coordinator
//  }
//
//  func makeItemCoordinator() -> Coordinator {
//    return makeItemCoordinator(navController: nil)
//  }
//
//  func makeOnboardingCoordinator(router: Router) -> Coordinator & OnboardingCoordinatorOutput {
//    return OnboardingCoordinator(with: ModuleFactoryImp(), router: router)
//  }
  
//  func makeItemCoordinator(navController: UINavigationController?) -> Coordinator {
//    let coordinator = ItemCoordinator(
//      router: router(navController),
//      factory: ModuleFactoryImp(),
//      coordinatorFactory: CoordinatorFactoryImp()
//    )
//    return coordinator
//  }
//
//  func makeSettingsCoordinator() -> Coordinator {
//    return makeSettingsCoordinator(navController: nil)
//  }
//
//  func makeSettingsCoordinator(navController: UINavigationController? = nil) -> Coordinator {
//    let coordinator = SettingsCoordinator(router: router(navController), factory: ModuleFactoryImp())
//    return coordinator
//  }
//
//  func makeItemCreationCoordinatorBox() ->
//    (configurator: Coordinator & ItemCreateCoordinatorOutput,
//    toPresent: Presentable?) {
//
//      return makeItemCreationCoordinatorBox(navController: navigationController(nil))
//  }
//  func makeItemCreationCoordinatorBox(navController: UINavigationController?) ->
//    (configurator: Coordinator & ItemCreateCoordinatorOutput,
//    toPresent: Presentable?) {
//
//      let router = self.router(navController)
//      let coordinator = ItemCreateCoordinator(router: router, factory: ModuleFactoryImp())
//      return (coordinator, router)
//  }
  
  private func router(_ navController: UINavigationController?) -> Router {
    return RouterImplementation(rootController: navigationController(navController))
  }
  
  private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
    if let navController = navController { return navController }
    else { return UINavigationController.controllerFromStoryboard(.main) }
  }
}
