//
//  CalendarController.swift
//  DogHelper-ios
//
//  Created by Кирилл on 31.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol CalendarView: BaseView {
    
}

class CalendarController: BaseViewController, CalendarView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
}

extension CalendarController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
