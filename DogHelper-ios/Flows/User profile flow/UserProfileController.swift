//
//  UserProfileController.swift
//  DogHelper-ios
//
//  Created by Кирилл on 25.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol UserProfileView: BaseView {
    var didTapOnSelectBreed: (() -> Void)? { get set }
    
}

class UserProfileController: UITableViewController, UserProfileView {
    
    var didTapOnSelectBreed: (() -> Void)?
    
    lazy var headerTableView: UserProfileHeader = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 170)
        let headerTableView = UserProfileHeader(frame: frame)
        return headerTableView
    }()
    
    var viewModel: UserProfileViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }
    
    func setupTableView() {
        navigationItem.title = viewModel.navigationTitle
        tableView.tableHeaderView = headerTableView
    }
    
    func bindViewModel() {
        viewModel.didUpdate = {[weak self] in
            self?.tableView.reloadData()
            self?.headerTableView.viewModel = self?.viewModel.headerViewModel 
        }
        
        headerTableView.didTapOnSelectBreed = {[weak self] in
            self?.didTapOnSelectBreed?()
        }
    }
}
