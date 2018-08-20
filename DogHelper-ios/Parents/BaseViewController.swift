//
//  BaseViewController.swift
//  G12
//
//  Created by Кирилл on 15.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import UIKit
import Reachability
import SwiftMessages

class BaseViewController: UIViewController {

    var statusView: MessageView = {
        let statusView = MessageView.viewFromNib(layout: .statusLine)
        statusView.backgroundView.backgroundColor = UIColor.red
        statusView.bodyLabel?.textColor = UIColor.white
        statusView.configureContent(body: "Интернет соединение отсутствует")
        return statusView
    }()
    
    var statusViewConfig: SwiftMessages.Config = {
        var statusConfig = SwiftMessages.defaultConfig
        statusConfig.duration = .forever
        statusConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        statusConfig.preferredStatusBarStyle = .lightContent
        return statusConfig
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ReachabilityManager.shared.addListener(listener: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ReachabilityManager.shared.removeListener(listener: self)
    }
}

extension BaseViewController: NetworkStatusListener {
    
    func networkStatusDidChange(status: Reachability.Connection) {
        
        switch status {
        case .none:
            showUnreachableView()
            debugPrint("BaseViewController: Network became unreachable")
        case .wifi:
            showReachableView()
            debugPrint("BaseViewController: Network reachable through WiFi")
        case .cellular:
            showReachableView()
            debugPrint("BaseViewController: Network reachable through Cellular Data")
        }
    }
    
    func showUnreachableView() {
        SwiftMessages.show(config: statusViewConfig, view: statusView)
    }
    
    func showReachableView() {
        SwiftMessages.hide()
    }
}
