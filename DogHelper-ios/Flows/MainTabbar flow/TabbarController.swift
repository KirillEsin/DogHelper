//
//  TabbarController.swift
//  FlowTestController
//
//  Created by Кирилл on 17.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import UIKit

class TabbarController: UITabBarController, UITabBarControllerDelegate, TabbarView {
    
    var onAuthFlow: (() -> Void)?
    var signOutHandler: (() -> Void)?
    var onArticlesFlowSelect: ((UINavigationController) -> ())?
    var onUserFlowSelect: ((UINavigationController) -> ())?
    var onChatFlowSelect: ((UINavigationController) -> ())?
    var onViewDidLoad: ((UINavigationController) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        view.backgroundColor = .white
        title = "Tab bar"
        tabBar.isTranslucent = true
        tabBar.tintColor = ColorPalette.mainColor
 
        let articlesController = UINavigationController.controllerFromStoryboard(.main)
        articlesController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "articles"), selectedImage: #imageLiteral(resourceName: "articles_selected"))

        let calendarController = UINavigationController.controllerFromStoryboard(.main)
        calendarController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "calendar"), selectedImage: #imageLiteral(resourceName: "calendar_selected"))
        
        let userController = UINavigationController.controllerFromStoryboard(.main)
        userController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "account"), selectedImage: #imageLiteral(resourceName: "account_selected"))
        
        let chatController = UINavigationController.controllerFromStoryboard(.main)
        chatController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "chat"), selectedImage: #imageLiteral(resourceName: "chat_selected"))
        
        let viewcontrollerList = [articlesController, chatController,  calendarController, userController]
        viewControllers = viewcontrollerList
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let controller = customizableViewControllers?.first as? UINavigationController {
            onViewDidLoad?(controller)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controller = viewControllers?[selectedIndex] as? UINavigationController else {
            return
        }
        
        switch selectedIndex {
        case 0:
            onArticlesFlowSelect?(controller)
        case 1:
            onChatFlowSelect?(controller)
        //case 2:
            //onMaterialsFlowSelect?(controller)
        case 2:
            onUserFlowSelect?(controller)
        default:
            break
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == tabBarController.viewControllers?[0] {
            return true
        }
        
        if UserManager.shared.userUid == nil {
            onAuthFlow?()
            return false
        }
        return true
    }

}

