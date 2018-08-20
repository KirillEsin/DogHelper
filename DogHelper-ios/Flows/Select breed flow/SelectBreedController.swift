//
//  SelectBreedController.swift
//  DogHelper-ios
//
//  Created by Кирилл on 28.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol SelectBreedView: BaseView {
    var onDismissTap: (() -> Void)? { get set }
    var onDetectBreedTap: (() -> Void)? { get set }
    var didSelectBreed: ((BreedProtocol) -> Void)? { get set }
    
    func setDetectedBreed(_ breed: String)
}

class SelectBreedController: BaseSearchTableViewController, SelectBreedView {
    
    var didSelectBreed: ((BreedProtocol) -> Void)?
    var onDetectBreedTap: (() -> Void)?
    var onDismissTap: (() -> Void)?
    var didDetectedBreed: ((String) -> Void)?
    
    var viewModel: SelectBreedModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtonItems()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.didUpdate = {[weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.didSetBreed = {[weak self] in
            self?.onDismissTap?()
        }
    }
    
    func setDetectedBreed(_ breed: String) {
        viewModel.findBreedByName(breed)
    }
    
    private func setupBarButtonItems() {
        let dismissButton = UIBarButtonItem(image: #imageLiteral(resourceName: "cancel"), style: .plain, target: self, action: #selector(handleDismissButton))
        dismissButton.tintColor = .white
        
        let mlPhotoButtn = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(handleMlPhotoButton))
        mlPhotoButtn.tintColor = .white
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = mlPhotoButtn
    }
    
    @objc func handleDismissButton() {
        onDismissTap?()
    }
    
    @objc func handleMlPhotoButton() {
        onDetectBreedTap?()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.item(at: indexPath.row)
        let cell: UITableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.textLabel?.text = item.breed
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.item(at: indexPath.row)
        viewModel.setSelectedBreed(at: indexPath.row)
        didSelectBreed?(item)
    }
    
}
