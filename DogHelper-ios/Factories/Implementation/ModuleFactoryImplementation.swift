//
//  ModuleFactoryImplementation.swift
//  DogHelper-ios
//
//  Created by Кирилл on 22.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
class ModuleFactoryImplementation:
    ArticleModuleFactory,
    AuthModuleFactory,
    UserProfileModuleFactory,
    SelectBreedModuleFactory,
    ChatModuleFactory {
    
    private let networkManager = NetworkManager()
    
    func makeArticlesOutput() -> ArticlesView {
        let model = ArticlesModel(dataManager: networkManager)
        let viewModel = ArticlesViewModel(model: model)
        let collectionViewLayout = GridLayout()
        let vc = ArticlesCollectionController(collectionViewLayout: collectionViewLayout)
        vc.viewModel = viewModel
        return vc
    }
    
    func makeLoginOutput() -> LoginView {
        let loginModel = LoginModel(dataManager: networkManager)
        let loginViewModel = LoginViewModel(model: loginModel)
        let vc = LoginController()
        vc.viewModel = loginViewModel
        return vc
    }
    
    func makeSignUpHandler() -> SignUpView {
        let signUpModel = SignUpModel(dataManager: networkManager)
        let signUpViewModel = SignUpViewModel(model: signUpModel)
        let vc = SignUpController()
        vc.viewModel = signUpViewModel
        return vc
    }
    
    func makeUserProfileOutput() -> UserProfileView {
        let model = UserProfileModel(dataManager: networkManager)
        let viewModel = UserProfileViewModel(model: model)
        let vc = UserProfileController()
        vc.viewModel = viewModel
        return vc
    }
    
    func makeSelectBreedOutput() -> SelectBreedView {
        let model = SelectBreedModel(dataManager: networkManager)
        let vc = SelectBreedController()
        vc.viewModel = model
        return vc
    }
    
    func makeMLBreedOutput() -> MLBreedView {
        return MLBreedController()
    }
    
    func makeChatOutput() -> ChatView {
        let model = ChatModel(dataManager: networkManager)
        let viewModel = ChatViewModel(model: model)
        let vc = ChatViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.viewModel = viewModel
        return vc
    }
}
