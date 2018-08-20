import UIKit
import Foundation

protocol CoordinatorFactory {
  
    func makeTabbarCoordinator() -> (configurator: Coordinator & TabbarCoordinatorOutput, toPresent: Presentable?)
    
    func makeAuthCoordinatorBox() -> (configurator: Coordinator & AuthCoordinatorOutput, toPresent: Presentable?)
    func makeAuthCoordinatorBox(navController: UINavigationController?) -> (configurator: Coordinator & AuthCoordinatorOutput, toPresent: Presentable?)
    
    
    func makeArticlesCoordinator(navController: UINavigationController?) -> Coordinator 
    func makeArticlesCoordinator() -> Coordinator
    
    func makeUserProfileCoordinator(navController: UINavigationController?) -> Coordinator & UserProfileCoordinatorOutput
    
    func makeChatCoordinator(navController: UINavigationController?) -> Coordinator
    
    func makeSelectBreedBox() -> (configurator: Coordinator & SelectBreedCoordinatorOutput, toPresent: Presentable?)
    func makeSelectBreedBox(navController: UINavigationController?) -> (configurator: Coordinator & SelectBreedCoordinatorOutput, toPresent: Presentable?)
    
    
//  func makeAuthCoordinatorBox(router: Router) -> Coordinator & AuthCoordinatorOutput
//  
//  func makeOnboardingCoordinator(router: Router) -> Coordinator & OnboardingCoordinatorOutput
//  
//  func makeItemCoordinator(navController: UINavigationController?) -> Coordinator
//  func makeItemCoordinator() -> Coordinator
//  
//  func makeSettingsCoordinator() -> Coordinator
//  func makeSettingsCoordinator(navController: UINavigationController?) -> Coordinator
//  
//  func makeItemCreationCoordinatorBox() ->
//    (configurator: Coordinator & ItemCreateCoordinatorOutput,
//    toPresent: Presentable?)
//  
//  func makeItemCreationCoordinatorBox(navController: UINavigationController?) ->
//    (configurator: Coordinator & ItemCreateCoordinatorOutput,
//    toPresent: Presentable?)
}
